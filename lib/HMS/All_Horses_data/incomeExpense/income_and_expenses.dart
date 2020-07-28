import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';


class add_IncomeExpense extends StatefulWidget{
  String token;

  add_IncomeExpense (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(token);
  }

}
class _state_add_farrier extends State<add_IncomeExpense>{
  int selected_horse_id,selected_category_id,selected_costcenter_id,selected_currency_id,selected_contact_id;
  String selected_horse,selected_category,selected_costcenter,selected_currency,selected_contact,selected_account;
  List<String> horse=[], account=["General","Bussiness"], responsible=[], currency=[],category=[],costcenter=[];
  List<String> contact=[];
  DateTime Select_date = DateTime.now();
  TextEditingController amount,description;
  String token;
  var incomeExpenseDropdown,labDropdown;

  _state_add_farrier (this.token);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    amount= TextEditingController();
    description= TextEditingController();

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        income_expense_services.incomedropdown(token).then((response){
          pd.dismiss();
          print(response);
          setState(() {
            incomeExpenseDropdown=json.decode(response);
            for(int i=0;i<incomeExpenseDropdown['horseDropdown'].length;i++)
              horse.add(incomeExpenseDropdown['horseDropdown'][i]['name']);
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

      }else
        Flushbar(message: "Network Error",backgroundColor: Colors.red,duration: Duration(seconds: 3),).show(context);
    });




//    labtest_services.labdropdown(token).then((response){
//      setState(() {
//        print(response);
//        labDropdown=json.decode(response);
//        for(int i=0;i<labDropdown['horseDropDown'].length;i++)
//          horse.add(labDropdown['horseDropDown'][i]['name']);
//        for(int i=0;i<labDropdown['responsibleDropDown'].length;i++)
//          responsible.add(labDropdown['responsibleDropDown'][i]['name']);
//        for(int i=0;i<labDropdown['currencyDropDown'].length;i++)
//          currency.add(labDropdown['currencyDropDown'][i]['name']);
//        for(int i=0;i<labDropdown['categoryDropDown'].length;i++)
//          category.add(labDropdown['categoryDropDown'][i]['name']);
//        for(int i=0;i<labDropdown['costCenterDropDown'].length;i++)
//          costcenter.add(labDropdown['costCenterDropDown'][i]['name']);
//        for(int i=0;i<labDropdown['contactsDropDown'].length;i++)
//          contact.add(labDropdown['contactsDropDown'][i]['name']);
//
//      });
//    });



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
        appBar: AppBar(title: Text("Add Income & Expenses"),),
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
                          keyboardType: TextInputType.number,
                          controller: amount,
                          attribute: "Ammount",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Ammount",
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
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Account",
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
                            pd.show();
                            income_expense_services.income_expenseSave(null,token, 0,incomeExpenseDropdown['horseDropDown'][selected_horse_id]['id'], Select_date,
                                 amount.text,description.text, incomeExpenseDropdown['currencyDropDown'][selected_currency_id]['id'], incomeExpenseDropdown['categoryDropDown'][selected_category_id]['id'],
                                incomeExpenseDropdown['costCenterDropDown'][selected_costcenter_id]['id'], incomeExpenseDropdown['contactsDropDown'][selected_contact_id]['id'],selected_account,).then((response){
                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "Added Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);
                                  sleep(Duration(seconds: 3));
                                  Navigator.pop(context);
                                }

                                else{
                                  Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
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