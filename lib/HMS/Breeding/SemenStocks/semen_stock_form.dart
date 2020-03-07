//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import  'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:intl/intl.dart';
//
//import '../../../Utils.dart';
//import 'semen_stock_json.dart';
//
//class semen_stock_form extends StatefulWidget{
//  String token;
//  semen_stock_form(this.token);
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _semen_stock_form(token);
//  }
//
//}
//class _semen_stock_form extends State<semen_stock_form>{
//  String token;
//  _semen_stock_form(this.token);
//  String ddvalue, selected_horse, selected_tank, selected_was_bought, selected_on_sale;
//  DateTime Entry_date = DateTime.now();
//  DateTime Collection_date = DateTime.now();
//  int selected_horse_id=0,selected_tank_id=0,selected_sire_id=0,selected_gender_id;
//  bool selected_on_sale_id;
//  bool  selected_was_bought_id;
//
//  List<String> horses=[],tanks=[],was_bought=['Yes','No'], on_sale=['Yes','No'];
//  var dose_response;
//  TextEditingController quantity,cannister,price,serial_number,batch_number;
//
////  bool autoValidate = true;
//////  bool readOnly = false;
//////  bool showSegmentedControl = true;
//
//  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
//  bool _isvisible=false;
//  bool dose_loaded=false;
//  @override
//  void initState() {
//    this.quantity=TextEditingController();
//    this.cannister=TextEditingController();
//    this.price=TextEditingController();
//    this.serial_number=TextEditingController();
//    this.batch_number=TextEditingController();
//    // local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        SemenStockServices.get_semen_dose_dropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              dose_response=json.decode(response);
//              for(int i=0;i<dose_response['horseDropDown'].length;i++)
//                horses.add(dose_response['horseDropDown'][i]['name']);
//              for(int i=0;i<dose_response['tankDropDown'].length;i++)
//                tanks.add(dose_response['tankDropDown'][i]['name']);
//
//              dose_loaded=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Semen Stock Form"),),
//            body: ListView(
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      FormBuilder(
//                        key: _fbKey,
//                        child: Column(
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.only(left: 16,right: 16,top:16),
//                              child: Visibility(
//                                visible: dose_loaded,
//                                child: FormBuilderDropdown(
//                                  attribute: "Horse",
//                                  validators: [FormBuilderValidators.required()],
//                                  hint: Text("Horse"),
//                                  items:horses!=null?horses.map((horse)=>DropdownMenuItem(
//                                    child: Text(horse),
//                                    value: horse,
//                                  )).toList():[""].map((name) => DropdownMenuItem(
//                                      value: name, child: Text("$name")))
//                                      .toList(),
//                                  style: Theme.of(context).textTheme.body1,
//                                  decoration: InputDecoration(labelText: "Horse",
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(9.0),
//                                        borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                    ),
//                                  ),
//                                  onChanged: (value){
//                                    setState(() {
//                                      this.selected_horse=value;
//                                      this.selected_horse_id=horses.indexOf(value);
//                                    });
//                                  },
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderDropdown(
//                                attribute: "Tanks",
//                                validators: [FormBuilderValidators.required()],
//                                hint: Text("Tanks"),
//                                items: tanks!=null?tanks.map((trainer)=>DropdownMenuItem(
//                                  child: Text(trainer),
//                                  value: trainer,
//                                )).toList():[""].map((name) => DropdownMenuItem(
//                                    value: name, child: Text("$name")))
//                                    .toList(),
//                                style: Theme.of(context).textTheme.body1,
//                                decoration: InputDecoration(labelText: "Tanks",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//                                onChanged: (value){
//                                  setState(() {
//                                    this.selected_tank=value;
//                                    this.selected_tank_id=tanks.indexOf(value);
//                                  });
//                                },
//                              ),
//                            ),
//
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child:FormBuilderDateTimePicker(
//                                attribute: "Entry Date",
//                                style: Theme.of(context).textTheme.body1,
//                                inputType: InputType.date,
//                                validators: [FormBuilderValidators.required()],
//                                format: DateFormat("MM-dd-yyyy"),
//                                decoration: InputDecoration(labelText: "Entry Date",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),),
//                                onChanged: (value){
//                                  setState(() {
//                                    this.Entry_date=value;
//                                  });
//                                },
//                              ),
//                            ),
//
//
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child:FormBuilderDateTimePicker(
//                                attribute: "Collection Date",
//                                style: Theme.of(context).textTheme.body1,
//                                inputType: InputType.date,
//                                validators: [FormBuilderValidators.required()],
//                                format: DateFormat("MM-dd-yyyy"),
//                                decoration: InputDecoration(labelText: "Collection Date",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),),
//                                onChanged: (value){
//                                  setState(() {
//                                    this.Collection_date=value;
//                                  });
//                                },
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.all(16),
//                              child: FormBuilderTextField(
//                                controller: quantity,
//                                keyboardType: TextInputType.number,
//                                attribute: "Quantity",
//                                validators: [FormBuilderValidators.required()],
//                                decoration: InputDecoration(labelText: "Quantity",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//
//                              ),
//                            ),
//
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderTextField(
//                                controller: cannister,
//                                attribute: "Cannister",
//                                validators: [FormBuilderValidators.required()],
//                                decoration: InputDecoration(labelText: "Cannister",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderTextField(
//                                keyboardType: TextInputType.number,
//                                controller: price,
//                                attribute: "Price",
//                                validators: [FormBuilderValidators.required()],
//                                decoration: InputDecoration(labelText: "Price",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderTextField(
//                                controller: serial_number,
//                                keyboardType: TextInputType.number,
//                                attribute: "Serial Number",
//                                validators: [FormBuilderValidators.required()],
//                                decoration: InputDecoration(labelText: "Serial Number",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderTextField(
//                                controller: batch_number,
//                                keyboardType: TextInputType.number,
//                                attribute: "Serial Number",
//                                validators: [FormBuilderValidators.required()],
//                                decoration: InputDecoration(labelText: "Batch Number",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderDropdown(
//                                attribute: "Was Bought",
//                                validators: [FormBuilderValidators.required()],
//                                hint: Text("Was Bought"),
//                                items: was_bought!=null?was_bought.map((trainer)=>DropdownMenuItem(
//                                  child: Text(trainer),
//                                  value: trainer,
//                                )).toList():[""].map((name) => DropdownMenuItem(
//                                    value: name, child: Text("$name")))
//                                    .toList(),
//                                style: Theme.of(context).textTheme.body1,
//                                decoration: InputDecoration(labelText: "On Sale",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//                                onChanged: (value){
//                                  setState(() {
//                                    if(value == "Yes")
//                                      selected_was_bought_id = true;
//                                    else if(value == "No")
//                                      selected_was_bought_id = false;
//                                  });
//                                },
//                              ),
//                            ),
//
//                            Padding(
//                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
//                              child: FormBuilderDropdown(
//                                attribute: "On Sale",
//                                validators: [FormBuilderValidators.required()],
//                                hint: Text("On Sale"),
//                                items: on_sale!=null?on_sale.map((trainer)=>DropdownMenuItem(
//                                  child: Text(trainer),
//                                  value: trainer,
//                                )).toList():[""].map((name) => DropdownMenuItem(
//                                    value: name, child: Text("$name")))
//                                    .toList(),
//                                style: Theme.of(context).textTheme.body1,
//                                decoration: InputDecoration(labelText: "On Sale",
//                                  border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(9.0),
//                                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                                  ),
//                                ),
//                                onChanged: (value){
//                                  setState(() {
//                                    if(value == "Yes")
//                                      selected_on_sale_id = true;
//                                    else if(value == "No")
//                                      selected_on_sale_id = false;
//                                  });
//                                },
//                              ),
//                            ),
//
//
//                          ],
//                        ),
//                      ),
//                      Center(
//                          child:Padding(
//                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
//                              child:MaterialButton(
//                                color: Colors.teal,
//                                child: Text("Update",style: TextStyle(color: Colors.white),),
//
//                                onPressed: (){
//                                  SemenStockServices.add_semen_dose(token, 0, dose_response['horseDropDown'][selected_horse_id]['id'], dose_response['tankDropDown'][selected_tank_id]['id'], DateTime.now(), DateTime.now(), quantity.text, cannister.text, price.text, serial_number.text, batch_number.text, selected_was_bought_id, selected_on_sale_id,);
//                                },
//
//                              )
//                          )
//                      )
//                    ],
//                  )
//                ]
//            )
////
//    );
//
//  }
//
//}