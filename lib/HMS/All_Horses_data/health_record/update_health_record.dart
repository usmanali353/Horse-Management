import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/Health_Record.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/HMS/All_Horses_data/services/health_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
class update_health extends StatefulWidget{
  String token;
   var healthrecordlist;
  update_health (this.healthrecordlist,this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _health_record_form(healthrecordlist,token);
  }

}
class _health_record_form extends State<update_health>{
  int selected_horse_id,selected_health_record_type_id,selected_responsible_id,selected_cost_center_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> recordtype=["Healing", "Deworming","Odonotolgy","Treatment","Vaccination"];List<String> positive=[];List<String> responsible=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_health_record_type,selected_responsible,selected_cost_center,selected_category,selected_contact,selected_currency;
  int selected_quantity;
  String testtypeinitial;
  String token,createdBy;
  var healthdropdown,healthrecordlist;
  _health_record_form (this.healthrecordlist,this.token);

  sqlite_helper local_db;
  TextEditingController product,comment,amount;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    local_db=sqlite_helper();
    product=TextEditingController();
    comment=TextEditingController();
    amount=TextEditingController();
    setState(() {
      product.text = healthrecordlist['product'];
      amount.text = healthrecordlist['amount'].toString();
      comment.text = healthrecordlist['comment'];
    });


    healthServices.healthdropdown(token).then((response){
      setState(() {
        print(response);
        healthdropdown=json.decode(response);
        for(int i=0;i<healthdropdown['horseDropDown'].length;i++)
          horse.add(healthdropdown['horseDropDown'][i]['name']);
        for(int i=0;i<healthdropdown['responsibleDropDown'].length;i++)
          responsible.add(healthdropdown['responsibleDropDown'][i]['name']);
        for(int i=0;i<healthdropdown['currencyDropDown'].length;i++)
          currency.add(healthdropdown['currencyDropDown'][i]['name']);
        for(int i=0;i<healthdropdown['categoryDropDown'].length;i++)
          category.add(healthdropdown['categoryDropDown'][i]['name']);
        for(int i=0;i<healthdropdown['costCenterDropDown'].length;i++)
          costcenter.add(healthdropdown['costCenterDropDown'][i]['name']);
        for(int i=0;i<healthdropdown['contactsDropDown'].length;i++)
          contact.add(healthdropdown['contactsDropDown'][i]['name']);
        print(contact);

      });
    });


