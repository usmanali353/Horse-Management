import 'package:flutter/material.dart';

class breeding_services_details_page extends StatefulWidget{
  var breeding_services_data;
  String breeding_services_name;

  breeding_services_details_page(this.breeding_services_data,this.breeding_services_name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_services_details_page(breeding_services_data,breeding_services_name);
  }

}
class _breeding_services_details_page extends State<breeding_services_details_page>{
  var breeding_services_data;
  String breeding_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Breeding Services Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Breeding Services ID: "),
                  trailing: Text(breeding_services_data['breedingServiceId'].toString()!=null?breeding_services_data['breedingServiceId'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Horse: "),
                  trailing: Text(breeding_services_data['horseName']['name']!=null?breeding_services_data['horseName']['name']:''),
                ),
                ListTile(
                  title: Text("Date:"),
                  trailing: Text(breeding_services_data['serviceDate'].toString()!=null?breeding_services_data['serviceDate'].toString().substring(0,10):''),
                ),
                ListTile(
                  title: Text("Sire:"),
                  trailing: Text(breeding_services_data['sireName']['name']!=null?breeding_services_data['sireName']['name']:''),
                ),
                ListTile(
                  title: Text("Donor:"),
                  trailing: Text(breeding_services_data['donorName']['name']!=null?breeding_services_data['donorName']['name']:''),
                ),
                ListTile(
                  title: Text("Service Type:"),
                  trailing: Text(breeding_type_name!=null?breeding_type_name:''),
                ),
//              ListTile(
//                title: Text("RO"),
//                trailing: Text(breeding_services_data['ro']!=null?breeding_services_data['ro']:''),
//              ),
//              ListTile(
//                title: Text("Amount"),
//                trailing: Text(breeding_services_data['amount'].toString()!=null?breeding_services_data['amount'].toString():''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Next Check"),
//                trailing: Text(breeding_services_data['nextCheckDate'].toString()!=null?breeding_services_data['nextCheckDate'].toString():''),
//              ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _breeding_services_details_page(this.breeding_services_data,this.breeding_type_name);


}