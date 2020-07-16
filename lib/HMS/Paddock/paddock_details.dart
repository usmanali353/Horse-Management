import 'package:flutter/material.dart';

class paddock_details_page extends StatefulWidget{
  var paddock_data;


  paddock_details_page(this.paddock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _paddock_details_page(paddock_data);
  }

}
class _paddock_details_page extends State<paddock_details_page>{
  var paddock_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Paddock Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Paddock ID: "),
                  trailing: Text(paddock_data['id'].toString()!=null?paddock_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Name: "),
                  trailing: Text(paddock_data['name'].toString()!=null?paddock_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Main Use:"),
                  trailing: Text(paddock_data['mainUse'].toString()!=null?paddock_data['mainUse'].toString():''),
                ),
                ListTile(
                  title: Text("Area:"),
                  trailing: Text(paddock_data['area']!=null?paddock_data['area']:''),
                ),
//                ListTile(
//                  title: Text("No. of Horses:"),
//                  trailing: Text(paddock_data['allHorses'].toString()!=null?paddock_data['allHorses'].toString():''),
//                ),
                ListTile(
                  title: Text("Has Shade:"),
                  trailing: Text(paddock_data['hasShade'] == true ? "Yes":"No" ),
                ),
                ListTile(
                  title: Text("Has Water:"),
                  trailing: Text(paddock_data['hasWater'] == true ?"Yes": "No"),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _paddock_details_page(this.paddock_data);


}