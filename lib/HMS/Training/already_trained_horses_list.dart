import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class already_trained_horses_list extends StatefulWidget{
  String token;

  already_trained_horses_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _already_trained_horses_list_state(token);
  }

}
class _already_trained_horses_list_state extends State<already_trained_horses_list>{
  String token;
  var horse_list;
  var already_trained_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.get_horses_already_trained(token).then((response){
                pd.dismiss();
                if(response!=null){
                  print(response);
                  setState(() {
                    isvisible=true;
                    already_trained_list=json.decode(response);
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Trained horses List Not Found"),
                  ));
                  setState(() {
                    isvisible=false;
                  });
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: ListView.builder(itemCount:already_trained_list!=null?already_trained_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.delete,
                      color: Colors.red,
                      caption: 'Delete',
                      onTap: () async {
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            network_operations.delete_already_trained_horses(token, already_trained_list[index]['trainingId']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Horse Deleted'),
                                ));
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.red ,
                                  content: Text('Failed'),
                                ));
                              }
                            });
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Network not Available"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });

                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(already_trained_list!=null?already_trained_list[index]['horseName']['name']:''),
                    trailing: Text(already_trained_list!=null?already_trained_list[index]['startDate'].replaceAll("T00:00:00",''):''),
                    subtitle: Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                    leading: Image.asset("assets/horse_icon.png"),
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(already_trained_list[index],'')));
                    },
                  ),


                ),
                Divider(),
              ],

            );

          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _already_trained_horses_list_state(this.token);
  String get_training_type_by_id(int id){
    var training_type_name;
    for (int i=0;i<already_trained_list.length;i++){
      if(id==1){
        training_type_name="Simple";
      }else if(id==2){
        training_type_name='Endurance';
      }else if(id==3){
        training_type_name="Customized";
      }else if(id==4){
        training_type_name="Speed";
      }
    }
    return training_type_name;
  }
}