import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_json.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/main.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';





class add_dam extends StatefulWidget{
  String token;

  add_dam(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_dam(token);
  }
}



class _add_dam extends State<add_dam>{
  String token;
  _add_dam(this.token);
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
        appBar: AppBar(title: Text("Add Dams"),),
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
                          child:Builder(
                            builder: (BuildContext context){
                              return  MaterialButton(
                                color: Colors.teal,
                                child: Text("Save",style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  if (_fbKey.currentState.validate()) {
                                    Utils.check_connectivity().then((result){
                                      if(result){
                                        ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                        pd.show();
                                        DamServices.addDam(token, 0, name.text, true, true, true, dam_response['breedDropDown'][selected_breed_id]['id'], dam_response['colorDropDown'][selected_color_id]['id'], select_DOB, number.text, microchip.text, null)
                                            .then((respons){
                                          pd.dismiss();
                                          if(respons!=null){
                                            Navigator.pop(context);
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Dam Added",
                                                style: TextStyle(
                                                    color: Colors.red
                                                ),
                                              ),
                                              backgroundColor: Colors.green,
                                            ));
                                          }else{
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Dam not Added",
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                              ),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        });
                                      }
                                    });
                                  }
                                },
                              );
                            }

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

