import 'package:flutter/material.dart';

class color_details_page extends StatefulWidget{
  var colors_data;


  color_details_page(this.colors_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _color_details_page(colors_data);
  }

}
class _color_details_page extends State<color_details_page>{
  var colors_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Colors Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Color ID: "),
                  trailing: Text(colors_data['id'].toString()!=null?colors_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Color: "),
                  trailing: Text(colors_data['name'].toString()!=null?colors_data['name'].toString():''),
                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _color_details_page(this.colors_data);


}