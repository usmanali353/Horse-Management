import 'dart:convert';

import 'package:flutter/material.dart';

class contacts_details_page extends StatefulWidget{
  var contacts_data;

  contacts_details_page(this.contacts_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _contacts_detail_page_state(contacts_data);
  }

}
class _contacts_detail_page_state extends State<contacts_details_page>{
  var contacts_data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Contact Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Contact Id"),
                  trailing: Text(contacts_data['contactId'].toString()!=null?contacts_data['contactId'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Name"),
                  trailing: Text(contacts_data['name']!=null?contacts_data['name']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Roles"),
                  subtitle: Text(contacts_data['allRoles']!=null?contacts_data['allRoles'].toString().replaceAll("[", '').replaceAll("]", ''):''),
                ),
                Divider(),
                ListTile(
                  title: Text("Phone #"),
                  trailing: Text(contacts_data['phoneNo']!=null?contacts_data['phoneNo']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Mobile #"),
                  trailing: Text(contacts_data['mobileNo']!=null?contacts_data['mobileNo']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Email"),
                  trailing: Text(contacts_data['email']!=null?contacts_data['email']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Address"),
                  trailing: Text(contacts_data['address']!=null?contacts_data['address']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Email"),
                  trailing: Text(contacts_data['email']!=null?contacts_data['email']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Website"),
                  trailing: Text(contacts_data['website']!=null?contacts_data['website']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Facebook"),
                  trailing: Text(contacts_data['facebook']!=null?contacts_data['facebook']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Instagram"),
                  trailing: Text(contacts_data['instagram']!=null?contacts_data['instagram']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Twitter"),
                  trailing: Text(contacts_data['twiter']!=null?contacts_data['twiter']:''),
                ),
                Divider(),
                ListTile(
                  title: Text("Picture"),
                  trailing: contacts_data['picture']!=null?Image.memory(base64Decode(contacts_data['picture'])):Text(''),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _contacts_detail_page_state(this.contacts_data);
}