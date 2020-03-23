import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/all_horse_data_add.dart';
import 'package:horse_management/HMS/Breeding/breeding_mainPage.dart';
import 'package:horse_management/HMS/Configuration/configuration_mainpage.dart';
import 'package:horse_management/HMS/Diet/DietSubCategory.dart';
import 'package:horse_management/HMS/Inventory/inventory_list.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes.dart';
import 'package:horse_management/HMS/Paddock/paddocks.dart';
import 'package:horse_management/HMS/Tanks/tanks.dart';
import 'package:horse_management/HMS/Training/trainingMainPage.dart';
import 'package:horse_management/HMS/Training/training_list.dart';
import 'package:horse_management/HMS/Veterinary/vet_mainPage.dart';
import 'package:horse_management/HMS/my_horses/horses_list.dart';
import 'package:horse_management/Model/restaurants.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:horse_management/screens/settings_page.dart';
import 'package:horse_management/Model/categories.dart';
import 'package:horse_management/widgets/slide_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{ //with AutomaticKeepAliveClientMixin<Home>{
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
//            child: Container(
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.all(
//                  Radius.circular(5.0),
//                ),
//              ),
//              child: TextField(
//                style: TextStyle(
//                  fontSize: 15.0,
//                  color: Colors.black,
//                ),
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0),
//                    borderSide: BorderSide(color: Colors.white,),
//                  ),
//                  enabledBorder: OutlineInputBorder(
//                    borderSide: BorderSide(color: Colors.white,),
//                    borderRadius: BorderRadius.circular(5.0),
//                  ),
//                  hintText: "Search..",
//                  prefixIcon: Icon(
//                    Icons.search,
//                    color: Colors.black,
//                  ),
//                  suffixIcon: Icon(
//                    Icons.filter_list,
//                    color: Colors.black,
//                  ),
//                  hintStyle: TextStyle(
//                    fontSize: 15.0,
//                    color: Colors.black,
//                  ),
//                ),
//                maxLines: 1,
//                controller: _searchControl,
//              ),
//            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          60.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),

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

            SizedBox(height: 10.0),

            //Horizontal List here
            Container(
              height: MediaQuery.of(context).size.height/2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
//                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurants == null ? 0 :restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  Map restaurant = restaurants[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap:() async{
                        print(index.toString());
                        if(index == 0){
                          SharedPreferences prefs=await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> horse_list(prefs.getString("token")) ));
                        }else if(index == 1){
                          prefs= await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> breeding_Category(prefs.getString('token')) ));
                        }else if(index == 2){
                          prefs= await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> trainingMainPage(prefs.getString('token')) ));
                        }else if(index == 3){
                          prefs= await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> vet_category() ));
                        }else if(index == 4){
                          prefs= await SharedPreferences.getInstance();
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> dietMainList(prefs.getString("token")) ));
                        }else if(index == 5){
                          prefs= await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> inventory_list(prefs.getString("token")) ));
                        }else if(index == 6){
                          prefs= await SharedPreferences.getInstance();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> configuration_Category(prefs.getString('token')) ));
                        }

                      } ,
                      child: SlideItem(
                        img: restaurant["img"],
                        title: restaurant["title"],
                        address: restaurant["address"],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.0),


            Padding(
             padding: EdgeInsets.all(15),
            ),

            SizedBox(height: 10.0),

            //Horizontal List here
            Container(
              height: MediaQuery.of(context).size.height/6,
              child: ListView.builder(
//                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0:categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap:() async{
                          print(index.toString());
                          if(index == 0){// For Horse Groups
                            SharedPreferences prefs=await SharedPreferences.getInstance();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> all_horse_data(prefs.getString("token")) ));
                          }else if(index == 1){
                            prefs= await SharedPreferences.getInstance();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> tanks_list(prefs.getString('token')) ));
                          }else if(index == 2){//For Paddock
                            prefs= await SharedPreferences.getInstance();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> paddocks_list(prefs.getString('token')) ));
                          }else if(index == 3){//For Contacts
                            prefs= await SharedPreferences.getInstance();
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=> contacts_list(prefs.getString('token')) ));
                          }else if(index == 4){
                            prefs= await SharedPreferences.getInstance();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> operational_noteList(prefs.getString('token')) ));
                          }
                          else if(index == 5){
                            prefs= await SharedPreferences.getInstance();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                          }
                        } ,

                        child: Stack(
                          children: <Widget>[
                            Image.asset(
                              cat["img"],
                              height: MediaQuery.of(context).size.height/6,
                              width: MediaQuery.of(context).size.height/6,
                              fit: BoxFit.cover,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.2, 0.7],
                                  colors: [
                                    cat['color1'],
                                    cat['color2'],
                                  ],
                                  // stops: [0.0, 0.1],
                                ),
                              ),
                              height: MediaQuery.of(context).size.height/6,
                              width: MediaQuery.of(context).size.height/6,
                            ),


                            Center(

                              child: Container(
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.height/6,
                                padding: EdgeInsets.all(1),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    cat["name"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Text(
//                  "Friends",
//                  style: TextStyle(
//                    fontSize: 23,
//                    fontWeight: FontWeight.w800,
//                  ),
//                ),

//                FlatButton(
//                  child: Text(
//                    "See all (59)",
//                    style: TextStyle(
////                      fontSize: 22,
////                      fontWeight: FontWeight.w800,
//                      color: Theme.of(context).accentColor,
//                    ),
//                  ),
//                  onPressed: (){
////                    Navigator.of(context).push(
////                      MaterialPageRoute(
////                        builder: (BuildContext context){
////                          return DishesScreen();
////                        },
////                      ),
////                    );
//                  },
//                ),
//              ],
//            ),
//
//            SizedBox(height: 10.0),

//            Container(
//              height: 50.0,
//              child: ListView.builder(
//                primary: false,
//                scrollDirection: Axis.horizontal,
//                shrinkWrap: true,
//                itemCount: friends == null ? 0:friends.length,
//                itemBuilder: (BuildContext context, int index) {
//                  String img = friends[index];
//
//                  return Padding(
//                    padding: EdgeInsets.only(right: 5.0),
//                    child: CircleAvatar(
//                      backgroundImage: AssetImage(
//                        img,
//                      ),
//                      radius: 25.0,
//                    ),
//                  );
//                },
//              ),
//            ),
//
//            SizedBox(height: 30.0),


          ],
        ),
      ),
    );

  }

//  @override
//  bool get wantKeepAlive => true;


}
