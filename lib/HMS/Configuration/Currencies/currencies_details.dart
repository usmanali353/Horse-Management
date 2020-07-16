//import 'package:flutter/material.dart';
//
//class currencies_details_page extends StatefulWidget{
//  var currencies_data;
//
//
//  currencies_details_page(this.currencies_data);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _currencies_details_page(currencies_data);
//  }
//
//}
//class _currencies_details_page extends State<currencies_details_page>{
//  var currencies_data;
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(title: Text("Currencies Details"),),
//      body: Scrollbar(
//        child: ListView(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                ListTile(
//                  title: Text("Cost Center ID: "),
//                  trailing: Text(currencies_data['id'].toString()!=null?currencies_data['id'].toString():''),
//                ),
//                Divider(),
//                ListTile(
//                  title: Text("Cost Center Name: "),
//                  trailing: Text(currencies_data['name'].toString()!=null?currencies_data['name'].toString():''),
//                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(currencies_data['description'].toString()!=null?currencies_data['description'].toString():''
//                      )],
//                  ),
//                ),
//
//                Divider(),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _currencies_details_page(this.currencies_data);
//
//
//}