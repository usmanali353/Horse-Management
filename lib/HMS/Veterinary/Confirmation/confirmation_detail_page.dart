import 'package:flutter/material.dart';

class confirmation_details_page extends StatefulWidget{
  var confirmation_data;


  confirmation_details_page(this.confirmation_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _confirmation_details_page(confirmation_data);
  }

}
class _confirmation_details_page extends State<confirmation_details_page>{
  var confirmation_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Confirmation ID: "),
                trailing: Text(confirmation_data['id'].toString()!=null?confirmation_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(confirmation_data['horseName']['name'].toString()!=null?confirmation_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date:"),
                trailing: Text(confirmation_data['date'].toString()!=null?confirmation_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Vet:"),
                trailing: Text(confirmation_data['vetName']['contactName']['name']!=null?confirmation_data['vetName']['contactName']['name']:''),
              ),
              ListTile(
                title: Text("Comments:"),
                trailing: Text(confirmation_data['comments']!=null?confirmation_data['comments']:''),
              ),
              ListTile(
                title: Text("Embryos:"),
                trailing: Text(confirmation_data['embryos'].toString()!=null?confirmation_data['embryos'].toString():''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _confirmation_details_page(this.confirmation_data);


}