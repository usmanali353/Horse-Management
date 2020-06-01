import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_json.dart';
import 'dart:convert';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';


class update_vaccines extends StatefulWidget{
  final token;
  var specificvaccine;
  update_vaccines (this.token, this.specificvaccine);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_vaccines(token,specificvaccine);
  }
}



class _update_vaccines extends State<update_vaccines> {

  final token;
  var specificvaccine;
  String  select_usage_type;
  DateTime Select_date = DateTime.now();
  bool selected_reminder_id;
  TextEditingController name, comments, primaryvaccination, booster, revaccination, firstdose, seconddose, thirddose;
  bool services_loaded=false;
  bool update_services_visibility;

  _update_vaccines(this.token, this.specificvaccine);

  List<String>
  usage_type = [
    "Normal", "Gestation", "Both"
  ],
      is_reminder = ['Yes', 'No'];
//  var breeddropdown;
//  var data;
  bool normal_loaded = false,
      gestation_loaded = false,
      both_loaded = false;
  int usage_id;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.name=TextEditingController();
    this.comments=TextEditingController();
    this.primaryvaccination=TextEditingController();
    this.booster=TextEditingController();
    this.revaccination=TextEditingController();
    this.firstdose=TextEditingController();
    this.seconddose=TextEditingController();
    this.thirddose=TextEditingController();
    setState(() {
      if(specificvaccine['name']!=null){
        name.text=specificvaccine['name'];
      }
      if(specificvaccine['comments']!=null){
        comments.text=specificvaccine['comments'];
      }
      if(specificvaccine['primaryVaccination']!=null){
        primaryvaccination.text=specificvaccine['primaryVaccination'].toString();
      }
      if(specificvaccine['booster']!=null){
        booster.text=specificvaccine['booster'].toString();
      }
      if(specificvaccine['revaccination']!=null){
        revaccination.text=specificvaccine['revaccination'].toString();
      }
      if(specificvaccine['doze1MonthNo']!=null){
        firstdose.text=specificvaccine['doze1MonthNo'].toString();
      }
      if(specificvaccine['doze2MonthNo']!=null){
        seconddose.text=specificvaccine['doze2MonthNo'].toString();
      }
      if(specificvaccine['doze3MonthNo']!=null){
        thirddose.text=specificvaccine['doze3MonthNo'].toString();
      }
    });

  }
  String get_yesno(bool b){
    var yesno;
    if(b!=null){
      if(b){
        yesno="Yes";
      }else {
        yesno = "No";
      }
    }
    return yesno;
  }
