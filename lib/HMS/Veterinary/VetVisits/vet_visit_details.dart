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
                title: Text("Flushes ID: "),
                trailing: Text(vet_visit_data['id'].toString()!=null?vet_visit_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(vet_visit_data['horseName']['name'].toString()!=null?vet_visit_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date:"),
                trailing: Text(vet_visit_data['date'].toString()!=null?vet_visit_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Vet:"),
                trailing: Text(vet_visit_data['vetName']['contactName']['name']!=null?vet_visit_data['vetName']['contactName']['name']:''),
              ),
              ListTile(
                title: Text("Comments:"),
                trailing: Text(vet_visit_data['comments']!=null?vet_visit_data['comments']:''),
              ),
              ListTile(
                title: Text("Embryos:"),
                trailing: Text(vet_visit_data['embryos'].toString()!=null?vet_visit_data['embryos'].toString():''),
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