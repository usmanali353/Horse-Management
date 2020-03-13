import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_json.dart';
import 'dart:convert';
import  'package:flutter_form_builder/flutter_form_builder.dart';


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
    this.name=TextEditingController();
    this.comments=TextEditingController();
    this.primaryvaccination=TextEditingController();
    this.booster=TextEditingController();
    this.revaccination=TextEditingController();
    this.firstdose=TextEditingController();
    this.seconddose=TextEditingController();
    this.thirddose=TextEditingController();
    // local_db=sqlite_helper();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Vaccines"),),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now(),
                      'accept_terms': false,
                    },
                    autovalidate: true,
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
                            attribute: "Reminder",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Reminder"),
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
                            decoration: InputDecoration(labelText: "Reminder",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal,
                                      width: 1.0)
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value == "Yes")
                                  selected_reminder_id = true;
                                else if (value == "No")
                                  selected_reminder_id = false;
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: FormBuilderDropdown(
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




                        MaterialButton(
                          onPressed: () {
                            //_fbKey.currentState.save();
                            if (_fbKey.currentState.validate()) {
                              print(_fbKey.currentState.value);
                              VaccinesServices.addVaccines(token, specificvaccine['id'], name.text, comments.text,selected_reminder_id, usage_id, primaryvaccination.text, booster.text, revaccination.text, firstdose.text, seconddose.text, thirddose.text, specificvaccine['createdBy']).then((response) {
                                setState(() {
                                  var parsedjson = jsonDecode(response);
                                  if (parsedjson != null) {
                                    if (parsedjson['isSuccess'] == true) {
                                      print("Successfully data saved");
                                    } else
                                      print("not saved");
                                  } else
                                    print("json response null");
                                });
                              });
                            }
                          },
                          child: Text("Update", style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ])));
  }





}