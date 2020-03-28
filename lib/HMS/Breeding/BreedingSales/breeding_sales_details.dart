import 'package:flutter/material.dart';

class breeding_sales_details_page extends StatefulWidget{
  var breeding_sales_data;
  String breeding_status_name;

  breeding_sales_details_page(this.breeding_sales_data,this.breeding_status_name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_sales_details_page(breeding_sales_data,breeding_status_name);
  }

}
class _breeding_sales_details_page extends State<breeding_sales_details_page>{
  var breeding_sales_data;
  String status_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Breeding Sales Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Breeding Sales ID: "),
                trailing: Text(breeding_sales_data['breedingSalesId'].toString()!=null?breeding_sales_data['breedingSalesId'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(breeding_sales_data['horseName']['name'].toString()!=null?breeding_sales_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date"),
                trailing: Text(breeding_sales_data['date'].toString()!=null?breeding_sales_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Customer"),
                trailing: Text(breeding_sales_data['customerName']['contactName']['name']!=null?breeding_sales_data['customerName']['contactName']['name']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Contract #"),
                trailing: Text(breeding_sales_data['contractNo'].toString()!=null?breeding_sales_data['contractNo'].toString():''),
              ),
              ListTile(
                title: Text("Status"),
                trailing: Text(status_type_name!=null?status_type_name:''),
              ),
              ListTile(
                title: Text("Assigned Vet"),
                trailing: Text(breeding_sales_data['assignedVetName']['contactName']['name']!=null?breeding_sales_data['assignedVetName']['contactName']['name']:''),
              ),
              Divider(),
//              ListTile(
//                title: Text("Next Check"),
//                trailing: Text(breeding_sales_data['nextCheckDate'].toString()!=null?breeding_sales_data['nextCheckDate'].toString():''),
//              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _breeding_sales_details_page(this.breeding_sales_data,this.status_type_name);


}