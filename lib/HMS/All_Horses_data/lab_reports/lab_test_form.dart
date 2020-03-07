import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class add_labTest extends StatefulWidget{
  String token;

  add_labTest (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(this.token);
  }

}
class _add_horse_state extends State<add_labTest>{
  String token;

  _add_horse_state (this.token);
  int selected_horse_id,selected_testtype_id,selected_positive_id,selected_responsible_id,selected_currency_id,selected_category_id,selected_costcenter_id,selected_contact_id;
  String selected_horse,selected_testtype,selected_positive,selected_responsible,selected_currency,selected_category,selected_costcenter,selected_contact;
  DateTime Select_date = DateTime.now();
  TextEditingController lab,result,amount;
  List<String> horse=[];List<String> testtype=[];List<String> positive=["Yes","No"];List<String> responsible=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  var labDropdown;

  sqlite_helper local_db;
  bool isPositive;
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
                        ),
                      ),
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
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
                            this.Select_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Test Type",
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "POsitive",
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Responsible",
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
                            print(_fbKey.currentState.value);

                            print(token);
                            print(labDropdown['horseDropDown'][selected_horse_id]['id']);
                            print(Select_date);print(labDropdown['testTypesdropDown'][selected_testtype_id]['id']);
                            print(isPositive);print(labDropdown['responsibleDropDown'][selected_responsible_id]['id']);print( lab.text);
                            print(result.text);print(amount.text);print(labDropdown['currencyDropDown'][selected_currency_id]['id']);print(labDropdown['categoryDropDown'][selected_category_id]['id']);
                            print(labDropdown['costCenterDropDown'][selected_costcenter_id]['id']);
                            print(labDropdown['contactsDropDown'][selected_contact_id]['id']);
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            //pd.show();
                            labtest_services.labTestSave(null,0,token, labDropdown['horseDropDown'][selected_horse_id]['id'], Select_date, labDropdown['testTypesdropDown'][selected_testtype_id]['id'], isPositive, labDropdown['responsibleDropDown'][selected_responsible_id]['id'], lab.text, result.text, amount.text, labDropdown['currencyDropDown'][selected_currency_id]['id'], labDropdown['categoryDropDown'][selected_category_id]['id'], labDropdown['costCenterDropDown'][selected_costcenter_id]['id'], labDropdown['contactsDropDown'][selected_contact_id]['id']).then((response){
                            //pd.dismiss();
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

}