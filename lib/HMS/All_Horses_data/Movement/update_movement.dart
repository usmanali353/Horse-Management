import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/HMS/All_Horses_data/services/movement_services.dart';


class update_movement extends StatefulWidget{
  String token;
  var movementlist;

  update_movement (this.movementlist,this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(movementlist,token);
  }

}
class _state_add_farrier extends State<update_movement>{
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
  String transportinitial,reasoninitial;
  var movementDropdown,movementlist;

  _state_add_farrier (this.movementlist,this.token);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    amount= TextEditingController();
    description= TextEditingController();
    responsible= TextEditingController();
    setState(() {
      amount.text = movementlist['amount'].toString();
      description.text = movementlist['comments'].toString();
      responsible.text = movementlist['responsible'].toString();
    });

    movement_services.movement_Dropdown(token).then((response){
      setState(() {
        movementDropdown=json.decode(response);
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

    if(movementlist != null) {
      if (movementlist['transportType'] == 1) {
        setState(() {
          transportinitial = 'Truck';
        });
      }
      else if (movementlist['transportType'] == 2) {
        setState(() {
          transportinitial = 'Trailer';
        });
      }
      else if (movementlist['transportType'] == 3) {
        setState(() {
          transportinitial = 'ByFoot';
        });
      }
      else if (movementlist['transportType'] == 4) {
        setState(() {
          transportinitial = 'Plan';
        });
      }
      else if (movementlist['transportType'] == 5) {
        setState(() {
          transportinitial = 'Ship';
        });
      }
      else if (movementlist['transportType'] ==6) {
        setState(() {
          transportinitial = 'Train';
        });
      }
    }else{
      print("genderlist null a");
    }




    if(movementlist != null) {
      if (movementlist['reason'] == 1) {
        setState(() {
          reasoninitial = 'Breeding';
        });
      }
      else if (movementlist['reason'] == 2) {
        setState(() {
          reasoninitial = 'Competetion';
        });
      }
      else if (movementlist['reason'] == 3) {
        setState(() {
          reasoninitial = 'Loan';
        });
      }
      else if (movementlist['reason'] == 4) {
        setState(() {
          reasoninitial = 'purchase';
        });
      }
      else if (movementlist['reason'] == 5) {
        setState(() {
          reasoninitial = 'Relocation';
        });
      }
      else if (movementlist['reason'] ==6) {
        setState(() {
          reasoninitial = 'Rental';
        });
      }
    else if (movementlist['reason'] == 7) {
    setState(() {
      reasoninitial = 'Riding';
    });
    }
    else if (movementlist['reason'] == 8) {
    setState(() {
      reasoninitial = 'Sale';
    });
    }
    else if (movementlist['reason'] == 9) {
    setState(() {
      reasoninitial = 'Surgery';
    });
    }
    else if (movementlist['reason'] == 10) {
    setState(() {
      reasoninitial = 'Tame';
    });
    }
    else if (movementlist['reason'] == 11) {
    setState(() {
      reasoninitial = 'Training';
    });
    }
    else if (movementlist['reason'] ==12) {
    setState(() {
      reasoninitial = 'Treatmant';
    });
    }
    else if (movementlist['reason'] ==13) {
    setState(() {
      reasoninitial = 'Others';
    });
    }
    }else{
      print("genderlist null a");
    }
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
        appBar: AppBar(title: Text("Update Movement"),),
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
                          initialValue: movementlist['horseName']['name'],
                          hint: Text("- Select -"),
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
                          attribute: "ddate",
                          initialValue: DateTime.parse(movementlist['departureDate'] != null ? movementlist['departureDate']:DateTime.now()),
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
                          onSaved: (value){
                            this.departure_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "rdate",
                          initialValue: DateTime.parse(movementlist['returnDate']!= null? movementlist['returnDate']:DateTime.now()),
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
                          initialValue: transportinitial,
                          hint: Text("- Select -"),
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
                              selected_transport_id = transporttype.indexOf(value)+1;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_transport=value;
                              selected_transport_id = transporttype.indexOf(value)+1;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "reason",
                          initialValue: reasoninitial!= null? reasoninitial:null,
                          hint: Text("- Select -"),
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
                              selected_reason_id = reason.indexOf(value)+1;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_reason=value;
                              selected_reason_id = reason.indexOf(value)+1;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "reason",
                          initialValue: "No",
                          hint: Text("- Select -"),
                          items: roundtrip!=null?roundtrip.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Is Round Trip",
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
                              if(value == "Yes")
                                isroundtrip = true;
                              else
                                isroundtrip = false;

                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "fromlocation",
                          initialValue: movementlist['fromLocationName']['name'],
                          hint: Text("- Select -"),
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
                          initialValue: movementlist['toLocationName']['name'],
                          hint: Text("- Select -"),
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
                          initialValue: get_currency_by_id(movementlist['currencyId']),
                          hint: Text("- Select -"),
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
                          initialValue: get_category_by_id(movementlist['categoryId']),
                          hint: Text("- Select -"),
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
                          initialValue: get_costcenter_by_id(movementlist['costCenterId']),
                          attribute: "cost Center",
                          hint: Text("- Select -"),
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
                          print(movementlist['fromLocation']) ;
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                            _fbKey.currentState.save();
//                            print(token);print(amount.text);print(description.text);print(movementDropdown['currency'][selected_currency_id]['id']);
//                            print(movementDropdown['category'][selected_category_id]['id']);print(movementDropdown['costCenter'][selected_costcenter_id]['id']);print( movementDropdown['toLocation'][select_tolocation_id]['id']);
//                            print(movementDropdown['horseDropDown'][selected_horse_id]['id']);

                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            movement_services.movementSave(movementlist['createdBy'], token, movementlist['movementId'], movementDropdown['horseDropDown'][selected_horse_id]['id'], departure_date, return_date, isroundtrip, selected_transport_id, selected_reason_id,movementDropdown['fromLocation'][select_fromlocation_id]['id'], movementDropdown['toLocation'][select_tolocation_id]['id'], amount.text, responsible.text, description.text, movementDropdown['category'][selected_category_id]['id'] ,  movementDropdown['currency'][selected_currency_id]['id'],  movementDropdown['costCenter'][selected_costcenter_id]['id']).then((response){

                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "Update Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);
                                  Navigator.pop(context);
                                }
                                else{
                                  Flushbar(message: "Not Update",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not Update",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                            });
                          }
                        },
                        child:Text("Update",style: TextStyle(color: Colors.white),),
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
    if(movementlist!=null&&movementDropdown['currency']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(movementDropdown['currency'][i]['id']==id){
          plan_name=movementDropdown['currency'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(movementlist!=null&&movementDropdown['category']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(movementDropdown['category'][i]['id']==id){
          plan_name=movementDropdown['category'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(movementlist!=null&&movementDropdown['costCenter']!=null&&id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(movementDropdown['costCenter'][i]['id']==id){
          plan_name=movementDropdown['costCenter'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  
}