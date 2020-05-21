import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/add_new_note.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/update_notes.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';

import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';

import '../create_from_inventory.dart';
import '../create_product_type.dart';

class productList extends StatefulWidget{
  String token;

  productList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _notes_list_state(token);
  }

}
class _notes_list_state extends State<productList>{
  String token;
  var itemList;
  //var notes_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Product Types")),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                var image;
                return SimpleDialog(
                    title: Text("Select One"),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductType(token)));
                        },
                        child: const Text('Create Product'),
                      ),
                      SimpleDialogOption(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>createFromInventory(token)));
                        },

                        child: const Text('Create From Inventory'),
                      ),
                    ]
                );
              }
          );
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductType(token)));
        },

      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              DietServices.productTypeList(token).then((response){
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    var load_list=json.decode(response);
                    itemList = load_list['response'];
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("product List Not Found"),
                  ));
                  setState(() {
                    isvisible=false;
                  });
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: ListView.builder(itemCount:itemList!=null?itemList.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  secondaryActions: <Widget>[

                  ],
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        DietServices.productTypeVisibilty(token, itemList[index]['productTypeId']).then((response){
                          print(response);
                          if(response!=null){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Visibility Changed'),
                            ));
                            setState(() {
                              itemList.removeAt(index);
                            });

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });
                      },
                    ),
                    IconSlideAction(
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: () async {
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_notes(token,itemList[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(itemList!=null?itemList[index]['name']:''),
                    subtitle: Text(itemList[index]['costPerUnit']!=null?"Cost: "+itemList[index]['costPerUnit'].toString():''),
                    leading: Icon(FontAwesomeIcons.box,size: 40,color: Colors.teal,),
                    trailing: Text(itemList[index]['unit'] != null ? itemList[index]['unit'].toString():""),
                    onTap: (){
                    },
                  ),

                ),
                Divider(),
                Text("Foarge"),
                ListTile(
                  title: Text(itemList!=null?itemList[index]['name']:''),
                  subtitle: Text(itemList[index]['costPerUnit']!=null?"Cost: "+itemList[index]['costPerUnit'].toString():''),
                  leading: Icon(FontAwesomeIcons.box,size: 40,color: Colors.teal,),
                  trailing: Text(itemList[index]['unit'] != null ? itemList[index]['unit'].toString():""),
                  onTap: (){
                  },
                ),
              ],

            );

          }),
        ),
      ),
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