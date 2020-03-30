import 'package:flutter/material.dart';

class flushes_details_page extends StatefulWidget{
  var flushes_data;


  flushes_details_page(this.flushes_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _flushes_details_page(flushes_data);
  }

}
class _flushes_details_page extends State<flushes_details_page>{
  var flushes_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Flushes Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Flushes ID: "),
                trailing: Text(flushes_data['id'].toString()!=null?flushes_data['id'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(flushes_data['horseName']['name'].toString()!=null?flushes_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date:"),
                trailing: Text(flushes_data['date'].toString()!=null?flushes_data['date'].toString():''),
              ),
              ListTile(
                title: Text("Vet:"),
                trailing: Text(flushes_data['vetName']['contactName']['name']!=null?flushes_data['vetName']['contactName']['name']:''),
              ),
              ListTile(
                title: Text("Comments:"),
                trailing: Text(flushes_data['comments']!=null?flushes_data['comments']:''),
              ),
              ListTile(
                title: Text("Embryos:"),
                trailing: Text(flushes_data['embryos'].toString()!=null?flushes_data['embryos'].toString():''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _flushes_details_page(this.flushes_data);


}