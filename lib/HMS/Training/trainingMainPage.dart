import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Training/already_trained_horses_list.dart';
import 'package:horse_management/HMS/Training/trainingPlansList.dart';
import 'package:horse_management/HMS/Training/training_list.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';

class trainingMainPage extends StatefulWidget{
  String token;

  trainingMainPage(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return trainingMainPageState(token);
  }

}
class trainingMainPageState extends State<trainingMainPage>{
  String token;

  trainingMainPageState(this.token);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Trainings"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Ongoing Trainings",),
              Tab(text: "Already Trained Horses",),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            training_list(token),
            already_trained_horses_list(token),
          ],
        ),
      )
    );
  }

}