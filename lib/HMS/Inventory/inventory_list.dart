import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Inventory/add_inventory.dart';
import 'package:horse_management/HMS/Inventory/services_inventory.dart';
import 'package:horse_management/HMS/Inventory/update_inventory.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class inventory_list extends StatefulWidget{
  String token;


  inventory_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<inventory_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String token;
  bool isVisible=false;
  var inventorylist;
  var temp=['',''];


  @override
  void initState () {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

//    labtest_services.labTestlist(token).then((response){
//      setState(() {
//        print(response);
//        lablist =json.decode(response);
//
//      });
//
//    });
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        inventoryServices.Inventorylist(token).then((response){
          pd.dismiss();
          isVisible = true;
          setState(() {
            print(response);
            inventorylist = json.decode(response);
          });
        });
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Network Not Available"),
        ));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Inventory List"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => addInventory(token)),);
            },
          )
        ],),

        body: Visibility(
          visible: isVisible,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: (){
              return Utils.check_connectivity().then((result){
                if(result){
                  inventoryServices.Inventorylist(token).then((response){
                    // print(response.length.toString());
                    if(response!=null){
                      setState(() {
                        //var parsedjson = jsonDecode(response);
                        inventorylist  = jsonDecode(response);
                        print(inventorylist);
                        //print(horse_list['createdBy']);
                      });
                    }
                  });
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red ,
                    content: Text('Network Error'),
                  ));
                }
              });
            },
            child: ListView.builder(itemCount:inventorylist!=null?inventorylist.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
//                secondaryActions: <Widget>[
//
//                ],
                    actions: <Widget>[
                      IconSlideAction(onTap: ()async{
                        prefs = await SharedPreferences.getInstance();
                        print(inventorylist[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>updateInventory(prefs.get('token'),inventorylist[index])));

                      },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          inventoryServices.inventoryvisibilty(token, inventorylist[index]['id']).then((response){
                            //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                            print(response);
                            if(response!=null){

                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));

                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.red ,
                                content: Text('Failed'),
                              ));
                            }
                          });
                        },
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                        title: Text(inventorylist!=null?(inventorylist[index]['name']):''),
                       subtitle: Text(inventorylist[index]['itemType']!=null?(inventorylist[index]['itemType']).toString():'testtype empty'),
                        trailing: Text(inventorylist[index]['stock'] != null ? inventorylist[index]['stock'].toString():" name empty"),
                        //leading: Image.asset("Assets/horses_icon.png"),


                        children: <Widget>[

                          Divider(),
                          ListTile(
                            title: Text("Amount"),
                            //trailing: Text(inventorylist != null ? inventorylist[index]['amount'].toString():""),
                          )

                        ],


                      ),
                    ),


                  ),
                  Divider(),
                ],

              );

            }),
          ),
        )
    );
  }

}