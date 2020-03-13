import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/All_Horses_data/all_horse_data_add.dart';
import 'package:horse_management/HMS/Breeding/breeding_mainPage.dart';
import 'package:horse_management/HMS/Configuration/configuration_mainpage.dart';
import 'package:horse_management/HMS/Inventory/add_inventory.dart';
import 'package:horse_management/HMS/Inventory/inventory_list.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes.dart';
import 'package:horse_management/HMS/Tanks/tanks.dart';
import 'package:horse_management/HMS/Training/already_trained_horses_list.dart';
import 'package:horse_management/HMS/Training/training_list.dart';
import 'package:horse_management/HMS/Veterinary/vet_mainPage.dart';
import 'package:horse_management/HMS/my_horses/horses_list.dart';
import 'package:horse_management/screens/tasks_Page.dart';
import 'package:horse_management/screens/Notification_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home_Page_State();
  }
}
class _Home_Page_State extends State<Home_Page>{
  bool darkTheme = false;
  int currentTab;
  Widget currentScreen;
  PageStorageBucket bucket;
  String title="Tasks";
  SharedPreferences prefs;
  @override
  void initState() {
    setState(() {
      currentTab=0;
      currentScreen=tasks_Page();
      bucket = PageStorageBucket();
      title="Tasks";
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.teal,
          onPressed: () {
            showModalBottomSheet(context: context, builder: (context){
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
//                  ListTile(
//                    title: Text("User Management", style: TextStyle(fontWeight: FontWeight.bold)),
//                    leading: Icon(Icons.settings),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=> sub_categories_page("User Management") ));
//                    },
//                  ),
                  ListTile(
                    title: Text("All Horses Data", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(FontAwesomeIcons.horseHead),
                    onTap: () async{
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> all_horse_data(prefs.getString("token")) ));
                    },
                  ),
                  ListTile(
                    title: Text("Breeding", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.pets),
                    onTap: ()async{
                      prefs= await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> breeding_Category(prefs.getString('token')) ));
                    },
                  ),
                  ListTile(
                    title: Text("Training Center", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.fitness_center),
                    onTap: () async{
                      prefs= await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> training_list(prefs.getString('token')) ));
                    },

                  ),
                  ListTile(
                    title: Text("Veterinary", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.local_pharmacy),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> vet_category() ));
                    },
                  ),
                  ListTile(
                    title: Text("Diets", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.fastfood),
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=> sub_categories_page("Diets") ));
                    },
                  ),

                  ListTile(
                    title: Text("Tanks", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> tanks_list("token") ));
                    },
                  ),
                  ListTile(
                    title: Text("Operation Notes", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> operational_noteList("token") ));
                    },
                  ),
                  ListTile(
                    title: Text("Configuration", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> configuration_Category("token") ));
                    },
                  ),
                  ListTile(
                    title: Text("Inventory", style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Icon(Icons.beach_access),
                    onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> inventory_list(prefs.get('token')) ));
                    },
                  ),
//                  ListTile(
//                    title: Text("Horse Group", style: TextStyle(fontWeight: FontWeight.bold)),
//                    leading: Icon(Icons.all_inclusive),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=> sub_categories_page("Horse Group") ));
//                    },
//                  ),
//                  ListTile(
//                    title: Text("Tanks", style: TextStyle(fontWeight: FontWeight.bold)),
//                    leading: Icon(Icons.local_convenience_store),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=> sub_categories_page("Tanks") ));
//                    },
//                  ),
//                  ListTile(
//                    title: Text("Paddock", style: TextStyle(fontWeight: FontWeight.bold)),
//                    leading: Icon(Icons.local_florist),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=> sub_categories_page("Paddock") ));
//                    },
//                  ),


                ],
              );
            });
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              tasks_Page(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.event,
                            color: currentTab == 0 ? Colors.teal : Colors.grey,
                          ),
                          Text(
                            'Tasks',
                            style: TextStyle(
                              color: currentTab == 0 ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () async{
                        prefs= await SharedPreferences.getInstance();
                        setState(() {
                          currentScreen = horse_list(prefs.getString("token"));
                             // if user taps on this dashboard tab will be active
                          currentTab = 1;
                          print(currentTab.toString());
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.horse,
                            color: currentTab == 1 ? Colors.teal : Colors.brown,
                          ),
                          Text(
                            'My Horses',
                            style: TextStyle(
                              color: currentTab == 1 ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Notification_Page(); // if user taps on this dashboard tab will be active
                          currentTab = 2;
                          print(currentTab.toString());
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            color: currentTab == 2 ? Colors.teal : Colors.grey,
                          ),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: currentTab == 2 ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () async{
                        prefs  =await SharedPreferences.getInstance();
                        setState(() {
                          currentScreen =
                              addInventory(prefs.get('token')); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                           FontAwesomeIcons.bookReader,
                            color: currentTab == 3 ? Colors.teal  : Colors.grey,
                          ),
                          Text(
                            'Diary',
                            style: TextStyle(
                              color: currentTab == 3 ? Colors.teal : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.teal
      )
    );
  }
}