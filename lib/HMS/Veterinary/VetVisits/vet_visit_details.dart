import 'package:flutter/material.dart';

class vet_visit_details_page extends StatefulWidget{
  var vet_visit_data;


  vet_visit_details_page(this.vet_visit_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vet_visit_details_page(vet_visit_data);
  }

}
class _vet_visit_details_page extends State<vet_visit_details_page>{
  var vet_visit_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Vet Visit Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("VetVisit ID: "),
                trailing: Text(vet_visit_data['vetVisitId'].toString()!=null?vet_visit_data['vetVisitId'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(vet_visit_data['horseName']['name'].toString()!=null?vet_visit_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Visit Date:"),
                trailing: Text(vet_visit_data['visitDate'].toString()!=null?vet_visit_data['visitDate'].toString().substring(0,10) :''),
              ),
              ListTile(
                title: Text("Vet:"),
                trailing: Text(vet_visit_data['vetName']['contactName']['name']!=null?vet_visit_data['vetName']['contactName']['name']:''),
              ),
              ListTile(
                onTap: (){
                },
                title: Text("Responsible:"),
                trailing: Text(vet_visit_data['responsibleName']['contactName']['name']!=null?vet_visit_data['responsibleName']['contactName']['name']:''),
              ),
              ListTile(
                title: Text("Products:"),
                trailing: Text(vet_visit_data['vetVisitsProducts'][0]['inventoryProductName']['name']!=null?vet_visit_data['vetVisitsProducts'][0]['inventoryProductName']['name']:''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _vet_visit_details_page(this.vet_visit_data);


}