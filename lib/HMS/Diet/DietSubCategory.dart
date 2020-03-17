import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/add_new_note.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/update_notes.dart';
import 'package:horse_management/HMS/Diet/dietList.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/HMS/Diet/productType/productTypeList.dart';

import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';

class dietMainList extends StatefulWidget{
  String token;

  dietMainList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _notes_list_state(token);
  }

}
class _notes_list_state extends State<dietMainList>{
  String token;
  var itemList;
  //var notes_list=[];
  var temp=[''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Product Types")),

      body: ListView.builder(itemCount:itemList!=null?itemList.length:temp.length,itemBuilder: (context,int index){
        return Column(
          children: <Widget>[
               ListTile(
                title: Text(" New Diet"),
//                subtitle: Text(itemList[index]['costPerUnit']!=null?"Cost: "+itemList[index]['costPerUnit'].toString():''),
                leading: Icon(FontAwesomeIcons.pizzaSlice,size: 40,color: Colors.teal,),
//                trailing: Text(itemList[index]['unit'] != null ? itemList[index]['unit'].toString():""),
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>dietList(token)));
                },
              ),
            ListTile(
              title: Text("Product Type"),
             // subtitle: Text(itemList[index]['costPerUnit']!=null?"Cost: "+itemList[index]['costPerUnit'].toString():''),
              leading: Icon(FontAwesomeIcons.pizzaSlice,size: 40,color: Colors.teal,),
            //  trailing: Text(itemList[index]['unit'] != null ? itemList[index]['unit'].toString():""),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>productList(token)));
              },
            ),


          ],

        );

      }),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _notes_list_state(this.token);

}