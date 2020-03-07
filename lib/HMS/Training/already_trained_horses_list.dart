import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  bool horses_list_loaded=false;
  ProgressDialog pd;
  var already_trained_horses;
  _already_trained_horses_list_state(token);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    // TODO: implement initState
    pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
   WidgetsBinding.instance
     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

    network_operations.get_horses_already_trained(token).then((response){
      if(response!=null){
        setState(() {
          horses_list_loaded=true;
          already_trained_horses=json.decode(response);
          print(response);
        });
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Already Trained Horses list not found"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Already Trained Horses"),),
      body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return Utils.check_connectivity().then((result){
                if(result){
                  network_operations.get_horses_already_trained(token).then((response){
                    if(response!=null){
                      setState(() {
                        horses_list_loaded=true;
                        already_trained_horses=json.decode(response);
                        print(response);
                      });
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Already Trained Horses list not found"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  });
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("NetWork not Available"),
                    backgroundColor: Colors.red,
                  ));
                }
              });
            },
            child: Visibility(
              visible: horses_list_loaded,
              child: ListView.builder(itemBuilder: (context,int index){
                return Column(
                  children: <Widget>[
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      child: ListTile(
                        title: Text("aaaa"),
                        subtitle: Text("bbbb"),
                        leading: Image.asset("Assets/horse_icon.png"),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: "Delete",
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async{

                            Utils.check_connectivity().then((result){
                              if(result){
                                pd.style(message: "Deleting Already Trained Horse...");
                                pd.show();
                                network_operations.delete_already_trained_horses(token, already_trained_horses[index]['horseId']).then((response){
                                  pd.dismiss();
                                  if(response!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Already Trained Horse Deleted"),
                                      backgroundColor: Colors.green,
                                    ));
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Already Trained Horse not Deleted"),
                                      backgroundColor: Colors.red,
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
                        )
                      ],
                    )

                  ],
                );
              }),
            ),
          ),
    );
  }

}