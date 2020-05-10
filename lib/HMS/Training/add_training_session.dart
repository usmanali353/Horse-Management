//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import  'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:horse_management/HMS/Tanks/tanks_json.dart';
//import 'package:intl/intl.dart';
//import 'package:progress_dialog/progress_dialog.dart';
//
//import '../../Utils.dart';
//
//class add_training_session extends StatefulWidget{
//  final token;
//  add_training_session(this.token);
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _add_training_session(token);
//  }
//
//}
//class _add_training_session extends State<add_training_session>{
//
//  String selected_contact,selected_costcenter,selected_account_category,selected_currency,selected_trainer;
//  int selected_contact_id,selected_costcenter_id,selected_account_category_id,selected_currency_id, selected_trainer_id;
//  List<String> contacts=[],cost_center=[], currency=[],account_category=[],trainer=[];
//  final token;
//  _add_training_session(this.token);
//  DateTime date = DateTime.now();
//
//  var session_response;
//  TextEditingController hours, minutes, seconds, milli, ammount, comments;
//
//  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
////  bool _isvisible=false;
////  //bool notes_loaded=false;
////  bool update_notes_visibility;
//
//
//  @override
//  void initState() {
//    this.hours=TextEditingController();
//    this.minutes=TextEditingController();
//    this.seconds=TextEditingController();
//    this.milli=TextEditingController();
//    this.ammount=TextEditingController();
//    this.comments=TextEditingController();
//    // local_db=sqlite_helper();
////    Utils.check_connectivity().then((result){
////      if(result){
////        TanksServices.get_Tanks_dropdowns(token).then((response){
////          if(response!=null){
////            print(response);
////            setState(() {
////              session_response=json.decode(response);
////              for(int i=0;i<session_response['locationDropDown'].length;i++)
////                tanks.add(session_response['locationDropDown'][i]['name']);
////              //notes_loaded=true;
////              update_notes_visibility=true;
////            });
////          }
////        });
////      }else{
////        print("Network Not Available");
////      }
////    });
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(title: Text("Add Training Session"),),
//      body:  Padding(
//        padding: EdgeInsets.all(10),
//        child: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              FormBuilder(
//                key: _fbKey,
//                child: Column(children: <Widget>[
//                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
//                    child:  FormBuilderDateTimePicker(
//                      onChanged: (value){
//                        this.date=value;
//                      },
//                      attribute: "date",
//                      style: Theme.of(context).textTheme.body1,
//                      inputType: InputType.date,
//                      validators: [FormBuilderValidators.required()],
//                      format: DateFormat("dd-MM-yyyy"),
//                      decoration: InputDecoration(labelText: "Date",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: Visibility(
//                      //visible: sale_loaded,
//                      child: FormBuilderDropdown(
//                        attribute: "Trainer",
//                        validators: [FormBuilderValidators.required()],
//                        hint: Text("Trainer"),
//                        items:trainer!=null?trainer.map((horse)=>DropdownMenuItem(
//                          child: Text(horse),
//                          value: horse,
//                        )).toList():[""].map((name) => DropdownMenuItem(
//                            value: name, child: Text("$name")))
//                            .toList(),
//                        style: Theme.of(context).textTheme.body1,
//                        decoration: InputDecoration(labelText: "Trainer",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value){
//                          setState(() {
//                            this.selected_trainer=value;
//                            this.selected_trainer_id=trainer.indexOf(value);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                  Padding(padding: EdgeInsets.only(top:30,right: 250),
//                      child: Text("Length/Duration", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: FormBuilderTextField(
//                      keyboardType: TextInputType.number,
//                      controller: hours,
//                      attribute: "Hours",
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Hours",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: FormBuilderTextField(
//                      keyboardType: TextInputType.number,
//                      controller: minutes,
//                      attribute: "Minutes",
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Minutes",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: FormBuilderTextField(
//                      keyboardType: TextInputType.number,
//                      controller: seconds,
//                      attribute: "Seconds",
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Seconds",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: FormBuilderTextField(
//                      keyboardType: TextInputType.number,
//                      controller: milli,
//                      attribute: "Milli",
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Milli",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top: 16,right: 16,left: 16),
//                    child: FormBuilderTextField(
//                      controller: ammount,
//                      attribute: "Amount",
//                      keyboardType: TextInputType.number,
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Amount",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
//                    child: Visibility(
//                      // visible: currency_loaded,
//                      child: FormBuilderDropdown(
//                        attribute: "Currency",
//                        validators: [FormBuilderValidators.required()],
//                        hint: Text("Currency"),
//                        items:currency!=null?currency.map((horse)=>DropdownMenuItem(
//                          child: Text(horse),
//                          value: horse,
//                        )).toList():[""].map((name) => DropdownMenuItem(
//                            value: name, child: Text("$name")))
//                            .toList(),
//                        style: Theme.of(context).textTheme.body1,
//                        decoration: InputDecoration(labelText: "Currency",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value){
//                          setState(() {
//                            this.selected_currency=value;
//                            this.selected_currency_id=currency.indexOf(value);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
//                    child: Visibility(
//                      // visible: account_category_loaded,
//                      child: FormBuilderDropdown(
//                        attribute: "Account Category",
//                        validators: [FormBuilderValidators.required()],
//                        hint: Text("Account Category"),
//                        items:account_category!=null?account_category.map((horse)=>DropdownMenuItem(
//                          child: Text(horse),
//                          value: horse,
//                        )).toList():[""].map((name) => DropdownMenuItem(
//                            value: name, child: Text("$name")))
//                            .toList(),
//                        style: Theme.of(context).textTheme.body1,
//                        decoration: InputDecoration(labelText: "Account Category",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value){
//                          setState(() {
//                            this.selected_account_category=value;
//                            this.selected_account_category_id=account_category.indexOf(value);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
//                    child: Visibility(
//                      //  visible: account_category_loaded,
//                      child: FormBuilderDropdown(
//                        attribute: "Cost Center",
//                        validators: [FormBuilderValidators.required()],
//                        hint: Text("Cost Center"),
//                        items:cost_center!=null?cost_center.map((horse)=>DropdownMenuItem(
//                          child: Text(horse),
//                          value: horse,
//                        )).toList():[""].map((name) => DropdownMenuItem(
//                            value: name, child: Text("$name")))
//                            .toList(),
//                        style: Theme.of(context).textTheme.body1,
//                        decoration: InputDecoration(labelText: "Cost Center",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value){
//                          setState(() {
//                            this.selected_costcenter=value;
//                            this.selected_costcenter_id=cost_center.indexOf(value);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 16,left: 16,right:16),
//                    child: Visibility(
//                      // visible: account_category_loaded,
//                      child: FormBuilderDropdown(
//                        attribute: "Contact",
//                        validators: [FormBuilderValidators.required()],
//                        hint: Text("Contact"),
//                        items:contacts!=null?contacts.map((horse)=>DropdownMenuItem(
//                          child: Text(horse),
//                          value: horse,
//                        )).toList():[""].map((name) => DropdownMenuItem(
//                            value: name, child: Text("$name")))
//                            .toList(),
//                        style: Theme.of(context).textTheme.body1,
//                        decoration: InputDecoration(labelText: "Contact",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value){
//                          setState(() {
//                            this.selected_contact=value;
//                            this.selected_contact_id=contacts.indexOf(value);
//                          });
//                        },
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
//                    child: FormBuilderTextField(
//                      //keyboardType: TextInputType.number,
//                      controller: comments,
//                      attribute: "Comments",
//                      validators: [FormBuilderValidators.required()],
//                      decoration: InputDecoration(labelText: "Comments",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
//                      ),
//                    ),
//                  ),
//
//
//                  MaterialButton(
//                    onPressed: (){
//                      if (_fbKey.currentState.validate()) {
//                        Utils.check_connectivity().then((result){
//                          if(result){
//                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
//                            pd.show();
//                            //TanksServices.add_Tanks(null,token,0,name.text,session_response['locationDropDown'][selected_tanks_id]['locationId'], capacity.text,lastfill_date,nextfill_date,policynumber.text,policydue_date)
//                                .then((respons)
//                          {
//                              pd.dismiss();
//                              setState(() {
//                                var parsedjson  = jsonDecode(respons);
//                                if(parsedjson != null){
//                                  if(parsedjson['isSuccess'] == true){
//                                    print("Successfully data updated");
//                                  }else
//                                    print("not saved");
//                                }else
//                                  print("json response null");
//                              });
//                            });
//                          }
//                        });
//                      }
//                    },
//                    child: Text("Save",style: TextStyle(color: Colors.white),
//                    ),
//                    color: Colors.teal,
//                  ),
//                ],
//                ),
//              ),
//
//            ],
//          ),
//        ),
//
//      ),
//    );
//
//  }
//}