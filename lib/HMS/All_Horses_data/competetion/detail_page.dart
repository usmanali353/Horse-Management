import 'package:flutter/material.dart';

class competetion_details_page extends StatefulWidget{
  var breeding_control_data;
  competetion_details_page(this.breeding_control_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _competetion_details_page(breeding_control_data);
  }

}
class _competetion_details_page extends State<competetion_details_page>{
  var breeding_control_data;
  String training_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Competetion Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Competetion ID: "),
                    trailing: Text(breeding_control_data['competitionId'].toString()!=null?breeding_control_data['competitionId'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Horse: "),
                    trailing: Text(breeding_control_data['horseName']['name'].toString()!=null?breeding_control_data['horseName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Date:"),
                    trailing: Text(breeding_control_data['date'].toString()!=null?breeding_control_data['date'].toString().substring(0,10):''),
                  ),
                  ListTile(
                    title: Text("Event Name:"),
                    trailing: Text(breeding_control_data['eventName'].toString()!=null?breeding_control_data['eventName'].toString():''),
                  ),
                  ListTile(
                    title: Text("City:"),
                    trailing: Text(breeding_control_data['city']!=null?breeding_control_data['city']:''),
                  ),
                  ListTile(
                    title: Text("Result:"),
                    trailing: Text(breeding_control_data['result']!=null?breeding_control_data['result']:''),
                  ),
                  ListTile(
                    title: Text("rider:"),
                    trailing: Text(breeding_control_data['rider']!=null?breeding_control_data['rider']:''),
                  ),
                  ListTile(
                    title: Text("judges:"),
                    trailing: Text(breeding_control_data['judges'].toString()!=null?breeding_control_data['judges'].toString():''),
                  ),
                  ListTile(
                    title: Text("comments:"),
                    trailing: Text(breeding_control_data['comments'].toString()!=null?breeding_control_data['comments'].toString():''),
                  ),
                  Divider(),
                ],
              ),
            ],
          ),)
    );
  }

  _competetion_details_page(this.breeding_control_data);


}