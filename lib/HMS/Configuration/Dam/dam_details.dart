import 'package:flutter/material.dart';

class dam_details_page extends StatefulWidget{
  var dam_data;


  dam_details_page(this.dam_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dam_details_page(dam_data);
  }

}
class _dam_details_page extends State<dam_details_page>{
  var dam_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Dam Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Dam ID: "),
                  trailing: Text(dam_data['damId'].toString()!=null?dam_data['damId'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(dam_data['horseId'].toString()!=null?dam_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("Dam Name: "),
                  trailing: Text(dam_data['name'].toString()!=null?dam_data['name'].toString():''),
                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _dam_details_page(this.dam_data);


}