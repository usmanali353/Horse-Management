import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class update_labTest extends StatefulWidget{
  String token,createdBy;
  var labtestlist;
  update_labTest (this.labtestlist,this.token,this.createdBy);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(labtestlist,this.token,createdBy);
  }

}
class _add_horse_state extends State<update_labTest>{
  String token,createdBy;
  var labtestlist;
  _add_horse_state (this.labtestlist,this.token,this.createdBy);
  int selected_horse_id,selected_testtype_id,selected_positive_id,selected_responsible_id,selected_currency_id,selected_category_id,selected_costcenter_id,selected_contact_id;
  String selected_horse,selected_testtype,selected_positive,selected_responsible,selected_currency,selected_category,selected_costcenter,selected_contact;
  DateTime Select_date = DateTime.now();
  TextEditingController lab,result,amount;
  List<String> horse=[];List<String> testtype=[];List<String> positive=["Yes","No"];List<String> responsible=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  var labDropdown;
  Uint8List picked_image;
  sqlite_helper local_db;
  bool isPositive;
  var positiveinitial;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    lab= TextEditingController();
    result= TextEditingController();
    amount= TextEditingController();


    labtest_services.labdropdown(token).then((response){
      setState(() {
        print(response);
        labDropdown=json.decode(response);
        for(int i=0;i<labDropdown['horseDropDown'].length;i++)
          horse.add(labDropdown['horseDropDown'][i]['name']);
        for(int i=0;i<labDropdown['testTypesdropDown'].length;i++)
          testtype.add(labDropdown['testTypesdropDown'][i]['name']);
        for(int i=0;i<labDropdown['responsibleDropDown'].length;i++)
          responsible.add(labDropdown['responsibleDropDown'][i]['name']);
        for(int i=0;i<labDropdown['currencyDropDown'].length;i++)
          currency.add(labDropdown['currencyDropDown'][i]['name']);
        for(int i=0;i<labDropdown['categoryDropDown'].length;i++)
          category.add(labDropdown['categoryDropDown'][i]['name']);
        for(int i=0;i<labDropdown['costCenterDropDown'].length;i++)
          costcenter.add(labDropdown['costCenterDropDown'][i]['name']);
        for(int i=0;i<labDropdown['contactsDropDown'].length;i++)
          contact.add(labDropdown['contactsDropDown'][i]['name']);

      });
    });
    setState(() {
      lab.text = labtestlist['lab']!= null ? labtestlist['lab']:"";
      result.text = labtestlist['result'];
      amount.text = labtestlist['amount'].toString();


      if(labtestlist['isPositive']!= null ?labtestlist['isPositive'] == true:null)
        positiveinitial = "Yes";
      else {
        positiveinitial = "No";
      }
    });

  }

