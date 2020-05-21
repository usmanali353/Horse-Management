import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_json.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_json.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/main.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class UpdateSire extends StatefulWidget{
  String token;
  var specificdam;

  UpdateSire(this.token, this.specificdam);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateSire(token,specificdam);
  }
}



class _UpdateSire extends State<UpdateSire>{
  String token;
  var specificdam;
  _UpdateSire(this.token, this.specificdam);
  String selected_breed, selected_color;
  int selected_breed_id=0, selected_color_id=0;
  // sqlite_helper local_db;
  List<String> breed=[],  color=[], dam=[];
  DateTime select_DOB;
  var dam_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,number,microchip;
  bool dam_loaded=false;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  var breed_name,color_name;
  @override
  void initState() {
    this.name=TextEditingController();
    this.number=TextEditingController();
    this.microchip=TextEditingController();
    setState(() {
      if(specificdam['name']!=null){
        name.text=specificdam['name'];
      }
      if(specificdam['number']!=null){
        number.text=specificdam['number'];
      }
      if(specificdam['microchipNo']!=null){
        microchip.text=specificdam['microchipNo'];
      }
    });
    DamServices.get_Dam_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          dam_response=json.decode(response);
          for(int i=0;i<dam_response['breedDropDown'].length;i++) {
            breed.add(dam_response['breedDropDown'][i]['name']);
          }
          for(int i=0;i<dam_response['colorDropDown'].length;i++) {
            color.add(dam_response['colorDropDown'][i]['name']);
          }
        });
      }else{

      }
    });
    super.initState();
  }
  String get_breed_by_id(int id){
    var breed_name;
    if(specificdam!=null&&dam_response['breedDropDown']!=null&&id!=null){
      for(int i=0;i<breed.length;i++){
        if(dam_response['breedDropDown'][i]['id']==id){
          breed_name=dam_response['breedDropDown'][i]['name'];
        }
      }
      return breed_name;
    }else
      return null;
  }
  String get_color_by_id(int id){
    var color_name;
    if(specificdam!=null&&dam_response['colorDropDown']!=null&&id!=null){
      for(int i=0;i<color.length;i++){
        if(dam_response['colorDropDown'][i]['id']==id){
          color_name=dam_response['colorDropDown'][i]['name'];
        }
      }
      return color_name;
    }else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Sire"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: name,
                            attribute: "Sire Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Sire Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //  visible: sale_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Breed",
                              // initialValue: specificdam!=null?specificdam['name']:null,
                              initialValue: get_breed_by_id(specificdam['breedId'])!= null ?get_breed_by_id(specificdam['breedId']):null,
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Breed"),
                              items:breed!=null?breed.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Breed",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_breed=value;
                                  this.selected_breed_id=breed.indexOf(value);
                                });
                              },
                              onSaved: (value){
                                setState(() {
                                  this.selected_breed=value;
                                  this.selected_breed_id=breed.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //  visible: sale_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Color",
                              // initialValue: specificdam!=null?specificdam['name']:null,
                              initialValue: get_color_by_id(specificdam['colorId'])!= null ?get_color_by_id(specificdam['colorId']):null,
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Color"),
                              items:color!=null?color.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Color",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_color=value;
                                  this.selected_color_id=color.indexOf(value);
                                });
                              },
                              onSaved: (value){
                                setState(() {
                                  this.selected_color=value;
                                  this.selected_color_id=color.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,top:16),
                          child:FormBuilderDateTimePicker(
                            initialValue: specificdam['dateOfBirth']!=null?DateTime.parse(specificdam['dateOfBirth']):null,
                            attribute: "DOB",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            validators: [FormBuilderValidators.required()],
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "DOB",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              setState(() {
                                this.select_DOB=value;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.select_DOB=value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: number,
                            keyboardType: TextInputType.number,
                            attribute: "Number",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: microchip,
                            keyboardType: TextInputType.number,
                            attribute: "Microchip#",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Microchip#",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context){
                      return Center(
                          child:Padding(
                              padding: const EdgeInsets.all(16),
                              child:MaterialButton(
                                color: Colors.teal,
                                child: Text("Update",style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  if (_fbKey.currentState.validate()) {
                                    _fbKey.currentState.save();
                                   print(specificdam['horseId']);
                                    print(specificdam['createdBy']);
                                    Utils.check_connectivity().then((result){
                                      if(result){
                                        ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                        pd.show();
                                        SireServices.addSire(token, specificdam['horseId'], name.text,2,specificdam['createdBy'],dam_response['breedDropDown'][selected_breed_id]['id'],select_DOB, dam_response['colorDropDown'][selected_color_id]['id'], number.text, microchip.text).then((respons){
                                          pd.dismiss();
                                          if(respons!=null){
                                            Navigator.pop(context);
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Updated sucessfully"),
                                              backgroundColor: Colors.green,
                                            ));
                                          }else{
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Not Updated sucessfully"),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        });
                                      }
                                    });
                                  }
                                },
                              )
                          )
                      );
                    },

                  )
                ],
              )
            ]
        )
    );
  }

}

