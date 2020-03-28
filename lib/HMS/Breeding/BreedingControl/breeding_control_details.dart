import 'package:flutter/material.dart';

class breeding_control_details_page extends StatefulWidget{
  var breeding_control_data;
  String breeding_control_name;

  breeding_control_details_page(this.breeding_control_data,this.breeding_control_name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_control_details_page(breeding_control_data,breeding_control_name);
  }

}
class _breeding_control_details_page extends State<breeding_control_details_page>{
  var breeding_control_data;
  String training_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Breeding Control Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Breeding Control ID: "),
                trailing: Text(breeding_control_data['breedingControlId'].toString()!=null?breeding_control_data['breedingControlId'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(breeding_control_data['horseName']['name'].toString()!=null?breeding_control_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date"),
                trailing: Text(breeding_control_data['date'].toString()!=null?breeding_control_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Time"),
                trailing: Text(breeding_control_data['hour'].toString()!=null?breeding_control_data['hour'].toString():''),
              ),
              ListTile(
                title: Text("Related Service Date"),
                trailing: Text(breeding_control_data['relatedServiceDate']['serviceDate']!=null?breeding_control_data['relatedServiceDate']['serviceDate']:''),
              ),
              Divider(),
              ListTile(
                title: Text("LO"),
                trailing: Text(breeding_control_data['lo']!=null?breeding_control_data['lo']:''),
              ),
              ListTile(
                title: Text("RO"),
                trailing: Text(breeding_control_data['ro']!=null?breeding_control_data['ro']:''),
              ),
              ListTile(
                title: Text("Amount"),
                trailing: Text(breeding_control_data['amount'].toString()!=null?breeding_control_data['amount'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Next Check"),
                trailing: Text(breeding_control_data['nextCheckDate'].toString()!=null?breeding_control_data['nextCheckDate'].toString():''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _breeding_control_details_page(this.breeding_control_data,this.training_type_name);


}