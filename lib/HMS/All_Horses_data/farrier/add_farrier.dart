import 'dart:convert';
import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class add_farrier extends StatefulWidget{
  String token;

  add_farrier (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(token);
  }

}
class _state_add_farrier extends State<add_farrier> {
  int selected_horse_id,selected_shoeingtype_id,selected_farrier_id,selected_costcenter_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> shoeingtype=["Complete", "Front shoeing","Back shoeing","Trimming"];List<String> farrier=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_shoeingtype,selected_farrier,selected_costcenter,selected_category,selected_contact,selected_currency;
  String token;

  _state_add_farrier (this.token);

  TextEditingController amount, comment;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  var farrierdropdown;
  @override
  void initState () {
    amount = TextEditingController();
    comment = TextEditingController();

    farrier_services.farrierDropdown(token).then((response){
      setState(() {
        print(response);
        farrierdropdown=json.decode(response);
        for(int i=0;i<farrierdropdown['horseDropDown'].length;i++)
          horse.add(farrierdropdown['horseDropDown'][i]['name']);
        for(int i=0;i<farrierdropdown['farrierDropDown'].length;i++)
          farrier.add(farrierdropdown['farrierDropDown'][i]['name']);
        for(int i=0;i<farrierdropdown['currencyDropDown'].length;i++)
          currency.add(farrierdropdown['currencyDropDown'][i]['name']);
        for(int i=0;i<farrierdropdown['categoryDropDown'].length;i++)
          category.add(farrierdropdown['categoryDropDown'][i]['name']);
        for(int i=0;i<farrierdropdown['costCenterDropDown'].length;i++)
          costcenter.add(farrierdropdown['costCenterDropDown'][i]['name']);
        for(int i=0;i<farrierdropdown['contactsDropDown'].length;i++)
          contact.add(farrierdropdown['contactsDropDown'][i]['name']);
        print(contact);

      });
    });

  }

  @override
  Widget build (BuildContext context) {
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
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Horse",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
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
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Shoe Type",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Shoe Type"),
                          items: shoeingtype.map((name) =>
                              DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Shoeing Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_shoeingtype=value;
                              selected_shoeingtype_id = shoeingtype.indexOf(value)+1;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_shoeingtype=value;
                              selected_shoeingtype_id = shoeingtype.indexOf(value)+1;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Responsible",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("farrier"),
                          items: farrier!=null?farrier.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Farrier",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              this.selected_farrier=value;
                              selected_farrier_id = farrier.indexOf(value);
                            });
                          },
                        ),

                      ),


                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                        child: FormBuilderTextField(
                          controller: amount,
                          attribute: "amount",
                          decoration: InputDecoration(labelText: "Amount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Cost Center",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Center"),
                          items: costcenter!=null?costcenter.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Cost Center",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
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
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Account Category",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Category"),
                          items:  category!=null?category.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Account Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
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
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "currency",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Currency"),
                          items:  currency!=null?currency.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Currency",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              this.selected_currency = value;
                              selected_currency_id = currency.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_currency = value;
                              selected_currency_id = currency.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "contact",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Contact"),
                          items:contact!=null?contact.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Contact",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              this.selected_contact = value;
                              selected_contact_id = contact.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_contact = value;
                              selected_contact_id = contact.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: comment,
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                              hintText: "Add Comment",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ),



                    ],
                  ),
                ),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: () {
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                            print(token);print(farrierdropdown['horseDropDown'][selected_horse_id]['id']);print(selected_shoeingtype_id);
                            print(farrierdropdown['farrierDropDown'][selected_farrier_id]['id']);
                            print("farrier show");
                            print(selected_contact_id);
                            print(amount.text);
                            print( comment.text);
                            print(farrierdropdown['costCenterDropDown'][selected_costcenter_id]['id']);
                            print(farrierdropdown['contactsDropDown'][selected_contact_id]['id']);
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            //pd.show();
                            farrier_services.farrierSave(null,0,token, farrierdropdown['horseDropDown'][selected_horse_id]['id'], farrierdropdown['farrierDropDown'][selected_farrier_id]['id'],selected_shoeingtype_id, comment.text,amount.text, farrierdropdown['currencyDropDown'][selected_currency_id]['id'], farrierdropdown['categoryDropDown'][selected_category_id]['id'], farrierdropdown['costCenterDropDown'][selected_costcenter_id]['id'], farrierdropdown['contactsDropDown'][selected_contact_id]['id']).then((response){
                              //pd.dismiss();
                              if(response !=null)
                                print("Successfully lab test added");
                              else{
                                print("data not added");}
                            });





                          }
                        },
                        child: Text(
                          "Add Farrier", style: TextStyle(color: Colors.white),),
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