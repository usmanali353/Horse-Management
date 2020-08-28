import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/all_horse_data_add.dart';
import 'package:horse_management/HMS/Breeding/breeding_mainPage.dart';
import 'package:horse_management/HMS/Configuration/configuration_mainpage.dart';
import 'package:horse_management/HMS/Contacts/contacts_list.dart';
import 'package:horse_management/HMS/Dashboard/dashboardMainPage.dart';
import 'package:horse_management/HMS/Diet/DietSubCategory.dart';
import 'package:horse_management/HMS/HorseGroups/horseGroup_list.dart';
import 'package:horse_management/HMS/Inventory/inventory_list.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes.dart';
import 'package:horse_management/HMS/Paddock/paddocks.dart';
import 'package:horse_management/HMS/Tanks/tanks.dart';
import 'package:horse_management/HMS/Training/training_options.dart';
import 'package:horse_management/HMS/Veterinary/vet_mainPage.dart';
import 'package:horse_management/HMS/my_horses/horses_list.dart';
import 'package:horse_management/Model/categories.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:horse_management/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewHomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewHomeScreen_State();
  }

}

class _NewHomeScreen_State extends State<NewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(title: Text("Home"),
//      backgroundColor: Colors.teal.shade700,
//        centerTitle: true,
//      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(2.4,Text("Best management system for", style: TextStyle(
//                    color: Colors.grey.shade100,
                    fontSize: 22,
                    letterSpacing: 2
                ))),
                FadeAnimation(2.6,Text(".horse", style: TextStyle(
                    color: Colors.teal,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                ))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> dashboardMainPage(prefs.getString("token")) ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Card(
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      "assets/dashbaord.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 7.0),


                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Dashboard",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),


                            //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                            //SizedBox(height: 10.0),

                          ],
                        ),
                      ),
                    ),
                  ),

                 InkWell(
                   onTap: () async {
                     SharedPreferences prefs=await SharedPreferences.getInstance();
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> horse_list(prefs.getString('token')) ));
                   },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: Card(
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.22,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      "assets/horse1.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 7.0),


                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "My Horses",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),


                            //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                            //SizedBox(height: 10.0),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> breeding_Category(prefs.getString('token')) ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/breeding.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Breeding",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> training_options(prefs.getString('token')) ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/training.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Training Center",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> vet_category() ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/vetrinary.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Veterinary",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> dietMainList(prefs.getString("token")) ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/diet.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Diet",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> inventory_list(prefs.getString('token')) ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/inventory.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Inventory",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> configuration_Category(prefs.getString('token')) ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    "assets/configuration.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          SizedBox(height: 7.0),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Configurations",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),


                          //SizedBox(height: 7.0),

//                          Padding(
//                            padding: EdgeInsets.only(left: 15.0),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(
//                                "${widget.address}",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.teal
//                                ),
//                              ),
//                            ),
//                          ),

                          //SizedBox(height: 10.0),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}