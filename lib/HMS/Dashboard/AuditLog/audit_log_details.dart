import 'package:flutter/material.dart';

class audit_log_details_page extends StatefulWidget{
  var audit_log_data;


  audit_log_details_page(this.audit_log_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _audit_log_details_page(audit_log_data);
  }

}
class _audit_log_details_page extends State<audit_log_details_page>{
  var audit_log_data;
  String status_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Audit Log Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("ID: "),
                trailing: Text(audit_log_data['id'].toString()!=null?audit_log_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Activity Name"),
                trailing: Text(audit_log_data['activityName'].toString()!=null?audit_log_data['activityName'].toString():''),
              ),
              ListTile(
                title: Text("Action: "),
                subtitle: Text(audit_log_data['action'].toString()!=null?audit_log_data['action'].toString():''),
              ),
              ListTile(
                title: Text("Created On"),
                trailing: Text(audit_log_data['createdOn'].toString()!=null?audit_log_data['createdOn'].toString():''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _audit_log_details_page(this.audit_log_data);


}