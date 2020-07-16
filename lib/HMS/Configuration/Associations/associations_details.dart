import 'package:flutter/material.dart';

class associations_details_page extends StatefulWidget{
  var associations_data;


  associations_details_page(this.associations_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _associations_details_page(associations_data);
  }

}
class _associations_details_page extends State<associations_details_page>{
  var associations_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Associations Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Associations ID: "),
                  trailing: Text(associations_data['id'].toString()!=null?associations_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Associations Name: "),
                  trailing: Text(associations_data['name'].toString()!=null?associations_data['name'].toString():''),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _associations_details_page(this.associations_data);


}