import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class update_farrier extends StatefulWidget{
  String token;
 var farrierlist;
  update_farrier (this.farrierlist,this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(farrierlist,token);
  }

}
class _state_add_farrier extends State<update_farrier> {
  int selected_horse_id,selected_shoeingtype_id,selected_farrier_id,selected_costcenter_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> shoeingtype=["Complete", "Front shoeing","Back shoeing","Trimming"];List<String> farrier=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_shoeingtype,selected_farrier,selected_costcenter,selected_category,selected_contact,selected_currency;
  String token,createdBy;
  var farrierlist;
  _state_add_farrier (this.farrierlist,this.token);
   String shoetypeinitial;
  TextEditingController amount, comment;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  var farrierdropdown;
  @override
  void initState () {
    amount = TextEditingController();
    comment = TextEditingController();
    setState(() {
      amount.text = farrierlist['amount'].toString();
      comment.text  = farrierlist['comment'].toString();
    });

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



    if(farrierlist != null) {
      if (farrierlist['shoeingType'] == 1) {
        setState(() {
          shoetypeinitial = 'Complete';
        });
      }
      else if (farrierlist['shoeingType'] == 2) {
        setState(() {
          shoetypeinitial = 'Front shoeing';
        });
      }
      else if (farrierlist['shoeingType'] == 3) {
        setState(() {
          shoetypeinitial = 'Back shoeing';
        });
      }
      else if (farrierlist['shoeingType'] == 4) {
        setState(() {
          shoetypeinitial = 'Trimming';
        });
      }
    }else{
      shoetypeinitial = null;
      print("genderlist null a");
    }

  }

  @override
  Widget build (BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Farrier"),),
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
                          initialValue: farrierlist['horseName']['name'],
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
                          initialValue: shoetypeinitial,
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
                          attribute: "farrier",
                          initialValue: farrierlist['farrierId']!= null ? farrierlist['farrierName']['contactName']['name']:null,
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
                          onSaved: (value){
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
                          //initialValue: get_costcenter_by_id(farrierlist['costCenterId']),
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
                          initialValue: get_category_by_id(farrierlist['categoryId']),
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
                          initialValue: get_currency_by_id(farrierlist['currencyId']),
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
                          initialValue: get_contact_by_id(farrierlist['contactId']),
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
                            _fbKey.currentState.save();
                            print(_fbKey.currentState.value);


                            print(farrierlist['id']);
                            print(token);print(createdBy);print(farrierdropdown['horseDropDown'][selected_horse_id]['id']);print(selected_shoeingtype_id);
                            print(farrierdropdown['farrierDropDown'][selected_farrier_id]['id']);
                            print("farrier show");
                            print(selected_contact_id);
                            print(amount.text);
                            print( comment.text);
                            print(farrierdropdown['costCenterDropDown'][selected_costcenter_id]['id']);
                            print(farrierdropdown['contactsDropDown'][selected_contact_id]['id']);
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            farrier_services.farrierSave(farrierlist['createdBy'],farrierlist['id'],token, farrierdropdown['horseDropDown'][selected_horse_id]['id'], farrierdropdown['farrierDropDown'][selected_farrier_id]['id'],selected_shoeingtype_id, comment.text,amount.text, farrierdropdown['currencyDropDown'][selected_currency_id]['id'], farrierdropdown['categoryDropDown'][selected_category_id]['id'], farrierdropdown['costCenterDropDown'][selected_costcenter_id]['id'], farrierdropdown['contactsDropDown'][selected_contact_id]['id']).then((response){
                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "update Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);}
                                else{
                                  Flushbar(message: "Not updated",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not updated",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                            });





                          }
                        },
                        child: Text(
                          "Update Farrier", style: TextStyle(color: Colors.white),),
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
    if(farrierlist!=null&&farrierdropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(farrierdropdown['currencyDropDown'][i]['id']==id){
          plan_name=farrierdropdown['currencyDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(farrierlist!=null&&farrierdropdown['categoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(farrierdropdown['categoryDropDown'][i]['id']==id){
          plan_name=farrierdropdown['categoryDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(farrierlist=null&&farrierdropdown['costCenterDropDown']!=null && id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(farrierdropdown['costCenterDropDown'][i]['id']==id){
          plan_name=farrierdropdown['costCenterDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var plan_name;
    if(farrierlist!=null&&farrierdropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(farrierdropdown['contactsDropDown'][i]['id']==id){
          plan_name=farrierdropdown['contactsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
}