import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_json.dart';
import 'dart:convert';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class add_vaccines extends StatefulWidget{
  final token;
  add_vaccines (this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_vaccines(token);
  }
}



class _add_vaccines extends State<add_vaccines> {

  final token;
  String  select_usage_type;
  DateTime Select_date = DateTime.now();
  bool selected_reminder_id;
  TextEditingController name, comments, primaryvaccination, booster, revaccination, firstdose, seconddose, thirddose;
  bool services_loaded=false;
  bool update_services_visibility;

  _add_vaccines(this.token);

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
//    Utils.check_connectivity().then((result){
//      if(result){
//        BreedingServicesJson.get_breeding_service_dropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              breeddropdown=json.decode(response);
//              for(int i=0;i<breeddropdown['sireDropDown'].length;i++)
//                sire.add(breeddropdown['sireDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['damDropDown'].length;i++)
//                dam.add(breeddropdown['damDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['donorDropDown'].length;i++)
//                donor.add(breeddropdown['donorDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['currencyDropDown'].length;i++)
//                currency.add(breeddropdown['currencyDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['contactsDropDown'].length;i++)
//                contact.add(breeddropdown['contactsDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['categoryDropDown'].length;i++)
//                category.add(breeddropdown['categoryDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['costCenterDropDown'].length;i++)
//                cost_center.add(breeddropdown['costCenterDropDown'][i]['name']);
//              for(int i=0;i<breeddropdown['horseDropDown'].length;i++)
//                horse_name.add(breeddropdown['horseDropDown'][i]['name']);
//              services_loaded=true;
//              update_services_visibility=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });

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
                if (_fbKey.currentState.validate()) {
                  Utils.check_connectivity().then((result){
                    if(result){
                      ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                      pd.show();
                      VaccinesServices.addVaccines(token, 0, name.text, comments.text,selected_reminder_id, usage_id, primaryvaccination.text, booster.text, revaccination.text, firstdose.text, seconddose.text, thirddose.text, null)                                      .then((respons){
                        pd.dismiss();
                        if(respons!=null){
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content: Text("Saved "),
//                            backgroundColor: Colors.green,
//                          ));
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Not Saved "),
                            backgroundColor: Colors.red,
                          ));
                        }
                      });
                    }
                  });
                }
              },
              child: Text("Save", style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    ])));
  }





}