import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Dashboard/AuditLog/AuditLog.dart';
import 'package:horse_management/HMS/Diet/create_from_inventory.dart';
import 'package:horse_management/HMS/Diet/create_product_type.dart';
import 'package:horse_management/HMS/Diet/productType/grain.dart';
import 'package:horse_management/HMS/Diet/productType/Forage.dart';
import 'package:horse_management/HMS/Diet/productType/ration.dart';
import 'package:horse_management/HMS/Diet/productType/supplements.dart';


class producttypeMainPage extends StatefulWidget{
  String token;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashboardMainPageState(token);
  }

  producttypeMainPage(this.token);

}
class dashboardMainPageState extends State<producttypeMainPage>{
  String token;

  dashboardMainPageState(this.token);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(title: Text("Product Type"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Text("Add New"),
                  Padding(padding: EdgeInsets.all(12.0),
                    child: InkWell(child: Icon(Icons.add),
                      onTap: (){
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
                      },

                    ),


                  ),
                ],
              )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Grain",),
                Tab(text: "Supplements",),
                Tab(text: "Forage",),
                Tab(text: "Rations",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              grain(token),
              supplement_page(token),
              forage(token),
              ration(token),
            ],
          ),
        )
    );
  }

}