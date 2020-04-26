import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Training/trainingMainPage.dart';
import 'package:horse_management/HMS/Training/trainingPlansList.dart';
import 'package:horse_management/HMS/Training/training_list.dart';

import 'package:horse_management/animations/fadeAnimation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class training_options extends StatefulWidget{
  String token;
  training_options(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_options_state(token);
  }
}


class _training_options_state extends State<training_options>{
  String token;
  _training_options_state(this.token);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Training Center"),

        ),
        body: FadeAnimation(2.4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text("Traing List"),
                      subtitle: Text("Add & Show Training List"),
                      leading: Icon(Icons.list,size: 40,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>trainingMainPage(prefs.getString("token"))));
                      },
                    ),
                    ListTile(
                      title: Text("Training Plans"),
                      subtitle: Text("Add & Show Training Plans"),
                      leading: Icon(Icons.featured_play_list,size: 40, color: Colors.yellow,),
                      trailing: Icon(Icons.arrow_right),
                      onTap: ()async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>trainingPlanList(prefs.getString("token"))));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}