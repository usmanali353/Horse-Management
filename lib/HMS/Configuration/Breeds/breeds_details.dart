import 'package:flutter/material.dart';

class breeds_details_page extends StatefulWidget{
  var breeds_data;


  breeds_details_page(this.breeds_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeds_details_page(breeds_data);
  }

}
class _breeds_details_page extends State<breeds_details_page>{
  var breeds_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Breeds Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Breed ID: "),
                  trailing: Text(breeds_data['id'].toString()!=null?breeds_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Breed Name: "),
                  trailing: Text(breeds_data['name'].toString()!=null?breeds_data['name'].toString():''),
                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _breeds_details_page(this.breeds_data);


}