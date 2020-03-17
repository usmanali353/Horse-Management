import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';


class update_IncomeExpense extends StatefulWidget{
  String token,createdBy;
  var expenselist;
  update_IncomeExpense (this.expenselist,this.token,this.createdBy);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(expenselist,token,createdBy);
  }

}
class _state_add_farrier extends State<update_IncomeExpense>{
  int selected_horse_id,selected_category_id,selected_costcenter_id,selected_currency_id,selected_contact_id;
  String selected_horse,selected_category,selected_costcenter,selected_currency,selected_contact,selected_account;
  List<String> horse=[];List<String> account=["General","Bussiness"];List<String> responsible=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  DateTime Select_date = DateTime.now();
  TextEditingController amount,description;
  String token,createdBy;
  var incomeExpenseDropdown,labDropdown;
   var expenselist;
  _state_add_farrier (this.expenselist,this.token,this.createdBy);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    amount= TextEditingController();
    description= TextEditingController();
   setState(() {
     amount.text = expenselist['amount'] != null ? expenselist['amount'].toString():null;
     description.text = expenselist['description'] != null ? expenselist['description']:null;
   });
    labtest_services.labdropdown(token).then((response){
      setState(() {
        incomeExpenseDropdown=json.decode(response);
        for(int i=0;i<incomeExpenseDropdown['horseDropDown'].length;i++)
          horse.add(incomeExpenseDropdown['horseDropDown'][i]['name']);
        for(int i=0;i<incomeExpenseDropdown['responsibleDropDown'].length;i++)
          responsible.add(incomeExpenseDropdown['responsibleDropDown'][i]['name']);
        for(int i=0;i<incomeExpenseDropdown['currencyDropDown'].length;i++)
          currency.add(incomeExpenseDropdown['currencyDropDown'][i]['name']);
        for(int i=0;i<incomeExpenseDropdown['categoryDropDown'].length;i++)
          category.add(incomeExpenseDropdown['categoryDropDown'][i]['name']);
        for(int i=0;i<incomeExpenseDropdown['costCenterDropDown'].length;i++)
          costcenter.add(incomeExpenseDropdown['costCenterDropDown'][i]['name']);
        for(int i=0;i<incomeExpenseDropdown['contactsDropDown'].length;i++)
          contact.add(incomeExpenseDropdown['contactsDropDown'][i]['name']);
      });
    });




//    income_expense_services.income_expensedropdown(token).then((response){
//      setState(() {
//        print(response);
//        incomeExpenseDropdown=json.decode(response);
//        for(int i=0;i<incomeExpenseDropdown['horseDropDown'].length;i++)
//          horse.add(incomeExpenseDropdown['horseDropDown'][i]['name']);
//        for(int i=0;i<incomeExpenseDropdown['responsibleDropDown'].length;i++)
//          responsible.add(incomeExpenseDropdown['responsibleDropDown'][i]['name']);
//        for(int i=0;i<incomeExpenseDropdown['currencyDropDown'].length;i++)
//          currency.add(incomeExpenseDropdown['currencyDropDown'][i]['name']);
//        for(int i=0;i<incomeExpenseDropdown['categoryDropDown'].length;i++)
//          category.add(incomeExpenseDropdown['categoryDropDown'][i]['name']);
//        for(int i=0;i<incomeExpenseDropdown['costCenterDropDown'].length;i++)
//          costcenter.add(incomeExpenseDropdown['costCenterDropDown'][i]['name']);
//        for(int i=0;i<incomeExpenseDropdown['contactsDropDown'].length;i++)
//          contact.add(incomeExpenseDropdown['contactsDropDown'][i]['name']);
//
//
//      });
//    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Income & Expense"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          initialValue: expenselist['horseName']['name'] != null ? expenselist['horseName']['name']:"",
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
                          initialValue: DateTime.parse(expenselist['date'] != null ? expenselist['date']:DateTime.now()),
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
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: description,
                          attribute: "Currency",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),




                      Padding(
                        padding: EdgeInsets.only(bottom: 16,right: 16,left: 16),
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
                          initialValue: get_currency_by_id(expenselist['currency'])!= null ? get_currency_by_id(expenselist['currency']):null,
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
                          onSaved: (value){
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
                          initialValue: expenselist['categoryId']!= null ? expenselist['categoryName']['name']:null,
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
                            });
                            },
                          onSaved: (value){
                            setState(() {
                              this.selected_category=value;
                              selected_category_id = category.indexOf(value);
                            });
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "cost Center",
                          initialValue: get_costcenter_by_id(expenselist['costCenterId'])!= null ?get_costcenter_by_id(expenselist['costCenterId']):null,
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
                            });
                            },
                          onSaved: (value){
                            setState(() {
                              this.selected_costcenter=value;
                              selected_costcenter_id = costcenter.indexOf(value);
                            });
                            },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 16),
                        child: FormBuilderDropdown(
                          attribute: "Contact",
                          initialValue: get_contact_by_id(expenselist['contactId'])!= null ?get_contact_by_id(expenselist['contactId']):null,
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
                              print(selected_contact);
                              selected_contact_id = contact.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState((){

                              this.selected_contact=value;
                              print(selected_contact);
                              selected_contact_id = contact.indexOf(value);
                            });
                          },
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Account",
                          initialValue: expenselist['typeGeneralOrBusiness']!= null ? expenselist['typeGeneralOrBusiness']:null,
                          hint: Text(" Account"),
                          items: account!=null?account.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Acount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              if(value == "General") {
                                print(value);
                                this.selected_account = "General";
                              }else{
                                print(value);
                                selected_account = 'Bussiness';}
                            });
                          },
                          onSaved: (value){
                            setState((){
                              if(value == "General") {
                                print(value);
                                this.selected_account = "General";
                              }else{
                                print(value);
                                selected_account = 'Bussiness';}
                            });
                          },
                        ),
                      ),



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
                            print(token);print(Select_date);print(amount.text);print(description.text);print(incomeExpenseDropdown['currencyDropDown'][selected_currency_id]['id']);
                            print(incomeExpenseDropdown['categoryDropDown'][selected_category_id]['id']);print(incomeExpenseDropdown['costCenterDropDown'][selected_costcenter_id]['id']);print(incomeExpenseDropdown['contactsDropDown'][selected_contact_id]['id']);
                            print(incomeExpenseDropdown['horseDropDown'][selected_horse_id]['id']);
                            print(selected_account);
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            //pd.show();
                            income_expense_services.income_expenseSave(createdBy,token,expenselist['id'],incomeExpenseDropdown['horseDropDown'][selected_horse_id]['id'], Select_date,
                              amount.text,description.text, incomeExpenseDropdown['currencyDropDown'][selected_currency_id]['id'], incomeExpenseDropdown['categoryDropDown'][selected_category_id]['id'],
                              incomeExpenseDropdown['costCenterDropDown'][selected_costcenter_id]['id'], incomeExpenseDropdown['contactsDropDown'][selected_contact_id]['id'],selected_account,).then((response){
                              //pd.dismiss();
                              if(response !=null)
                                print("Successfully income  added");
                              else{
                                print("data not added");}
                            });



                          }
                        },
                        child:Text("Add Data",style: TextStyle(color: Colors.white),),
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
    if(expenselist!=null&&incomeExpenseDropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(incomeExpenseDropdown['currencyDropDown'][i]['id']==id){
          plan_name=incomeExpenseDropdown['currencyDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(expenselist!=null&&incomeExpenseDropdown['costCenterDropDown']!=null&&id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(incomeExpenseDropdown['costCenterDropDown'][i]['id']==id){
          plan_name=incomeExpenseDropdown['costCenterDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var plan_name;
    if(expenselist!=null&&incomeExpenseDropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(incomeExpenseDropdown['contactsDropDown'][i]['id']==id){
          plan_name=incomeExpenseDropdown['contactsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
}