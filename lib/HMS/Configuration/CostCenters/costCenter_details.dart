import 'package:flutter/material.dart';

class costCenter_details_page extends StatefulWidget{
  var costcenter_data;


  costCenter_details_page(this.costcenter_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _costCenter_details_page(costcenter_data);
  }

}
class _costCenter_details_page extends State<costCenter_details_page>{
  var costcenter_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Cost Center Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Cost Center ID: "),
                  trailing: Text(costcenter_data['id'].toString()!=null?costcenter_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Cost Center Name: "),
                  trailing: Text(costcenter_data['name'].toString()!=null?costcenter_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Description: "),
                  subtitle: Wrap(
                      children: <Widget>[
                  Text(costcenter_data['description'].toString()!=null?costcenter_data['description'].toString():''
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

  _costCenter_details_page(this.costcenter_data);


}