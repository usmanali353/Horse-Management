import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class update_testtype extends StatefulWidget{
  String token;
  var specifictype;

  update_testtype(this.token,this.specifictype);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_testtype(token,specifictype);
  }
}



class _update_testtype extends State<update_testtype>{
  String token;
  var specifictype;
  _update_testtype(this.token, this.specifictype);
  String selected_reminder;
  bool selected_reminder_id;

  // sqlite_helper local_db;
  List<String>  reminder=['Yes','No'] ;

  // var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,validity,showReminders;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.name=TextEditingController();
    this.validity=TextEditingController();
    this.showReminders=TextEditingController();
    setState(() {
      if(specifictype['name']!=null){
        name.text=specifictype['name'];
      }
      if(specifictype['validity']!=null){
        validity.text=specifictype['validity'].toString();
      }
      if(specifictype['reminderBeforeDays']!=null){
        showReminders.text=specifictype['reminderBeforeDays'].toString();
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
//    this.validity=TextEditingController();
//    this.showReminders=TextEditingController();
//     local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        AccountCategoriesServices.get_embryo_stock_dropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              stock_response=json.decode(response);
//              for(int i=0;i<stock_response['horseDropDown'].length;i++)
//                horses.add(stock_response['horseDropDown'][i]['name']);
//              for(int i=0;i<stock_response['tankDropDown'].length;i++)
//                tanks.add(stock_response['tankDropDown'][i]['name']);
//              for(int i=0;i<stock_response['sireDropDown'].length;i++)
//                sire.add(stock_response['sireDropDown'][i]['name']);
//              stocks_loaded=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Test Types"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: name,
                            attribute: "Test Type Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Test Type Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: validity,
                            keyboardType: TextInputType.number,
                            attribute: "Validity",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Validity",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Reminder",
                            initialValue: get_yesno(specifictype['reminder']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Reminder"),
                            items: reminder!=null?reminder.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Reminder",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
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
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: showReminders,
                            keyboardType: TextInputType.number,
                            attribute: "Show Reminders",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Show Reminders",
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
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Update",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                _fbKey.currentState.save();
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    TestTypesServices.addTestTypes(token, specifictype['id'], name.text, validity.text, selected_reminder_id, showReminders.text, specifictype['createdBy'],)
                                        .then((respons){
                                      pd.dismiss();
                                      if(respons!=null){
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Test Type Updated"),
                                          backgroundColor: Colors.green,
                                        ));
                                        Navigator.pop(context);
                                      }else{
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Test Type not Updated"),
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
                  )
                ],
              )
            ]
        )
    );
  }

}

