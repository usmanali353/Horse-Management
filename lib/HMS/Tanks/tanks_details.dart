import 'package:flutter/material.dart';

class tanks_details_page extends StatefulWidget{
  var tanks_data;


  tanks_details_page(this.tanks_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tanks_details_page(tanks_data);
  }

}
class _tanks_details_page extends State<tanks_details_page>{
  var tanks_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Tanks Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("ID: "),
                trailing: Text(tanks_data['id'].toString()!=null?tanks_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Tank: "),
                trailing: Text(tanks_data['name'].toString()!=null?tanks_data['name'].toString():''),
              ),
              ListTile(
                title: Text("Capacity"),
                trailing: Text(tanks_data['capacity'].toString()!=null?tanks_data['capacity'].toString():''),
              ),
              ListTile(
                title: Text("Last Fill"),
                trailing: Text(tanks_data['lastFill'].toString()!=null?tanks_data['lastFill'].toString():''),
              ),
              ListTile(
                title: Text("Next Fill"),
                trailing: Text(tanks_data['nextFill'].toString()!=null?tanks_data['nextFill'].toString():''),
              ),
//              ListTile(
//                title: Text("Assigned Vet"),
//                trailing: Text(tanks_data['assignedVetName']['contactName']['name']!=null?tanks_data['assignedVetName']['contactName']['name']:''),
//              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _tanks_details_page(this.tanks_data);


}