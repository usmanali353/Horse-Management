import 'dart:convert';

import 'package:flutter/material.dart';

class ironBrand_details_page extends StatefulWidget{
  var ironbrand_data;


  ironBrand_details_page(this.ironbrand_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ironBrand_details_page(ironbrand_data);
  }

}
class _ironBrand_details_page extends State<ironBrand_details_page>{
  var ironbrand_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Iron Brand Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Iron Brand ID: "),
                  trailing: Text(ironbrand_data['brandId'].toString()!=null?ironbrand_data['brandId'].toString():''),
                ),
                Divider(),

                ListTile(
                  title: Text("Brand Title: "),
                  trailing: Text(ironbrand_data['brandTitle'].toString()!=null?ironbrand_data['brandTitle'].toString():''),
                ),
                ListTile(
                  title: Text("Brand Image: "),
                  trailing: ironbrand_data['brandImage']!=null?Image.memory(base64.decode(ironbrand_data['brandImage'])):Text(''),
                ),
//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(ironbrand_data['description'].toString()!=null?ironbrand_data['description'].toString():''
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

  _ironBrand_details_page(this.ironbrand_data);


}