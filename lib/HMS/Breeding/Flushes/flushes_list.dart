import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/HMS/Breeding/Flushes/flushes_details.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'embryo_retrieval_form.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'flushes_update.dart';
import 'utils/flushes_services_json.dart';



class flushes_list extends StatefulWidget{
  String token;
  flushes_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _flushes_list(token);
  }
}

class _flushes_list extends State<flushes_list>{
  String token;
  _flushes_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var flushes_list;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_flushes(token)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Flushes"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.openBox("FlushesList").then((response){
            Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                pd.show();
                FlushesServicesJson.flusheslist(token).then((response){
                  pd.dismiss();
                  if(response!=null){
                    setState(() {
                      isVisible=true;
                      flushes_list=json.decode(response);
                      Hive.box("FlushesList").put("offline_flushes_list",flushes_list);
                    });

                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("List Not Available"),
                    ));
                    setState(() {
                      isVisible=false;
                    });
                  }
                });
              }else{
                setState(() {
                  isVisible=true;
                  flushes_list=Hive.box("FlushesList").get("offline_flushes_list");
                });
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      backgroundColor: Colors.red,
//                      content: Text("Network not Available"),
//                    ));
              }
            });
          });
        },
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:flushes_list!=null?flushes_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_update(token,flushes_list[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          FlushesServicesJson.flushesvisibilty(token, flushes_list[index]['id']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                flushes_list.removeAt(index);
                              });

                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.red ,
                                content: Text('Failed'),
                              ));
                            }
                          });
                        },
                      ),
                    ],
                    child: FadeAnimation(2.0,
                       ListTile(
                        title: Text(flushes_list!=null?flushes_list[index]['horseName']['name']:''),
                      // subtitle: Text(flushes_list!=null?flushes_list[index]['vetName']['contactName']['name']:''),
                        //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => flushes_details_page(flushes_list[index])));

                        },
                      ),
                    )
                ),
                Divider(),
              ],
            );
          }),
        ),
      ),
    );
  }


}