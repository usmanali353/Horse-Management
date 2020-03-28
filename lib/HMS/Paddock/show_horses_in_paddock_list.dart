import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class show_horses_in_paddock extends StatefulWidget{
  String token;
  var paddock_data;
  show_horses_in_paddock(this.token,this.paddock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _show_horses_in_paddock(token,paddock_data);
  }

}
class _show_horses_in_paddock extends State<show_horses_in_paddock>{
  String token;
  var paddock_data;
  var horse_list;
  var already_trained_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Horses List"),
      ),
      body: RefreshIndicator(

        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              PaddockServices.getPaddockDetails(token,paddock_data['id']).then((response){
                pd.dismiss();
                if(response!=null){
                  print(response);
                  setState(() {
                    isvisible=true;
                    horse_list=json.decode(response);
                  });

                }else{
//
                }
              });
            }else{

            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: ListView.builder(itemCount:horse_list!=null?horse_list.length:temp.length,itemBuilder: (context,int index){
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
                            PaddockServices.delete_horses_from_paddock(token, horse_list[index]['paddockId']).then((response){
                              pd.dismiss();
                              if(response!=null){
//
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
                              }else{
//
                              }
                            });
                          }else{

                          }
                        });

                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(horse_list!=null?horse_list[index]['horseName']['name']:''),
//                    trailing: Text(already_trained_list!=null?already_trained_list[index]['startDate'].replaceAll("T00:00:00",''):''),
//                    subtitle: Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                    leading: Image.asset("assets/horse_icon.png"),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(already_trained_list[index],'')));
//                    },
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

  _show_horses_in_paddock(this.token,this.paddock_data);
//  String get_training_type_by_id(int id){
//    var training_type_name;
//    for (int i=0;i<already_trained_list.length;i++){
//      if(id==1){
//        training_type_name="Simple";
//      }else if(id==2){
//        training_type_name='Endurance';
//      }else if(id==3){
//        training_type_name="Customized";
//      }else if(id==4){
//        training_type_name="Speed";
//      }
//    }
//    return training_type_name;
//  }
}