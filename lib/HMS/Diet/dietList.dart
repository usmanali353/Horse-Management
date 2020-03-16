import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Diet/add_Diet.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class dietList extends StatefulWidget{
  String token;

  dietList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dietListState(token);
  }

}
class dietListState extends State<dietList>{
  String token;
  var diet_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diets")),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addDiet()));
        },

      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              DietServices.newDietList(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    diet_list=json.decode(response);
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Diet Plans List Not Found"),
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
          child: ListView.builder(itemCount:diet_list!=null?diet_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            DietServices.newDietVisibilty(token, diet_list[index]['dietId']).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  diet_list.removeAt(index);
                                });
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
                    IconSlideAction(
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: () async {
                       // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(diet_list!=null?diet_list[index]['name']:''),
                    leading: Icon(Icons.fastfood,size: 40,color: Colors.teal,),
                    onTap: (){
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

  dietListState(this.token);

}