import 'package:flutter/material.dart';

class operation_notes_details_page extends StatefulWidget{
  var notes_data;


  operation_notes_details_page(this.notes_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _operation_notes_details_page(notes_data);
  }

}
class _operation_notes_details_page extends State<operation_notes_details_page>{
  var notes_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Operation Notes Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Operation Notes ID: "),
                trailing: Text(notes_data['operationNoteId'].toString()!=null?notes_data['operationNoteId'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Date"),
                trailing: Text(notes_data['date'].toString()!=null?notes_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Details:"),
                trailing: Text(notes_data['details'].toString()!=null?notes_data['details'].toString():''),
              ),
              ListTile(
                title: Text("Category:"),
                trailing: Text(notes_data['generalCategoryName']['name'].toString()!=null?notes_data['generalCategoryName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Created By:"),
                trailing: Text(notes_data['createdBy'].toString()!=null?notes_data['createdBy'].toString():''),
              ),
//              ListTile(
//                title: Text("Next Fill"),
//                trailing: Text(notes_data['nextFill'].toString()!=null?notes_data['nextFill'].toString():''),
//              ),
//              ListTile(
//                title: Text("Assigned Vet"),
//                trailing: Text(notes_data['assignedVetName']['contactName']['name']!=null?notes_data['assignedVetName']['contactName']['name']:''),
//              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _operation_notes_details_page(this.notes_data);


}