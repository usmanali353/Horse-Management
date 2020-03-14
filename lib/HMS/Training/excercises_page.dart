import 'package:flutter/material.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class excercises extends StatefulWidget {
  String trainingPlanName,trainingPlanDescription;

  excercises(this.trainingPlanName, this.trainingPlanDescription);

  @override
  _excercisesState createState() => _excercisesState(trainingPlanName,trainingPlanDescription);
}

class _excercisesState extends State<excercises> {
  var nameTECs = <TextEditingController>[];
  var descriptionTECs = <TextEditingController>[];
  var cards = <Card>[];
  String trainingPlanName,trainingPlanDescription;

  _excercisesState(this.trainingPlanName, this.trainingPlanDescription);

  Card createCard() {
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    nameTECs.add(nameController);
    descriptionTECs.add(descriptionController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Excercise ${cards.length + 1}'),
          TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Excercise Name')
          ),
          TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Excercise Description')
          ),
      ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onDone(String token) {
    List<Map> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name = nameTECs[i].text;
      var description = descriptionTECs[i].text;
      if(name!=null&&description!=null) {
        entries.add(Excercise(name, description,DateTime.now(),true).toJson());
      }
    }
    Utils.check_connectivity().then((result){
      print(entries.length.toString());
      if(result){
        ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
         network_operations.addTrainingPlan(token, 0, entries,trainingPlanName, '').then((response){
           pd.dismiss();
            if(response!=null){

            }
         });
      }else{

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Excercises"),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text('add new'),
              onPressed: () => setState(() => cards.add(createCard())),
            ),
          )
        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.done), onPressed:() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _onDone(prefs.getString("token"));
      } ),
    );
  }
}

class Excercise {
  final String name;
  final String description;
  final DateTime createdOn;
  final bool isActive;
  Excercise(this.name, this.description,this.createdOn,this.isActive);
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"]=description;
    map["createdOn"]=createdOn;
    map["isActive"]=isActive;
    return map;
  }
}