import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_json.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/main.dart';
import 'package:intl/intl.dart';

import '../../../Utils.dart';





class update_dam extends StatefulWidget{
  String token;
  var specificdam;

  update_dam(this.token, this.specificdam);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_dam(token,specificdam);
  }
}



class _update_dam extends State<update_dam>{
  String token;
  var specificdam;
  _update_dam(this.token, this.specificdam);
  String selected_breed, selected_color;
  int selected_breed_id=0, selected_color_id=0;
  // sqlite_helper local_db;
  List<String> breed=[],  color=[];
  DateTime select_DOB;
  var dam_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,number,microchip;
  bool dam_loaded=false;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
    this.number=TextEditingController();
    this.microchip=TextEditingController();

    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        DamServices.get_Dam_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              dam_response=json.decode(response);
              for(int i=0;i<dam_response['breedDropDown'].length;i++)
                breed.add(dam_response['breedDropDown'][i]['name']);
              for(int i=0;i<dam_response['colorDropDown'].length;i++)
                color.add(dam_response['colorDropDown'][i]['name']);
              dam_loaded=true;
            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Dam"),),
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
                            attribute: "Dam Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Dam Name",
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //  visible: sale_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Color",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Color"),
                              items:breed!=null?breed.map((horse)=>DropdownMenuItem(
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16,top:16),
                          child:FormBuilderDateTimePicker(
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
                  Center(
                      child:Padding(
                          padding: const EdgeInsets.all(16),
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Update",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                DamServices.addDam(token, specificdam['horseId'], name.text, selected_breed_id, selected_color_id, select_DOB, number.text, microchip.text, specificdam['createdBy']).then((response){
                                  setState(() {
                                    var parsedjson  = jsonDecode(response);
                                    if(parsedjson != null){
                                      if(parsedjson['isSuccess'] == true){
                                        print("Successfully data saved");
                                      }else
                                        print("not saved");
                                    }else
                                      print("json response null");
                                  });
                                });
                              }
                            },
                          )
                      )
                  )
                ],
              )
            ]
        )
    );
  }

}

