import 'package:flutter/material.dart';

class sire_details_page extends StatefulWidget{
  var sire_data;


  sire_details_page(this.sire_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sire_details_page(sire_data);
  }

}
class _sire_details_page extends State<sire_details_page>{
  var sire_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sire Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Sire ID: "),
                  trailing: Text(sire_data['sireId'].toString()!=null?sire_data['sireId'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(sire_data['horseId'].toString()!=null?sire_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("Sire: "),
                  trailing: Text(sire_data['name'].toString()!=null?sire_data['name'].toString():''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(sire_data['description'].toString()!=null?sire_data['description'].toString():''
//                      )],
//                  ),
//                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _sire_details_page(this.sire_data);


}