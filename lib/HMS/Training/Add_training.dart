
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/Model/Training.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class add_training extends StatefulWidget{
  String token;

  add_training(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_training_state(token);
  }
}



class _add_training_state extends State<add_training>{
  String token;
  _add_training_state(this.token);
  String ddvalue,selected_horse,selected_trainer ;
   DateTime Start_date = DateTime.now();
   DateTime End_Date =DateTime.now();
   DateTime target_date=DateTime.now();
   String _excerciseplan;
   int selected_horse_id=0,selected_trainer_id=0,selected_training_type=0,selected_excercise_plan=0;
   sqlite_helper local_db;

   List<String> horses=[],trainers=[],excercise_plans=[],training_types=[];
    var training_response;
   var training_types_list=['Simple','Endurance','Customized','Speed'];
   TextEditingController target_competition,training_center;
   bool _isvisible=false;
   bool horses_loaded=false;
   final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
   @override
   void initState() {
     this.training_center=TextEditingController();
     this.target_competition=TextEditingController();
     local_db=sqlite_helper();
     Utils.openBox("AddTrainingDropDowns").then((resp){
       Utils.check_connectivity().then((result){
         if(result){
           ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
           pd.show();
           network_operations.get_training_dropdowns(token).then((response){
             pd.dismiss();
             if(response!=null){
               setState(() {
                 training_response=json.decode(response);

                 Hive.box("AddTrainingDropDowns").put("offline_training_dropdowns", training_response);
                 if(training_response!=null){
                   if(training_response['horses']!=null&&training_response['horses'].length>0){
                     for(int i=0;i<training_response['horses'].length;i++)
                       horses.add(training_response['horses'][i]['name']);
                     horses_loaded=true;
                   }
                   if(training_response['trainerDropDown']!=null&&training_response['trainerDropDown'].length>0){
                     for(int i=0;i<training_response['trainerDropDown'].length;i++)
                       trainers.add(training_response['trainerDropDown'][i]['name']);
                   }
                   if(training_response['trainingPlans']!=null&&training_response['trainingPlans'].length>0){
                     for(int i=0;i<training_response['trainingPlans'].length;i++)
                       excercise_plans.add(training_response['trainingPlans'][i]['name']);
                   }
                 }
               });
             }
           });
         }else{
           setState(() {
             training_response=Hive.box("AddTrainingDropDowns").get("offline_training_dropdowns");
             if(training_response!=null){
               if(training_response['horses']!=null&&training_response['horses'].length>0){
                 for(int i=0;i<training_response['horses'].length;i++)
                   horses.add(training_response['horses'][i]['name']);
                 horses_loaded=true;
               }
               if(training_response['trainerDropDown']!=null&&training_response['trainerDropDown'].length>0){
                 for(int i=0;i<training_response['trainerDropDown'].length;i++)
                   trainers.add(training_response['trainerDropDown'][i]['name']);
               }
               if(training_response['trainingPlans']!=null&&training_response['trainingPlans'].length>0){
                 for(int i=0;i<training_response['trainingPlans'].length;i++)
                   excercise_plans.add(training_response['trainingPlans'][i]['name']);
               }
             }
           });
         }
       });
     });


   }

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Trainings"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
                Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: FormBuilderDropdown(
                              attribute: "Training Type",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Select Training"),
                              items: training_types_list.map((name) => DropdownMenuItem(
                               value: name, child: Text("$name")))
                               .toList(),
                              onChanged: (value){
                                setState(() {
                                   this.selected_training_type=training_types_list.indexOf(value)+1;
                                  this.ddvalue=value;
                                  if(value=="Customized"){
                                    setState(() {
                                      _isvisible=true;
                                    });
                                  }else{
                                    setState(() {
                                      _isvisible=false;
                                    });
                                  }
                                });
                              },
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Training Type",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                            child: Visibility(
                              visible: _isvisible,
                              child:FormBuilderDropdown(
                                attribute: "Exercise Plan",
                                hint: Text("Excercise Plan"),
                                items: excercise_plans!=null?excercise_plans.map((plans)=>DropdownMenuItem(
                                  child: Text(plans),
                                  value: plans,
                                )).toList():[""].map((name) => DropdownMenuItem(
                                    value: name, child: Text("$name")))
                                    .toList(),

                                onChanged: (value){
                                   setState(() {
                                     this._excerciseplan=value;
                                     this.selected_excercise_plan=excercise_plans.indexOf(value);
                                   });
                                },
                                style: Theme.of(context).textTheme.body1,
                                decoration: InputDecoration(labelText: "Excercise Plan",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                  ),
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,right: 16),
                            child: Visibility(
                              visible: horses_loaded,
                              child: FormBuilderDropdown(
                                attribute: "Horse",
                                validators: [FormBuilderValidators.required()],
                                hint: Text("Horse"),
                                items:horses!=null?horses.map((horse)=>DropdownMenuItem(
                                  child: Text(horse),
                                  value: horse,
                                )).toList():[""].map((name) => DropdownMenuItem(
                                    value: name, child: Text("$name")))
                                    .toList(),
                                style: Theme.of(context).textTheme.body1,
                                decoration: InputDecoration(labelText: "Horse",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                  ),
                                ),
                                onChanged: (value){
                                 setState(() {
                                   this.selected_horse=value;
                                   this.selected_horse_id=horses.indexOf(value);
                                 });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child:FormBuilderDateTimePicker(
                              attribute: "Start Date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              decoration: InputDecoration(labelText: "Start Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onChanged: (value){
                               setState(() {
                                 this.Start_date=value;
                               });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child:FormBuilderDateTimePicker(
                              attribute: "End Date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              decoration: InputDecoration(labelText: "End Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onChanged: (value){
                               setState(() {
                                 this.End_Date=value;
                               });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child:FormBuilderDateTimePicker(
                              attribute: "date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              decoration: InputDecoration(labelText: "Target Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onChanged: (value){
                               setState(() {
                                 this.target_date=value;
                               });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Trainer",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Trainer"),
                              items: trainers!=null?trainers.map((trainer)=>DropdownMenuItem(
                                child: Text(trainer),
                                value: trainer,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Trainer",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_trainer=value;
                                  this.selected_trainer_id=trainers.indexOf(value);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: FormBuilderTextField(
                              controller: training_center,
                              attribute: "Training Center",
                              validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Training Center",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16,right: 16),
                            child: FormBuilderTextField(
                              controller: target_competition,
                              validators: [FormBuilderValidators.required()],
                              attribute: "Target Competition",
                              decoration: InputDecoration(labelText: "Target Competition",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child:Padding(
                        padding: const EdgeInsets.all(16),
                        child: add_training_button(fbKey: _fbKey, local_db: local_db, ddvalue: ddvalue, selected_horse: selected_horse, Start_date: Start_date, End_Date: End_Date, target_date: target_date, training_center: training_center, selected_trainer: selected_trainer, target_competition: target_competition, excerciseplan: _excerciseplan,token: token,selected_horse_id: selected_horse_id,selected_trainer_id: selected_trainer_id,training_response: training_response,selected_training_type: selected_training_type,selected_excercise_plan: selected_excercise_plan,),
                      )
                    )
                  ],
                )
              ],
        ),
      )
    );
  }

}

class add_training_button extends StatelessWidget {
  const add_training_button({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.local_db,
    @required this.ddvalue,
    @required this.selected_horse,
    @required this.Start_date,
    @required this.End_Date,
    @required this.target_date,
    @required this.training_center,
    @required this.selected_trainer,
    @required this.target_competition,
    @required this.excerciseplan,
    @required this.token,
    @required this.selected_horse_id,
    @required this.selected_trainer_id,
    @required this.training_response,
    @required this.selected_training_type,
    @required this.selected_excercise_plan
  }) : _fbKey = fbKey, super(key: key);
  final int selected_horse_id;
  final int selected_trainer_id;
  final int selected_training_type;
  final int selected_excercise_plan;
  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final sqlite_helper local_db;
  final String ddvalue;
  final String selected_horse;
  final DateTime Start_date;
  final DateTime End_Date;
  final DateTime target_date;
  final TextEditingController training_center;
  final String selected_trainer;
  final TextEditingController target_competition;
  final String excerciseplan;
  final training_response;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: () {
        if (_fbKey.currentState.validate()) {
          Utils.openBox("AddTrainingData").then((resp){
            Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                pd.show();
                if(Hive.box("AddTrainingData").get("addTrainingJson")!=null){
                  Training tr=Training.fromMap(Hive.box("AddTrainingData").get("addTrainingJson"));
                  network_operations.add_training(0, tr.training_type_id, DateTime.parse(tr.start_date), DateTime.parse(tr.end_date), tr.horse_id, tr.training_center, DateTime.parse(tr.target_date),tr.target_competition, token, tr.trainer_id, tr.horse_name, tr.excercise_plan_id, tr.trainer_name, tr.excercise_plan, '').then((response){
                    pd.dismiss();
                    print(response);
                    if(response!=null) {
                      Hive.box("AddTrainingData").delete("addTrainingJson");
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Previously Stored Training Added Sucessfully"),
                      ));
                    }else{
                      Hive.box("AddTrainingData").delete("addTrainingJson");
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Previously Stored Training not Added"),
                      ));
                    }
                  });
                }else{
                  network_operations.add_training(0,selected_training_type,Start_date, End_Date,training_response['horses'][selected_horse_id]['id'], training_center.text, target_date, target_competition.text,token,training_response['trainerDropDown'][selected_trainer_id]['id'],selected_horse,training_response['trainingPlans'][selected_excercise_plan]['id']!=null?training_response['trainingPlans'][selected_excercise_plan]['id']:null,selected_trainer!=null?selected_trainer:'',excerciseplan!=null?excerciseplan:null,'').then((response){
                    pd.dismiss();
                    print(response);
                    if(response!=null) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Training Added Sucessfully"),
                      ));
                      Navigator.pop(context);
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Training not Added"),
                      ));
                    }
                  });
                }
              }else{
                  Hive.box("AddTrainingData").put("addTrainingJson",Training(selected_horse,selected_trainer,'',training_center.text,Start_date.toString(),End_Date.toString(),target_date.toString(),'',selected_horse_id,selected_trainer_id,selected_training_type,selected_excercise_plan,target_competition.text).toMap());
              }
            });
          });


        }
      },
      child:Text("Add Training",style: TextStyle(color: Colors.white),),
    );
  }
}