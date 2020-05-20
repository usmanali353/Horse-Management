import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Tanks/tanks_json.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/Network_Operations.dart';


import '../../Utils.dart';

class add_training_session extends StatefulWidget{
  final token;
  var list;
  add_training_session(this.token,this.list);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_training_session(token,list);
  }

}
class _add_training_session extends State<add_training_session>{

  String selected_contact,selected_costcenter,selected_account_category,selected_currency,selected_trainer;
  int selected_contact_id,selected_costcenter_id,selected_account_category_id,selected_currency_id, selected_trainer_id;
  List<String> contacts=['Low','Medium','High'],cost_center=[], currency=[],account_category=[],trainer=[];
  final token;
  var list;
  _add_training_session(this.token,this.list);
  DateTime date = DateTime.now();
  bool isvisible = false;
  var session_response;
  TextEditingController hours, minutes, seconds, milli, ammount, comments,repose,fivemin,tenmin,thirtymin;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
//  bool _isvisible=false;
//  //bool notes_loaded=false;
//  bool update_notes_visibility;


  @override
  void initState() {
    this.hours=TextEditingController();
    this.minutes=TextEditingController();
    this.seconds=TextEditingController();
    this.milli=TextEditingController();
    this.ammount=TextEditingController();
    this.comments=TextEditingController();
    this.repose=TextEditingController();
    this.fivemin=TextEditingController();
    this.tenmin=TextEditingController();
    this.thirtymin=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        network_operations.training_session_dropdowns(token,list['trainingId']).then((response){
          if(response!=null){
            print(response);
            setState(() {
              session_response=json.decode(response);
              if(session_response['trainerDropDown']!=null&&session_response['trainerDropDown'].length>0){
                for(int i=0;i<session_response['trainerDropDown'].length;i++)
                  trainer.add(session_response['trainerDropDown'][i]['name']);
                for(int i=0;i<session_response['currencyDropDown'].length;i++)
                  currency.add(session_response['currencyDropDown'][i]['name']);
                for(int i=0;i<session_response['categoryDropDown'].length;i++)
                  account_category.add(session_response['categoryDropDown'][i]['name']);
                for(int i=0;i<session_response['costCenterDropDown'].length;i++)
                  cost_center.add(session_response['costCenterDropDown'][i]['name']);
              }
              //notes_loaded=true;
              //update_notes_visibility=true;
            });
          }
        });
        network_operations.session_training_type(token,list['trainingId']).then((response){
          if(response!=null){
            print(response);
            setState(() {
              session_response=json.decode(response);
              print(session_response);
              if(session_response=="Speed" || session_response=="Endurance"|| session_response=="Customise"){
                isvisible=true;
                }
              //notes_loaded=true;
              //update_notes_visibility=true;
            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Training Session"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      //visible: sale_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Trainer",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Trainer"),
                        items:trainer!=null?trainer.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
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
                            this.selected_trainer_id=trainer.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:30,right: 250),
                      child: Text("Length/Duration", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: hours,
                      attribute: "Hours",
                      decoration: InputDecoration(labelText: "Hours",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: minutes,
                      attribute: "Minutes",
                      decoration: InputDecoration(labelText: "Minutes",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: seconds,
                      attribute: "Seconds",
                      decoration: InputDecoration(labelText: "Seconds",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: milli,
                      attribute: "Milli",
                      decoration: InputDecoration(labelText: "Milli",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                    child: Visibility(
                       visible: isvisible,
                      child: FormBuilderDropdown(
                        attribute: "Contact",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Contact"),
                        items:contacts!=null?contacts.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Level of Activity",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_contact=value;
                            this.selected_contact_id=contacts.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      visible: isvisible,
                      child: FormBuilderTextField(
                        keyboardType: TextInputType.number,
                        controller: repose,
                        attribute: "repose",
                        decoration: InputDecoration(labelText: "Repose",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      visible: isvisible,
                      child: FormBuilderTextField(
                        keyboardType: TextInputType.number,
                        controller: fivemin,
                        attribute: "Milli",
                        decoration: InputDecoration(labelText: "Min 5",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      visible: isvisible,
                      child: FormBuilderTextField(
                        keyboardType: TextInputType.number,
                        controller: tenmin,
                        attribute: "Milli",
                        decoration: InputDecoration(labelText: "Min 10",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(visible: isvisible,
                      child: FormBuilderTextField(
                        keyboardType: TextInputType.number,
                        controller: thirtymin,
                        attribute: "Milli",
                        decoration: InputDecoration(labelText: "Min 30",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                    child: FormBuilderTextField(
                      controller: ammount,
                      attribute: "Amount",
                      keyboardType: TextInputType.number,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                    child: Visibility(
                      // visible: currency_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Currency",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Currency"),
                        items:currency!=null?currency.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Currency",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_currency=value;
                            this.selected_currency_id=currency.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                    child: Visibility(
                      // visible: account_category_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Account Category",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Account Category"),
                        items:account_category!=null?account_category.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Account Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_account_category=value;
                            this.selected_account_category_id=account_category.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
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

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: comments,
                      attribute: "Comments",
                      decoration: InputDecoration(labelText: "Comments",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),


                  MaterialButton(
                    onPressed: (){
                      print(token);
                      print(list['createdBy']);
                      print(list['trainingId']);
                      print(selected_trainer_id);
                      print(comments);
                      if (_fbKey.currentState.validate()) {
                        Utils.check_connectivity().then((result){
                          if(result){
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();

                            network_operations.addTrainingSession(token, list['createdBy'], 0,list['trainingId'], date, selected_trainer_id, int.parse(hours.text), int.parse(minutes.text), int.parse(seconds.text), int.parse(milli.text),selected_contact_id,int.parse(repose.text),int.parse(fivemin.text),int.parse(tenmin.text),int.parse(thirtymin.text),int.parse(ammount.text), selected_currency_id, selected_account_category_id, comments.text).then((respons) {
                              pd.dismiss();
                              setState(() {
                                var parsedjson  = jsonDecode(respons);
                                print("ok");
                                if(parsedjson != null){
                                  if(parsedjson['isSuccess'] == true){
                                    print("Successfully data updated");
                                  }else
                                    print("not saved");
                                }else
                                  print("json response null");
                              });
                            });
                          }
                        });
                      }
                    },
                    child: Text("Save",style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.teal,
                  ),
                ],
                ),
              ),

            ],
          ),
        ),

      ),
    );

  }
}