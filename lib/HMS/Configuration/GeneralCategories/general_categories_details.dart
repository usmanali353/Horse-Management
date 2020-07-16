import 'package:flutter/material.dart';

class generalCategories_details_page extends StatefulWidget{
  var category_data;


  generalCategories_details_page(this.category_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _generalCategories_details_page(category_data);
  }

}
class _generalCategories_details_page extends State<generalCategories_details_page>{
  var category_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("General Categories Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("General Category ID: "),
                  trailing: Text(category_data['id'].toString()!=null?category_data['id'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(category_data['horseId'].toString()!=null?category_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("General Category Name: "),
                  trailing: Text(category_data['name'].toString()!=null?category_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Description: "),
                  subtitle: Wrap(
                    children: <Widget>[
                      Text(category_data['description'].toString()!=null?category_data['description'].toString():''
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

  _generalCategories_details_page(this.category_data);


}