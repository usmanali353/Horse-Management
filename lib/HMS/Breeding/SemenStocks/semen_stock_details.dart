import 'package:flutter/material.dart';

class semen_stock_details_page extends StatefulWidget{
  var semen_stock_data;


  semen_stock_details_page(this.semen_stock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _semen_stock_details_page(semen_stock_data);
  }

}
class _semen_stock_details_page extends State<semen_stock_details_page>{
  var semen_stock_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Semen Stock Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("ID: "),
                trailing: Text(semen_stock_data['id'].toString()!=null?semen_stock_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(semen_stock_data['horseName']['name'].toString()!=null?semen_stock_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Tank: "),
                trailing: Text(semen_stock_data['tankName']['name'].toString()!=null?semen_stock_data['tankName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Enter Date:"),
                trailing: Text(semen_stock_data['enterDate'].toString()!=null?semen_stock_data['enterDate'].toString():''),
              ),
              ListTile(
                title: Text("Serial Number:"),
                trailing: Text(semen_stock_data['serialNumber'].toString()!=null?semen_stock_data['serialNumber'].toString():''),
              ),
              ListTile(
                title: Text("Collection Date:"),
                trailing: Text(semen_stock_data['collectionDate'].toString()!=null?semen_stock_data['collectionDate'].toString():''),
              ),
//              ListTile(
//                title: Text("Assigned Vet"),
//                trailing: Text(semen_stock_data['assignedVetName']['contactName']['name']!=null?semen_stock_data['assignedVetName']['contactName']['name']:''),
//              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _semen_stock_details_page(this.semen_stock_data);


}