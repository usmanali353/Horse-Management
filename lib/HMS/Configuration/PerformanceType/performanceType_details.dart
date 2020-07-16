import 'package:flutter/material.dart';

class performanceType_details_page extends StatefulWidget{
  var location_data;


  performanceType_details_page(this.location_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _performanceType_details_page(location_data);
  }

}
class _performanceType_details_page extends State<performanceType_details_page>{
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
                  title: Text("Performance Type ID: "),
                  trailing: Text(location_data['performanceId'].toString()!=null?location_data['performanceId'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(location_data['horseId'].toString()!=null?location_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("Performance Type: "),
                  trailing: Text(location_data['name'].toString()!=null?location_data['name'].toString():''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(location_data['description'].toString()!=null?location_data['description'].toString():''
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

  _performanceType_details_page(this.location_data);


}