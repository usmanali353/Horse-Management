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
                title: Text("Horse ID: "),
                trailing: Text(breeding_control_data['horseId']!=null?breeding_control_data['horseId']:''),
              ),
              ListTile(
                title: Text("Date"),
                trailing: Text(breeding_control_data['date']!=null?breeding_control_data['date']:''),
              ),
              ListTile(
                title: Text("Time"),
                trailing: Text(breeding_control_data['hour']!=null?breeding_control_data['hour']:''),
              ),
              ListTile(
                title: Text("Related Service Date"),
                trailing: Text(breeding_control_data['relatedServiceDate']!=null?breeding_control_data['relatedServiceDate']:''),
              ),
              Divider(),
              ListTile(
                title: Text("RO"),
                trailing: Text(training_type_name!=null?training_type_name:''),
              ),
              ListTile(
                title: Text("RO"),
                trailing: Text(training_type_name!=null?training_type_name:''),
              ),
              ListTile(
                title: Text("Ammount"),
                trailing: Text(training_type_name!=null?training_type_name:''),
              ),
              Divider(),
              ListTile(
                title: Text("Next Check"),
                trailing: Text(breeding_control_data['nextCheckDate']!=null?breeding_control_data['nextCheckDate']:''),
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