import 'package:flutter/material.dart';

class accountCategories_details_page extends StatefulWidget{
  var category_data;


  accountCategories_details_page(this.category_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _accountCategories_details_page(category_data);
  }

}
class _accountCategories_details_page extends State<accountCategories_details_page>{
  var category_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Account Categories Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Account ID: "),
                  trailing: Text(category_data['id'].toString()!=null?category_data['id'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Code: "),
                  trailing: Text(category_data['code'].toString()!=null?category_data['code'].toString():''),
                ),
                ListTile(
                  title: Text("Account Name: "),
                  trailing: Text(category_data['name'].toString()!=null?category_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Is Income:"),
                  trailing: Text(category_data['isIncome'] == true ? "Yes":"No" ),
                ),
                ListTile(
                  title: Text("Is System:"),
                  trailing: Text(category_data['isSystem'] == true ? "Yes":"No" ),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _accountCategories_details_page(this.category_data);


}