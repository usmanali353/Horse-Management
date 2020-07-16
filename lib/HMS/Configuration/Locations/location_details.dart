import 'package:flutter/material.dart';

class location_details_page extends StatefulWidget{
  var location_data;


  location_details_page(this.location_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _location_details_page(location_data);
  }

}
class _location_details_page extends State<location_details_page>{
  var location_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Location Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Location ID: "),
                  trailing: Text(location_data['id'].toString()!=null?location_data['id'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(location_data['horseId'].toString()!=null?location_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("Location: "),
                  trailing: Text(location_data['name'].toString()!=null?location_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Description: "),
                  subtitle: Wrap(
                    children: <Widget>[
                      Text(location_data['description'].toString()!=null?location_data['description'].toString():''
                      )],
                  ),
                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _location_details_page(this.location_data);


}