    if(healthrecordlist != null) {
      if (healthrecordlist['recordType'] == "0") {
        setState(() {
          testtypeinitial = 'Healing';
        });
      }
      else if (healthrecordlist['recordType'] == "1") {
        setState(() {
          testtypeinitial = 'Deworming';
        });
      }
      else if (healthrecordlist['recordType'] == "2") {
        setState(() {
          testtypeinitial = 'Odonotolgy';
        });
      }
    else if (healthrecordlist['recordType'] == "3") {
      setState(() {
        testtypeinitial = 'Treatment';
      });
    }
    else if (healthrecordlist['recordType'] == "4") {
      setState(() {
        testtypeinitial = 'Vaccination';
      });
    }
    }else{
      print("genderlist null a");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Health Record"),),
        body: ListView(
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
                            attribute: "Horse",
                            initialValue: healthrecordlist['horseName']['name'],
                            validators: [FormBuilderValidators.required()],
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
                              setState((){
                                this.selected_horse=value;
                                selected_horse_id = horse.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState((){
                                this.selected_horse=value;
                                selected_horse_id = horse.indexOf(value);
                              });

                            },
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Record type",
                            initialValue: healthrecordlist['recordType'] != null ? testtypeinitial:null,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Record Type"),
                            items:recordtype.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Record Type",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState((){
                                this.selected_health_record_type=value;
                                selected_health_record_type_id = 1;
                              });
                            },
                            onSaved: (value){
                              setState((){
                                this.selected_health_record_type=value;
                                selected_health_record_type_id = 1;
                              });
                            },
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Responsible",
                            initialValue: healthrecordlist['responsibleId'] != null ? healthrecordlist['responsibleName']['contactName']['name']:null,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Responsible"),
                            items: responsible!=null?responsible.map((types)=>DropdownMenuItem(
                              child: Text(types),
                              value: types,
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
                              setState((){
                                this.selected_responsible=value;
                                selected_responsible_id = responsible.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState((){
                                this.selected_responsible=value;
                                selected_responsible_id = responsible.indexOf(value);
                              });
                            },
                          ),

                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderTextField(
                            attribute: "Product",
                            controller: product,
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Product",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                          child: FormBuilderTouchSpin(
                            attribute: "Quantity",
                            initialValue: healthrecordlist['quantity'] != null ? healthrecordlist['quantity']:1,
                            step: 1,
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Quantity",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_quantity=value;
                            },

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderTextField(
                            attribute: "Comment",
                            controller: comment,
                            decoration: InputDecoration(labelText: "Comment",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderTextField(
                            attribute: "amount",
                            controller: amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: "Amount",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Currency",
                            initialValue: get_currency_by_id(healthrecordlist['currency'])!= null ?get_currency_by_id(healthrecordlist['currency']):null,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Currency"),
                            items: currency!=null?currency.map((types)=>DropdownMenuItem(
                              child: Text(types),
                              value: types,
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
                              setState((){
                                this.selected_currency=value;
                                selected_currency_id = currency.indexOf(value);
                              }); 
                              },
                            onSaved: (value){
                              setState((){
                                this.selected_currency=value;
                                selected_currency_id = currency.indexOf(value);
                              });
                              },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Category",
                            initialValue: get_category_by_id(healthrecordlist['categoryId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Category"),
                            items:category!=null?category.map((types)=>DropdownMenuItem(
                              child: Text(types),
                              value: types,
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
                              setState((){
                                this.selected_category=value;
                                selected_category_id = category.indexOf(value);
                              });                        },
                            onSaved: (value){
                              setState((){
                                this.selected_category=value;
                                selected_category_id = category.indexOf(value);
                              });
                              },
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Cost Center",
                            initialValue: get_costcenter_by_id(healthrecordlist['costCenterId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Cost Center"),
                            items: costcenter!=null?costcenter.map((types)=>DropdownMenuItem(
                              child: Text(types),
                              value: types,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Cost Center",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState((){
                                this.selected_cost_center=value;
                                selected_cost_center_id = costcenter.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState((){
                                this.selected_cost_center=value;
                                selected_cost_center_id = costcenter.indexOf(value);
                              });
                            },
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                          child: FormBuilderDropdown(
                            attribute: "Contact",
                            //initialValue: get_contact_by_id(healthrecordlist['']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Contact"),
                            items: contact!=null?contact.map((types)=>DropdownMenuItem(
                              child: Text(types),
                              value: types,
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
                              setState((){
                                this.selected_contact=value;
                                selected_contact_id = contact.indexOf(value);
                              });
                            },
                          ),

                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MaterialButton(
                        onPressed: (){
                          if(_fbKey.currentState.validate()) {
                            _fbKey.currentState.save();
//                      local_db.create_health_record(new Health_Record(selected_amount,selected_quantity,selected_horse,selected_health_record_type,selected_responsible,product.text,comment.text,selected_currency,selected_category,selected_cost_center,selected_contact)).then((value){
////                        if(value>0){
////                              print("health record inserted Sucessfully");
////                        }else{
////                              print("health record insertion Failed");
////                        }
////                      });
                            print(token);
                            print(
                                healthdropdown['horseDropDown'][selected_horse_id]['id']);
                            print(selected_health_record_type_id);
                            print(
                                healthdropdown['responsibleDropDown'][selected_responsible_id]['id']);
                            print(selected_quantity);
                            print(
                                healthdropdown['costCenterDropDown'][selected_cost_center_id]['id']);
                            print(selected_contact_id);
                            print(amount.text);
                            print(healthdropdown['contactsDropDown'][0]['id']);
                            ProgressDialog pd = ProgressDialog(
                                context, isDismissible: true,
                                type: ProgressDialogType.Normal);
                            pd.show();
                            healthServices.healthRecordSave(
                                healthrecordlist['createdBy'],
                                healthrecordlist['horseId'],
                                token,
                                healthdropdown['horseDropDown'][selected_horse_id]['id'],
                                healthdropdown['responsibleDropDown'][selected_responsible_id]['id'],
                                selected_health_record_type_id,
                                product.text,
                                selected_quantity,
                                comment.text,
                                amount.text,
                                healthdropdown['currencyDropDown'][selected_currency_id]['id'],
                                healthdropdown['categoryDropDown'][selected_category_id]['id'],
                                healthdropdown['costCenterDropDown'][selected_cost_center_id]['id'],
                                healthdropdown['contactsDropDown'][selected_contact_id]['id'])
                                .then((response) {
                              pd.dismiss();
                              if (response != null)
                                print("Successfully  added");
                              else {
                                print("data not added");
                              }
                            });
                          }
                        },
                        child: Text("Add Health Record",style: TextStyle(color: Colors.white),),
                        color: Colors.teal,
                      ),
                    ),
                  )
                ],
              )

            ]

        )
    );
  }
  String get_currency_by_id(int id){
    var plan_name;
    if(healthrecordlist!=null&&healthdropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(healthdropdown['currencyDropDown'][i]['id']==id){
          plan_name=healthdropdown['currencyDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(healthrecordlist!=null&&healthdropdown['categoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(healthdropdown['categoryDropDown'][i]['id']==id){
          plan_name=healthdropdown['categoryDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(healthrecordlist!=null&&healthdropdown['costCenterDropDown']!=null&&id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(healthdropdown['costCenterDropDown'][i]['id']==id){
          plan_name=healthdropdown['costCenterDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var plan_name;
    if(healthrecordlist!=null&&healthdropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(healthdropdown['contactsDropDown'][i]['id']==id){
          plan_name=healthdropdown['contactsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }

}
