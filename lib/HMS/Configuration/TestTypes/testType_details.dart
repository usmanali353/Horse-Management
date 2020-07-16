import 'package:flutter/material.dart';

class testType_details_page extends StatefulWidget{
  var testtype_data;


  testType_details_page(this.testtype_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _testType_details_page(testtype_data);
  }

}
class _testType_details_page extends State<testType_details_page>{
  var testtype_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Test Type Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Test Type ID: "),
                  trailing: Text(testtype_data['id'].toString()!=null?testtype_data['id'].toString():''),
                ),
                Divider(),

                ListTile(
                  title: Text("Test Type: "),
                  trailing: Text(testtype_data['name'].toString()!=null?testtype_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Validity: "),
                  trailing: Text(testtype_data['validity'].toString()!=null?testtype_data['validity'].toString():''),
                ),
                ListTile(
                  title: Text("Reminder:"),
                  trailing: Text(testtype_data['reminder'] == true ? "Yes":"No" ),
                ),
                ListTile(
                  title: Text("Reminders(Day Before): "),
                  trailing: Text(testtype_data['reminderBeforeDays'].toString()!=null?testtype_data['reminderBeforeDays'].toString():''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(testtype_data['description'].toString()!=null?testtype_data['description'].toString():''
//                      )],
//                  ),
//                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _testType_details_page(this.testtype_data);


}