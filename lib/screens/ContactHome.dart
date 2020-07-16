import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/CareTakers/Farrier/farrier_caretaker_List.dart';
import 'package:horse_management/HMS/CareTakers/Trainings/training_caretaker_list.dart';
import 'package:horse_management/HMS/CareTakers/breeding_caretaker_mainpage.dart';
import 'package:horse_management/HMS/CareTakers/veterinary_mainpage.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:horse_management/screens/settings_page.dart';
import 'package:horse_management/widgets/slide_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ContactHome extends StatefulWidget {


 @override
  _ContactHomeState createState() => _ContactHomeState();
}

class _ContactHomeState extends State<ContactHome> {
  var userData;
   List restaurants=[];

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs){
      this.userData=jsonDecode(prefs.getString("loginJson"));
      setState(() {
        if(userData['contactResult']['Breeder']!=null){
          restaurants.add(
              {
                "img": "assets/breeding.jpg",
                "title": "Breeding",
                "address": "Add breeds of horses",
                "rating": "4.5"
              }
          );
        }
        if(userData['contactResult']['Vet']!=null){
          restaurants.add(
              {
                "img": "assets/vetrinary.jpg",
                "title": "Veterinary",
                "address": "Add & check for the veterinary management",
                "rating": "4.5"
              }
          );
        }
        if(userData['contactResult']['Trainer']!=null){
          restaurants.add(
              {
                "img": "assets/training.jpg",
                "title": "Training Center",
                "address": "Add and check for the horse training",
                "rating": "4.5"
              }
          );
        }
        if(userData['contactResult']['Farrier']!=null){
          restaurants.add(
              {
                "img": "assets/farrier.jpg",
                "title": "Farrier",
                "address": "Add Farrier",
                "rating": "4.5"
              }
          );
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 65.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          60.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
          } ,
          tooltip: 'Settings',
          child: FaIcon(FontAwesomeIcons.cogs, color: Colors.white, size: 30,),

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
                        SharedPreferences prefs=await SharedPreferences.getInstance();
                        if(restaurants[index]['title']=='Training Center'){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> training_caretaker_list(prefs.getString('token'))));

                          // Trainings Page
                        }else if(restaurants[index]['title']=='Breeding'){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> breeding_caretaker_Category(prefs.getString('token'))));

                          // Breeding Page
                        }else if(restaurants[index]['title']=='Veterinary'){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> vet_category_mainpage()));
                          // Vet Page
                        }
                       else if(restaurants[index]['title']=='Farrier'){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>careTakerFarrierList(prefs.getString('token'))));
                          // Vet Pageelse{
                          // Farrier Page

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
//            FloatingActionButton(
//              backgroundColor: Colors.teal,
//              onPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
//              } ,
//              tooltip: 'Settings',
//              child: Icon(Icons.settings, color: Colors.white,),
//
//            )
          ],
        ),
      ),
    );
  }
}
