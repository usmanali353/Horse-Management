import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Dashboard/AuditLog/AuditLog.dart';
import 'package:horse_management/HMS/Dashboard/graphs.dart';

class dashboardMainPage extends StatefulWidget{
  String token;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardMainPageState(token);
  }

  dashboardMainPage(this.token);

}
class dashboardMainPageState extends State<dashboardMainPage>{
  String token;

  dashboardMainPageState(this.token);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("Dashboard"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Insights",),
                Tab(text: "Audit Logs",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              graphs(token),
            audit_log(token),
            ],
          ),
        )
    );
  }

}