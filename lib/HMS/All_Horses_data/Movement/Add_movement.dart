import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/HMS/All_Horses_data/services/movement_services.dart';


class add_movement extends StatefulWidget{
  String token;

  add_movement (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(token);
  }

}
class _state_add_farrier extends State<add_movement>{
  int selected_horse_id,selected_reason_id,selected_transport_id,select_fromlocation_id,select_tolocation_id,selected_category_id,selected_costcenter_id,selected_currency_id,selected_contact_id;
  String selected_horse,selected_reason,selected_transport,select_fromlocation,select_tolocation,selected_category,selected_costcenter,selected_currency,selected_contact,selected_account;
  List<String> horse=[];
  bool isroundtrip;
  List<String> transporttype=["Truck","Trailer","ByFoot","Plan","Ship","Train"];List<String> roundtrip=["Yes","No"];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> fromlocation=[];List<String> tolocation=[];
  List<String> reason=["Breeding","Competetion","Loan","purchase","Relocation","Rental","Riding","Sale","Surgery","Tame","Training","Treatmant","Others"];
  DateTime departure_date = DateTime.now();
  DateTime return_date = DateTime.now();
  TextEditingController amount,responsible,description;
  String token;
  var movementDropdown,labDropdown;

  _state_add_farrier (this.token);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    amount= TextEditingController();
    description= TextEditingController();
    responsible= TextEditingController();

    movement_services.movement_Dropdown(token).then((response){
      setState(() {
        print(token);
        movementDropdown=json.decode(response);

        print(movementDropdown['horseDropDown']);
        print("abc");
        for(int i=0;i<movementDropdown['horseDropDown'].length;i++)
          horse.add(movementDropdown['horseDropDown'][i]['name']);
        for(int i=0;i<movementDropdown['fromLocation'].length;i++)
          fromlocation.add(movementDropdown['fromLocation'][i]['name']);
        for(int i=0;i<movementDropdown['toLocation'].length;i++)
          tolocation.add(movementDropdown['toLocation'][i]['name']);
        for(int i=0;i<movementDropdown['currency'].length;i++)
          currency.add(movementDropdown['currency'][i]['name']);
        for(int i=0;i<movementDropdown['category'].length;i++)
          category.add(movementDropdown['category'][i]['name']);
        for(int i=0;i<movementDropdown['costCenter'].length;i++)
          costcenter.add(movementDropdown['costCenter'][i]['name']);

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
        appBar: AppBar(title: Text("Add Movement"),),
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
                          attribute: "ddate",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Depature Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.departure_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "rdate",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Return Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.return_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "transporttype",
                          hint: Text("transportType"),
                          items: transporttype!=null?transporttype.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Transport Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_transport=value;
                              selected_transport_id = transporttype.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_transport=value;
                              selected_transport_id = transporttype.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "reason",
                          hint: Text("reason"),
                          items: reason!=null?reason.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Reason",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_reason=value;
                              selected_reason_id = reason.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_reason=value;
                              selected_reason_id = reason.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "reason",
                          hint: Text(" RoundTrip"),
                          items: roundtrip!=null?roundtrip.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Is RoundTrip",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                             if(value == "Yes")
                               isroundtrip = true;
                             else
                               isroundtrip = false;

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
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "fromlocation",
                          hint: Text("From Location"),
                          items: fromlocation!=null?fromlocation.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "From Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.select_fromlocation=value;
                              select_fromlocation_id = fromlocation.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.select_fromlocation=value;
                              select_fromlocation_id = fromlocation.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "to location",
                          hint: Text("Tolocation"),
                          items: tolocation!=null?tolocation.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "To Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.select_tolocation=value;
                              select_tolocation_id = tolocation.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.select_tolocation=value;
                              select_tolocation_id = tolocation.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: responsible,
                          attribute: "res",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Responsible",
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
                          controller: description,
                          attribute: "des",
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
                          attribute: "amount",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Amount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                           keyboardType: TextInputType.number,
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
                            print(token);print(amount.text);print(description.text);print(movementDropdown['currency'][selected_currency_id]['id']);
                            print(movementDropdown['category'][selected_category_id]['id']);print(movementDropdown['costCenter'][selected_costcenter_id]['id']);print( movementDropdown['toLocation'][select_tolocation_id]['id']);
                            print(movementDropdown['horseDropDown'][selected_horse_id]['id']);

                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            movement_services.movementSave(null, token, 0, movementDropdown['horseDropDown'][selected_horse_id]['id'], departure_date, return_date, isroundtrip, selected_transport_id, selected_reason_id,movementDropdown['fromLocation'][select_fromlocation_id]['id'], movementDropdown['toLocation'][select_tolocation_id]['id'], amount.text, responsible.text, description.text, movementDropdown['category'][selected_category_id]['id'] ,  movementDropdown['currency'][selected_currency_id]['id'],  movementDropdown['costCenter'][selected_costcenter_id]['id']).then((response){

                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "Added Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);}
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