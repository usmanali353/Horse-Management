import 'package:flutter/material.dart';

class horseCategories_details_page extends StatefulWidget{
  var category_data;


  horseCategories_details_page(this.category_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _horseCategories_details_page(category_data);
  }

}
class _horseCategories_details_page extends State<horseCategories_details_page>{
  var category_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Horse Categories Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Horse Category ID: "),
                  trailing: Text(category_data['id'].toString()!=null?category_data['id'].toString():''),
                ),
                Divider(),
//                ListTile(
//                  title: Text("Horse ID: "),
//                  trailing: Text(category_data['horseId'].toString()!=null?category_data['horseId'].toString():''),
//                ),
                ListTile(
                  title: Text("Horse Category Name: "),
                  trailing: Text(category_data['name'].toString()!=null?category_data['name'].toString():''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(category_data['description'].toString()!=null?category_data['description'].toString():''
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

  _horseCategories_details_page(this.category_data);


}