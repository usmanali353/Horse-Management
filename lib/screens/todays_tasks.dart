import 'package:flutter/material.dart';

class todays_tasks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _todays_tasks_state();
  }

}
class _todays_tasks_state extends State<todays_tasks>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Task 1"),
          leading: Icon(Icons.event_available),
          subtitle: Text("Task Date"),
        ),
        ListTile(
          title: Text("Task 2"),
          leading: Icon(Icons.event_available),
          subtitle: Text("Task Date"),
        ),
        ListTile(
          title: Text("Task 3"),
          leading: Icon(Icons.event_available),
          subtitle: Text("Task Date"),
        ),
        ListTile(
          title: Text("Task 4"),
          leading: Icon(Icons.event_available),
          subtitle: Text("Task Date"),
        ),
      ],
    );
  }

}