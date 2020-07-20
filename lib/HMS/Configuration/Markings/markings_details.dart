import 'package:flutter/material.dart';

class markings_details_page extends StatefulWidget{
  var marking_data;


  markings_details_page(this.marking_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _markings_details_page(marking_data);
  }

}
class _markings_details_page extends State<markings_details_page>{
  var marking_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Marking Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Marking ID: "),
                  trailing: Text(marking_data['id'].toString()!=null?marking_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Type: "),
                  trailing: Text(marking_data['type'].toString()!=null?marking_data['type'].toString():''),
                ),
                ListTile(
                  title: Text("Marking: "),
                  trailing: Text(marking_data['name'].toString()!=null?marking_data['name'].toString():''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(marking_data['description'].toString()!=null?marking_data['description'].toString():''
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

  _markings_details_page(this.marking_data);


}