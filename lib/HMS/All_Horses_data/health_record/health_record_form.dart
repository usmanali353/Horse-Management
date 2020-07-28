import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/Health_Record.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/HMS/All_Horses_data/services/health_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
class health_record_form extends StatefulWidget{
  String token;

  health_record_form (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _health_record_form(token);
  }

}
class _health_record_form extends State<health_record_form>{
  int selected_horse_id,selected_health_record_type_id,selected_responsible_id,selected_cost_center_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> recordtype=["Record type 1", "record type 2"];List<String> positive=[];List<String> responsible=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_health_record_type,selected_responsible,selected_cost_center,selected_category,selected_contact,selected_currency;
  int selected_quantity;
  String token;
  var healthdropdown;
  _health_record_form (this.token);

  sqlite_helper local_db;
   TextEditingController product,comment,amount;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    local_db=sqlite_helper();
    product=TextEditingController();
    comment=TextEditingController();
    amount=TextEditingController();


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        healthServices.healthdropdown(token).then((response){
          pd.dismiss();
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
      }else
        Flushbar(message: "Network Error",backgroundColor: Colors.red,duration: Duration(seconds: 3),).show(context);
    });

//    healthServices.healthdropdown(token).then((response){
//      setState(() {
//        print(response);
//        healthdropdown=json.decode(response);
//        for(int i=0;i<healthdropdown['horseDropDown'].length;i++)
//          horse.add(healthdropdown['horseDropDown'][i]['name']);
//        for(int i=0;i<healthdropdown['responsibleDropDown'].length;i++)
//          responsible.add(healthdropdown['responsibleDropDown'][i]['name']);
//        for(int i=0;i<healthdropdown['currencyDropDown'].length;i++)
//          currency.add(healthdropdown['currencyDropDown'][i]['name']);
//        for(int i=0;i<healthdropdown['categoryDropDown'].length;i++)
//          category.add(healthdropdown['categoryDropDown'][i]['name']);
//        for(int i=0;i<healthdropdown['costCenterDropDown'].length;i++)
//          costcenter.add(healthdropdown['costCenterDropDown'][i]['name']);
//        for(int i=0;i<healthdropdown['contactsDropDown'].length;i++)
//          contact.add(healthdropdown['contactsDropDown'][i]['name']);
//        print(contact);
//
//      });
//    });

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
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Record type",
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
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Responsible",
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
                        iconActiveColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                        initialValue: 1,
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
                          });                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Category",
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
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Cost Center",
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
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
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
//                      local_db.create_health_record(new Health_Record(selected_amount,selected_quantity,selected_horse,selected_health_record_type,selected_responsible,product.text,comment.text,selected_currency,selected_category,selected_cost_center,selected_contact)).then((value){
////                        if(value>0){
////                              print("health record inserted Sucessfully");
////                        }else{
////                              print("health record insertion Failed");
////                        }
////                      });
                      print(token);print(healthdropdown['horseDropDown'][selected_horse_id]['id']);print(selected_health_record_type_id);
                      print(healthdropdown['responsibleDropDown'][selected_responsible_id]['id']);print( selected_quantity);
                      print(healthdropdown['costCenterDropDown'][selected_cost_center_id]['id']);
                      print(selected_contact_id);
                      print(amount.text);
                      print(healthdropdown['contactsDropDown'][0]['id']);
                      ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                      pd.show();
                      healthServices.healthRecordSave(null,0,token, healthdropdown['horseDropDown'][selected_horse_id]['id'], healthdropdown['responsibleDropDown'][selected_responsible_id]['id'],selected_health_record_type_id, product.text, selected_quantity, comment.text,amount.text, healthdropdown['currencyDropDown'][selected_currency_id]['id'], healthdropdown['categoryDropDown'][selected_category_id]['id'], healthdropdown['costCenterDropDown'][selected_cost_center_id]['id'], healthdropdown['contactsDropDown'][selected_contact_id]['id']).then((response){
                        pd.dismiss();
                        if(response !=null) {
                          var decode= jsonDecode(response);
                          if(decode['isSuccess'] == true){
                            Navigator.pop(context,"refresh");
                            Flushbar(message: "Added Successfully",
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.green,)
                              ..show(context);}
                          else{
                            Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                        }else{
                          Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                      });
                    },
                    child: Text("Update Health Record",style: TextStyle(color: Colors.white),),
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


}