//  File _image;
//
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//    });
//  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Horse"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          initialValue:  labtestlist['horseName']['name'],
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
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
                              selected_horse_id = horse.indexOf(value);
                            });

                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });

                          },
                        ),
                      ),
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          initialValue: DateTime.parse(labtestlist['date'] != null ? labtestlist['date'].toString().substring(0,10):DateTime.now()),
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
                              this.Select_date=value;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.Select_date=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Test Type",
                          initialValue: labtestlist['typeTestId'] != null ? labtestlist['testTypes']['name']:null,
                          hint: Text("Test Type"),
                          items: testtype!=null?testtype.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Test Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_testtype=value;
                              this.selected_testtype_id = testtype.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_testtype=value;
                              this.selected_testtype_id = testtype.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "POsitive",
                          initialValue: positiveinitial,
                          hint: Text("Positive"),
                          items: positive.map((name) => DropdownMenuItem(
                              value: name,
                              child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Positive",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              if(value == "Yes")
                                this.isPositive=true;
                              else
                                isPositive = false;
                            });
                          },
                          onSaved: (value){
                            setState((){
                              if(value == "Yes")
                                this.isPositive=true;
                              else
                                isPositive = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Responsible",
                          initialValue: labtestlist['responsible'] != null ? labtestlist['responsibleName']['contactName']['name']:null,
                          hint: Text("Responsible"),
                          items: responsible!=null?responsible.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Responsible",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_responsible=value;
                              selected_responsible_id = responsible.indexOf(value);
                            });                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_responsible=value;
                              selected_responsible_id = responsible.indexOf(value);
                            });
                            },
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: lab,
                          attribute: "lab",
                          decoration: InputDecoration(labelText: "Lab",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: result,
                          attribute: "result",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Result",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: amount,
                          attribute: "Currency",
                          validators: [FormBuilderValidators.required()],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Currency",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Cuurency",
                         initialValue: get_currency_by_id(labtestlist['currencyId']),
                          hint: Text("Currency"),
                          items: currency!=null?currency.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
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
                              selected_currency_id = currency.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Category",
                          initialValue: get_category_by_id(labtestlist['categoryId']),
                          hint: Text("Category"),
                          items: category!=null?category.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_category=value;
                              selected_category_id = category.indexOf(value);
                            });                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "cost Center",
                          initialValue: get_costcenter_by_id(labtestlist['costCenterId']),
                          hint: Text("Cost Center"),
                          items: costcenter!=null?costcenter.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Cost Cennter",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_costcenter=value;
                              selected_costcenter_id = costcenter.indexOf(value);
                            });                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "contact",
                          initialValue: get_contact_by_id(labtestlist['contactId']),
                          hint: Text("Contact"),
                          items: contact!=null?contact.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Contact",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_contact=value;
                              selected_contact_id = contact.indexOf(value);
                            });                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                          color: Colors.teal,
                          onPressed: (){
                            Utils.getImage().then((image_file){
                              if(image_file!=null){
                                image_file.readAsBytes().then((image){
                                  if(image!=null){
                                    setState(() {
                                      this.picked_image=image;
                                    });
                                  }
                                });
                              }else{

                              }
                            });
                          },
                          child: Text("Select Image",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      //ImagePickerExample(),


                    ],
                  ),
                ),
                Center(
                    child:Padding(
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            _fbKey.currentState.save();
                            print(_fbKey.currentState.value);

                            print(token);
                            print(labDropdown['horseDropDown'][selected_horse_id]['id']);
                            print(Select_date);print(labDropdown['testTypesdropDown'][selected_testtype_id]['id']);
                            print(isPositive);print(labDropdown['responsibleDropDown'][selected_responsible_id]['id']);print( lab.text);
                            print(result.text);print(amount.text);print(labDropdown['currencyDropDown'][selected_currency_id]['id']);print(labDropdown['categoryDropDown'][selected_category_id]['id']);
                            print(labDropdown['costCenterDropDown'][selected_costcenter_id]['id']);
                            print(labDropdown['contactsDropDown'][selected_contact_id]['id']);
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            labtest_services.labTestSave(labtestlist['createdBy'],labtestlist['id'],token, labDropdown['horseDropDown'][selected_horse_id]['id'], Select_date, labDropdown['testTypesdropDown'][selected_testtype_id]['id'], isPositive, labDropdown['responsibleDropDown'][selected_responsible_id]['id'], lab.text, result.text, amount.text, labDropdown['currencyDropDown'][selected_currency_id]['id'], labDropdown['categoryDropDown'][selected_category_id]['id'], labDropdown['costCenterDropDown'][selected_costcenter_id]['id'], labDropdown['contactsDropDown'][selected_contact_id]['id'],picked_image).then((response){
                              pd.dismiss();
                              if(response !=null)
                                print("Successfully lab test added");
                              else{
                                print("data not added");}
                            });

                          }
                        },
                        child:Text("Add Horse",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }
  String get_currency_by_id(int id){
    var plan_name;
    if(labtestlist!=null&&labDropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(labDropdown['currencyDropDown'][i]['id']==id){
          plan_name=labDropdown['currencyDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(labtestlist!=null&&labDropdown['categoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(labDropdown['categoryDropDown'][i]['id']==id){
          plan_name=labDropdown['categoryDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(labtestlist!=null&&labDropdown['costCenterDropDown']!=null&&id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(labDropdown['costCenterDropDown'][i]['id']==id){
          plan_name=labDropdown['costCenterDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var plan_name;
    if(labtestlist!=null&&labDropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(labDropdown['contactsDropDown'][i]['id']==id){
          plan_name=labDropdown['contactsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
}