//  @override
//  void initState() {
//    this.name=TextEditingController();
//    this.comments=TextEditingController();
//    this.primaryvaccination=TextEditingController();
//    this.booster=TextEditingController();
//    this.revaccination=TextEditingController();
//    this.firstdose=TextEditingController();
//    this.seconddose=TextEditingController();
//    this.thirddose=TextEditingController();
//    // local_db=sqlite_helper();
//
//
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Vaccines"),),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                   // autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: FormBuilderTextField(
                            controller: name,
                            attribute: 'text',
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1,
                            //validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Vaccine Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal,
                                      width: 1.0)
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: FormBuilderTextField(
                            controller: comments,
                            attribute: 'text',
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1,
                            //validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Comments",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal,
                                      width: 1.0)
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Show Reminder",
                            initialValue: get_yesno(specificvaccine['reminder']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Show Reminder"),
                            items: is_reminder != null ? is_reminder.map((trainer) =>
                                DropdownMenuItem(
                                  child: Text(trainer),
                                  value: trainer,
                                )).toList() : [""].map((name) =>
                                DropdownMenuItem(
                                    value: name, child: Text("$name")))
                                .toList(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .body1,
                            decoration: InputDecoration(labelText: "Show Reminder",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal,
                                      width: 1.0)
                              ),
                            ),
                            onSaved: (value){
                              setState(() {
                                if(value=="Yes"){
                                  selected_reminder_id =true;
                                }else{
                                  selected_reminder_id=false;
                                }
                              });
                            },
                            onChanged: (value){
                              setState(() {
                                if(value=="Yes"){
                                  selected_reminder_id=true;
                                }else{
                                  selected_reminder_id=false;
                                }
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: FormBuilderDropdown(
                              initialValue: specificvaccine['usage']!=null?usage_type[specificvaccine['usage']]:null,

                              attribute: "Usage",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              decoration: InputDecoration(labelText: "Usage",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal,
                                        width: 1.0)
                                ),
                              ),
                              // initialValue: 'Male',
                              hint: Text('Select Service'),
                              validators: [FormBuilderValidators.required()],
                              items: usage_type
                                  .map((name) =>
                                  DropdownMenuItem(
                                      value: name, child: Text("$name")))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  if (value == "Normal") {
                                    setState(() {
                                      normal_loaded = true;
                                      firstdose.text = null;
                                      seconddose.text = null;
                                      thirddose.text = null;
                                      gestation_loaded = false;
                                      both_loaded = false;
                                    });
                                  }
                                  if (value == "Gestation") {
                                    setState(() {
                                      gestation_loaded = true;
                                      normal_loaded = false;
                                      both_loaded = false;
                                      primaryvaccination.text = null;
                                      booster.text = null;
                                      revaccination.text = null;
                                    });
                                  }
                                  if (value == "Both") {
                                    setState(() {
                                      both_loaded = true;
                                      gestation_loaded = false;
                                      normal_loaded = false;
                                    });
                                  }
                                  this.select_usage_type = value;
                                  this.usage_id = usage_type.indexOf(value);
                                });
                              }
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: normal_loaded,
                            child: FormBuilderTextField(
                              controller: primaryvaccination,
                              keyboardType: TextInputType.number,
                              attribute: 'Primary Vaccination',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Primary Vaccination",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: normal_loaded,
                            child: FormBuilderTextField(
                              controller: booster,
                              keyboardType: TextInputType.number,
                              attribute: 'Booster',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Booster",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: normal_loaded,
                            child: FormBuilderTextField(
                              controller: revaccination,
                              keyboardType: TextInputType.number,
                              attribute: 'Revaccination',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Revaccination",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: gestation_loaded,
                            child: FormBuilderTextField(
                              controller: firstdose,
                              keyboardType: TextInputType.number,
                              attribute: '1st dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "1st dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: gestation_loaded,
                            child: FormBuilderTextField(
                              controller: seconddose,
                              keyboardType: TextInputType.number,
                              attribute: '2nd dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "2nd dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: gestation_loaded,
                            child: FormBuilderTextField(
                              controller: thirddose,
                              keyboardType: TextInputType.number,
                              attribute: '3rd dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "3rd dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: primaryvaccination,
                              keyboardType: TextInputType.number,
                              attribute: 'Primary Vaccination',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Primary Vaccination",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: booster,
                              keyboardType: TextInputType.number,
                              attribute: 'Booster',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Booster",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: revaccination,
                              keyboardType: TextInputType.number,
                              attribute: 'Revaccination',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Revaccination",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: firstdose,
                              keyboardType: TextInputType.number,
                              attribute: '1st dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "1st dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: seconddose,
                              keyboardType: TextInputType.number,
                              attribute: '2nd dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "2nd dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Visibility(
                            visible: both_loaded,
                            child: FormBuilderTextField(
                              controller: thirddose,
                              keyboardType: TextInputType.number,
                              attribute: '3rd dose - Month #',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body1,
                              //validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "3rd dose - Month #",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                        ),

                        Builder(
                            builder:(BuildContext context){
                              return Center(
                                  child:Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:MaterialButton(
                                        color: Colors.teal,
                                        child: Text("Update",style: TextStyle(color: Colors.white),),
                                        onPressed: (){
                                          if (_fbKey.currentState.validate()) {
                                            Utils.check_connectivity().then((result){
                                              if(result){
                                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                                pd.show();
                                                VaccinesServices.addVaccines(token, specificvaccine['id'], name.text, comments.text,selected_reminder_id, usage_id, primaryvaccination.text, booster.text, revaccination.text, firstdose.text, seconddose.text, thirddose.text, specificvaccine['createdBy'])              .then((respons){
                                                  pd.dismiss();
                                                  if(respons!=null){
                                                    Scaffold.of(context).showSnackBar(SnackBar(
                                                      content: Text("Vaccines Updated Successfully",
                                                        style: TextStyle(
                                                            color: Colors.red
                                                        ),
                                                      ),
                                                      backgroundColor: Colors.green,
                                                    ));
                                                    Navigator.pop(context);
                                                  }else{
                                                    Scaffold.of(context).showSnackBar(SnackBar(
                                                      content: Text("Vaccines Updated Failed",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                      backgroundColor: Colors.red,
                                                    ));
                                                  }
                                                });
                                              }
                                            });
                                          }
                                        },

                                      )
                                  )
                              );
                            }

                        ),


//                        MaterialButton(
//                          onPressed: () {
//                            if (_fbKey.currentState.validate()) {
//                              _fbKey.currentState.save();
//                              Utils.check_connectivity().then((result){
//                                if(result){
//                                  ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
//                                  pd.show();
//                                  VaccinesServices.addVaccines(token, specificvaccine['id'], name.text, comments.text,selected_reminder_id, usage_id, primaryvaccination.text, booster.text, revaccination.text, firstdose.text, seconddose.text, thirddose.text, specificvaccine['createdBy'])                                      .then((respons){
//                                    pd.dismiss();
//                                    if(respons!=null){
//                                      Scaffold.of(context).showSnackBar(SnackBar(
//                                        content: Text("Vaccine Updated"),
//                                        backgroundColor: Colors.green,
//                                      ));
//                                      Navigator.pop(context);
//                                    }else{
//                                      Scaffold.of(context).showSnackBar(SnackBar(
//                                        content: Text("Vaccine not Updated"),
//                                        backgroundColor: Colors.red,
//                                      ));
//                                    }
//                                  });
//                                }
//                              });
//                            }
//                          },
//                          child: Text("Update", style: TextStyle(color: Colors.white),
//                          ),
//                          color: Colors.teal,
//                        ),
                      ],
                    ),
                  ),
                ])));
  }





}