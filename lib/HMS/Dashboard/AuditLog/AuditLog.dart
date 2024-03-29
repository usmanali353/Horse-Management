import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Barns/barn_json.dart';
import 'package:horse_management/HMS/Configuration/Barns/update_barn.dart';
import 'package:horse_management/HMS/Dashboard/AuditLog/audit_log_details.dart';
import 'package:horse_management/HMS/Dashboard/dashboard_services/user_dashboard_json.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../Utils.dart';

class audit_log extends StatefulWidget{
  String token;
  audit_log(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _audit_log(token);
  }
}

class _audit_log extends State<audit_log>{
  String token;
  ScrollController customController = ScrollController();
  _audit_log(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var barn_lists;
 var auditLogs=[];
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              DashboardServices.getUserDashboardData(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    barn_lists=json.decode(response);
                    auditLogs=barn_lists['auditLog'];
                    isVisible=true;
                  });

                }else{
                  setState(() {
                    isVisible=false;
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("List Not Available"),
                  ));
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network Not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: DraggableScrollbar(
            controller: customController,
              heightScrollThumb: 38.0,
              backgroundColor: Colors.grey.shade400,
            scrollThumbBuilder: (
                Color backgroundColor,
                Animation<double> thumbAnimation,
                Animation<double> labelAnimation,
                double height, {
                  Text labelText,
                  BoxConstraints labelConstraints,
                }) {
              return FadeTransition(
                opacity: thumbAnimation,
                child: Container(
                  height: height,
                  width: 10.0,
                  color: backgroundColor,
                ),
              );
            },
              alwaysVisibleScrollThumb: true,


          child: ListView.builder(controller: customController,itemCount:auditLogs!=null?auditLogs.length:temp.length,itemBuilder: (context,int index){

            return Column(
              children: <Widget>[

                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.edit,
//                        color: Colors.blue,
//                        caption: 'Update',
//                        onTap: () async {
//                          print(barn_lists[index]);
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_barn(token,barn_lists[index])));
//                        },
//                      ),
                    ],
//                    actions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.visibility_off,
//                        color: Colors.red,
//                        caption: 'Hide',
//                        onTap: () async {
//                          BarnServices.changeBarnVisibility(token, barn_lists[index]['barnId']).then((response){
//                            print(response);
//                            if(response!=null){
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.green ,
//                                content: Text('Visibility Changed'),
//                              ));
//                              setState(() {
//                                barn_lists.removeAt(index);
//                              });
//
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.red ,
//                                content: Text('Failed'),
//                              ));
//                            }
//                          });
//                        },
//                      ),
//                    ],
                    child: FadeAnimation(2.0,
                      ListTile(
                        title: Text(auditLogs!=null?auditLogs[index]['activityName']:''),
                        subtitle: Text(auditLogs!=null?auditLogs[index]['action']:''),
//                        trailing: Text(auditLogs!=null?auditLogs[index]['createdOn']:''),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>audit_log_details_page(auditLogs[index])));
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
      ),
    );
  }


}

//child: ListView.builder(controller: customController,itemCount:auditLogs!=null?auditLogs.length:temp.length,itemBuilder: (context,int index){
//
//return Column(
//children: <Widget>[
//
//Slidable(
//actionPane: SlidableDrawerActionPane(),
//actionExtentRatio: 0.20,
//secondaryActions: <Widget>[
////                      IconSlideAction(
////                        icon: Icons.edit,
////                        color: Colors.blue,
////                        caption: 'Update',
////                        onTap: () async {
////                          print(barn_lists[index]);
////                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_barn(token,barn_lists[index])));
////                        },
////                      ),
//],
////                    actions: <Widget>[
////                      IconSlideAction(
////                        icon: Icons.visibility_off,
////                        color: Colors.red,
////                        caption: 'Hide',
////                        onTap: () async {
////                          BarnServices.changeBarnVisibility(token, barn_lists[index]['barnId']).then((response){
////                            print(response);
////                            if(response!=null){
////                              Scaffold.of(context).showSnackBar(SnackBar(
////                                backgroundColor:Colors.green ,
////                                content: Text('Visibility Changed'),
////                              ));
////                              setState(() {
////                                barn_lists.removeAt(index);
////                              });
////
////                            }else{
////                              Scaffold.of(context).showSnackBar(SnackBar(
////                                backgroundColor:Colors.red ,
////                                content: Text('Failed'),
////                              ));
////                            }
////                          });
////                        },
////                      ),
////                    ],
//child: FadeAnimation(2.0,
//ListTile(
//title: Text(auditLogs!=null?auditLogs[index]['activityName']:''),
//subtitle: Text(auditLogs!=null?auditLogs[index]['action']:''),
////                        trailing: Text(auditLogs!=null?auditLogs[index]['createdOn']:''),
//onTap: (){
//Navigator.push(context, MaterialPageRoute(builder: (context)=>audit_log_details_page(auditLogs[index])));
//},
//),
//)
//),
//Divider(),
//],
//);
//}),







//
//DraggableScrollbar(
//controller: customController,
//heightScrollThumb: 38.0,
//backgroundColor: Colors.teal,
//scrollThumbBuilder: (
//Color backgroundColor,
//    Animation<double> thumbAnimation,
//Animation<double> labelAnimation,
//    double height, {
//Text labelText,
//BoxConstraints labelConstraints,
//}) {
//return FadeTransition(
//opacity: thumbAnimation,
//child: Container(
//height: height,
//width: 10.0,
//color: backgroundColor,
//),
//);
//},
//alwaysVisibleScrollThumb: true,