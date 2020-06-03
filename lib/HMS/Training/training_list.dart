import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/session_list.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
import 'Add_training.dart';
class training_list extends StatefulWidget{
  String token;

  training_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }

}
class _training_list_state extends State<training_list>{
  String token;
  var horse_list;
  var training_list=[],today_training_list=[], load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;

  var temp=['',''];
  bool isvisible=false;
  var trainingListBox;
  int pagenum=1,total_page;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("Health Record"),actions: <Widget>[
//        Center(child: Text("Add New",textScaleFactor: 1.3,)),
//        IconButton(
//
//          icon: Icon(
//            Icons.add,
//            color: Colors.white,
//          ),
//          onPressed: () {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => add_training(token)),);
//          },
//        )
//      ],),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                  if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        network_operations.get_training(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            training_list = load_list['response'];
                            print(training_list);
                          });
                        });
                      }else
                        print("network nahi hai");
                    });
                  }
                  else{
                    print("list empty");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum > 1){
                    pagenum = pagenum - 1;
                  }
                  print(pagenum);
                }),
                FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                  print(load_list['hasNext']);
                  if(load_list['hasNext'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        network_operations.get_training(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            training_list = load_list['response'];
                            print(training_list);
                          });
                        });
                      }else
                        print("network nahi hai");
                    });
                  }
                  else{
                    print("list empty");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum < total_page) {
                    pagenum = pagenum + 1;
                  }
                  print(pagenum);

                })
              ]
          )
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.openBox('trainingList').then((response){
            Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                pd.show();
                network_operations.get_training(token,1).then((response){
                  pd.dismiss();
                  if(response!=null){
                    setState(() {
                      isvisible=true;
                      load_list=json.decode(response);
                      training_list = load_list['response'];

                      for(int i=0;i<training_list.length;i++){
                        if(DateTime.parse(training_list[i]['startDate'])==DateTime.now()){
                          today_training_list.add(training_list[i]);
                        }
                      }
                      Hive.box("trainingList").put("offline_training_list",training_list);
                      // print('Training list Length'+training_list.length.toString());
                    });

                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Training List Not Found"),
                    ));
                    setState(() {
                      isvisible=false;
                    });
                  }
                });
              }else{
                setState(() {
                  isvisible=true;
                  training_list=Hive.box("trainingList").get("offline_training_list");
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
          visible: isvisible,
          child: ListView.builder(itemCount:training_list!=null?training_list.length:temp.length,itemBuilder: (context,int index){
            return  Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      icon: Icons.list,
                      color: Colors.green,
                      caption: 'Sessions',
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => training_session_list(token, training_list[index])));
                      },
                    ),
                  ],
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Utils.check_connectivity().then((result) {
                          if (result) {
                            ProgressDialog pd = ProgressDialog(context,
                                type: ProgressDialogType.Normal,
                                isDismissible: true);
                            pd.show();
                            network_operations
                                .change_training_visibility(token,
                                training_list[index]['trainingId'])
                                .then((response) {
                              pd.dismiss();
                              if (response != null) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Visibility Changed'),
                                    ));
                                setState(() {
                                  training_list.removeAt(index);
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Failed'),
                                    ));
                              }
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Network not Available"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      },
                    ),
                    IconSlideAction(
                      color: Colors.green,
                      caption: "End Training",
                      icon: FontAwesomeIcons.check,
                      onTap: () async {
                        Utils.check_connectivity().then((result) {
                          if (result) {
                            var pd = ProgressDialog(context,
                                type: ProgressDialogType.Normal,
                                isDismissible: true);
                            pd.show();
                            network_operations.end_training(token,
                                training_list[index]['trainingId'])
                                .then((response) {
                              pd.dismiss();
                              if (response != null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) =>
                                    _refreshIndicatorKey.currentState
                                        .show());
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Training Ended"),
                                      backgroundColor: Colors.green,
                                    ));
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Training not Ended"),
                                      backgroundColor: Colors.red,
                                    ));
                              }
                            });
                          } else {
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
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => update_training(
                                token, training_list[index])));
                      },
                    ),
                  ],
                  child: FadeAnimation(2.0,
                    ListTile(
                      title: Text(training_list != null
                          ? training_list[index]['horseName']['name']
                          : ''),
                      trailing: Text(training_list != null
                          ? training_list[index]['startDate']
                          .toString()
                          .replaceAll("T00:00:00", '')
                          : ''),
                      subtitle: Text(training_list != null
                          ? get_training_type_by_id(
                          training_list[index]['trainingType'])
                          : ''),
                      leading: Icon(Icons.fitness_center, size: 40,
                        color: Colors.teal,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => training_details_page(training_list[index], get_training_type_by_id(training_list[index]['trainingType']))));
                      },
                    ),
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }

  _training_list_state(this.token);
  String get_training_type_by_id(int id){
    var training_type_name;
    for (int i=0;i<training_list.length;i++){
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