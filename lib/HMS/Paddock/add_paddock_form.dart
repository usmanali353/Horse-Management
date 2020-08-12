import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Utils.dart';



class add_paddock extends StatefulWidget{
  String token;

  add_paddock(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_paddock(token);
  }
}



class _add_paddock extends State<add_paddock>{
  String token;
  _add_paddock(this.token);
  String selected_location, selected_hasShade, selected_hasWater, selected_grass, selected_otherAnimals;
  int selected_location_id=0;
  bool selected_hasShade_id, selected_hasWater_id, selected_grass_id, selected_otherAnimals_id;
  // sqlite_helper local_db;
  List<String> location=[],  hasShade=['Yes','No'],  hasWater=['Yes','No'],  grass=['Yes','No'],  otherAnimals=['Yes','No'] ;
   var paddock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,mainUse,area,comments;
  bool paddock_loaded=false;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
    this.mainUse=TextEditingController();
    this.area=TextEditingController();
    this.comments=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        PaddockServices.get_Paddock_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              paddock_response=json.decode(response);
              for(int i=0;i<paddock_response['locationDropDown'].length;i++)
                location.add(paddock_response['locationDropDown'][i]['name']);
              paddock_loaded=true;
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
        appBar: AppBar(title: Text("Add Paddock"),),
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
                            attribute: "Paddock Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Paddock Name",
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
                            controller: mainUse,
                            attribute: "Main Use",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Main Use",
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
                              attribute: "Location",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("- Select -"),
                              items:location!=null?location.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Location",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_location=value;
                                  this.selected_location_id=location.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: area,
                           keyboardType: TextInputType.number,
                            attribute: "Area",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Area",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Has Shade",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: hasShade!=null?hasShade.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Has Shade?",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_hasShade_id = true;
                                else if(value == "No")
                                  selected_hasShade_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Has Water",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: hasWater!=null?hasWater.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Has Water?",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_hasWater_id = true;
                                else if(value == "No")
                                  selected_hasWater_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Grass",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: hasShade!=null?hasShade.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Grass",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_grass_id = true;
                                else if(value == "No")
                                  selected_grass_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Other Animals",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: otherAnimals!=null?otherAnimals.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Other Animals",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_otherAnimals_id = true;
                                else if(value == "No")
                                  selected_otherAnimals_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: comments,
                           // keyboardType: TextInputType.number,
                            attribute: "Comments",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Comments",
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
                      return  Center(
                          child:Padding(
                              padding: const EdgeInsets.all(16),
                              child:MaterialButton(
                                color: Colors.teal,
                                child: Text("Save",style: TextStyle(color: Colors.white),),
                                onPressed: (){
                                  if (_fbKey.currentState.validate()) {
                                    Utils.check_connectivity().then((result){
                                      if(result){
                                        ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                        pd.show();
                                        PaddockServices.addPaddock(token, 0, name.text, mainUse.text, paddock_response['locationDropDown'][selected_location_id]['id'], area.text, selected_hasShade_id, selected_hasWater_id, selected_grass_id,selected_otherAnimals_id, comments.text, null,)
                                            .then((respons){
                                          pd.dismiss();
                                          if(respons!=null){
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Paddock Added"),
                                              backgroundColor: Colors.green,
                                            ));
                                            Navigator.pop(context);
                                          }else{
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Paddock not Added"),
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

