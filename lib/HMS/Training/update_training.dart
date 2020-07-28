import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class update_training extends StatefulWidget{
  String token;
  var training_data;
  String targetCompetition_initial_value;
  update_training(this.token,this.training_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_training(token,training_data);
  }
}
class _update_training extends State<update_training>{
  String token;
  var training_data;
  _update_training(this.token,this.training_data);
  String ddvalue,selected_horse,selected_trainer ;
  DateTime Start_date = DateTime.now();
  DateTime End_Date =DateTime.now();
  DateTime target_date=DateTime.now();
  String _excerciseplan="Select Excercise Plan";
  int selected_horse_id=0,selected_trainer_id=0,selected_training_type=0,selected_excercise_plan=0;
  sqlite_helper local_db;
  String training_type_initial_value,excercise_plan_initial_value,trainer_initial_value,target_date_inintial_value;
  String targetCompetition_initial_value;
  List<String> horses=[],trainers=[],excercise_plans=[],training_types=[];
  var training_response;

  var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController target_competition,training_center;
  bool _isvisible=false;
  bool horses_loaded=false;
  bool update_form_visibility=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.training_center=TextEditingController();
    this.target_competition=TextEditingController();
      print(training_data['targetCompetition']);
    if(training_data['trainingType']==1){
      setState(() {
        training_type_initial_value="Simple";
      });
    }else if(training_data['trainingType']==2){
      setState(() {
        training_type_initial_value="Endurance";
      });

    }else if(training_data['trainingType']==3){
      setState(() {
        training_type_initial_value="Customized";
        _isvisible=true;
      });
    }else if(training_data['trainingType']==4){
      setState(() {
        training_type_initial_value="Speed";
      });
    }
    setState(() {
      if(training_data['targetCompetition']!=null) {
        target_competition.text = training_data['targetCompetition'];
      }
      if(training_data['trainingCenter']!=null) {
        training_center.text = training_data['trainingCenter'];
      }
    });
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        network_operations.get_training_dropdowns(token).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              training_response=json.decode(response);
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Trainings"),),
        body: Visibility(
          visible: true,
          child: Scrollbar(
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
                              hint: Text("Training Type"),
                              initialValue: training_type_initial_value,
                              items: training_types_list.map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              onSaved: (value){
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
                               initialValue: get_plan_by_id(training_data['planId']),
                                hint: Text("Excercise Plan"),
                                items: excercise_plans!=null?excercise_plans.map((plans)=>DropdownMenuItem(
                                  child: Text(plans),
                                  value: plans,
                                )).toList():[""].map((name) => DropdownMenuItem(
                                    value: name, child: Text("$name")))
                                    .toList(),
                                onSaved: (value){
                                  setState(() {
                                    this._excerciseplan=value;
                                    this.selected_excercise_plan=excercise_plans.indexOf(value);
                                  });
                                },
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
                                initialValue: training_response!=null&&training_data['horseName']!=null?training_data['horseName']['name']:'',
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
                                onSaved: (value){
                                  setState(() {
                                    this.selected_horse=value;
                                    this.selected_horse_id=horses.indexOf(value);
                                  });
                                },
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
                              attribute: "date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              initialValue: DateTime.parse(training_data['startDate']),
                              decoration: InputDecoration(labelText: "Start Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onSaved: (value){
                                setState(() {
                                  this.Start_date=value;
                                });
                              },
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
                              attribute: "date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              initialValue:DateTime.parse(training_data['endDate']),
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              decoration: InputDecoration(labelText: "End Date",

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onSaved: (value){
                                setState(() {
                                  this.End_Date=value;
                                });
                              },
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
                               initialValue: training_data['targetDate']!=null?DateTime.parse(training_data['targetDate']):null,
                              validators: [FormBuilderValidators.required()],
                              format: DateFormat("MM-dd-yyyy"),
                              decoration: InputDecoration(labelText: "Target Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onSaved: (value){
                                setState(() {
                                  this.target_date=value;
                                });
                              },
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
                              initialValue: get_traininer_by_id(training_data['trainerId']),
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
                              onSaved: (value){
                                setState(() {
                                  this.selected_trainer=value;
                                  this.selected_trainer_id=trainers.indexOf(value);
                                });
                              },
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
                          child: add_training_button(fbKey: _fbKey, local_db: local_db, ddvalue: ddvalue, selected_horse: selected_horse, Start_date: Start_date, End_Date: End_Date, target_date: target_date, training_center: training_center, selected_trainer: selected_trainer, target_competition: target_competition, excerciseplan: _excerciseplan,token: token,selected_horse_id: selected_horse_id,selected_trainer_id: selected_trainer_id,training_response: training_response,selected_training_type: selected_training_type,training_data: training_data,selected_excercise_plan_id: selected_excercise_plan,),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
 String get_traininer_by_id(int id){
    var trainer_name='';
    if(training_response['trainerDropDown']!=null&&id!=null){
      for(int i=0;i<trainers.length;i++){
        if(training_response['trainerDropDown'][i]['id']==id){
          trainer_name=training_response['trainerDropDown'][i]['name'];
        }
      }
      return trainer_name;
    }else
      return null;
  }
  String get_plan_by_id(int id){
    var plan_name;
    if(training_response!=null&&training_response['trainingPlans']!=null&&id!=null){
      for(int i=0;i<excercise_plans.length;i++){
        if(training_response['trainingPlans'][i]['id']==id){
           plan_name=training_response['trainingPlans'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
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
    @required this.training_data,
    @required this.selected_excercise_plan_id,
  }) : _fbKey = fbKey, super(key: key);
  final int selected_horse_id;
  final int selected_trainer_id;
  final int selected_training_type;
  final int selected_excercise_plan_id;
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
  final training_data;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: () {
        if (_fbKey.currentState.validate()) {
          _fbKey.currentState.save();
          print(selected_trainer_id.toString());

          if(!End_Date.isAfter(Start_date)){
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Starting Date should be before the Ending Date"),
            ));
          }else{
            Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                pd.style(message: "Updating Training...");
                pd.show();
                network_operations.add_training(training_data['trainingId'],1,Start_date, End_Date,training_response['horses'][selected_horse_id]['id'], training_center.text, target_date, target_competition.text,token,training_response['trainerDropDown'][selected_trainer_id]['id'],selected_horse,selected_excercise_plan_id==0?null:selected_excercise_plan_id,selected_trainer!=null?selected_trainer:'',excerciseplan!=null?excerciseplan:'',training_data['createdBy']).then((response){
                  pd.dismiss();
                  if(response!=null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Training Updated Sucessfully"),
                    ));
                    Navigator.pop(context);
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Training not Updated"),
                    ));
                    Navigator.pop(context);
                  }
                });
              }else{
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Network Not Available"),
                ));
              }
            });

          }

        }
      },
      child:Text("Update Training",style: TextStyle(color: Colors.white),),
    );
  }
}