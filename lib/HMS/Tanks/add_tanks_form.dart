import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Tanks/tanks_json.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Utils.dart';

class add_tanks_form extends StatefulWidget{
  final token;
  add_tanks_form(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_tanks_form(token);
  }

}
class _add_tanks_form extends State<add_tanks_form>{
  final token;
  _add_tanks_form(this.token,);
  String selected_tanks;

  DateTime lastfill_date = DateTime.now();
  DateTime nextfill_date = DateTime.now();
  DateTime policydue_date = DateTime.now();
  int selected_tanks_id=0;

  List<String> tanks=[];
  var tanks_response;
  TextEditingController name, capacity,policynumber;


  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool _isvisible=false;
  //bool notes_loaded=false;
  bool update_notes_visibility;


  @override
  void initState() {
    this.name=TextEditingController();
    this.capacity=TextEditingController();
    this.policynumber=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        TanksServices.get_Tanks_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              tanks_response=json.decode(response);
              for(int i=0;i<tanks_response['locationDropDown'].length;i++)
                tanks.add(tanks_response['locationDropDown'][i]['name']);
              //notes_loaded=true;
              update_notes_visibility=true;
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
      appBar: AppBar(title: Text("Add Tanks"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: name,
                      attribute: "Tanks Name",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Tanks Name",
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
                      //visible: sale_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Location",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("- Select -"),
                        items:tanks!=null?tanks.map((horse)=>DropdownMenuItem(
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
                            this.selected_tanks=value;
                            this.selected_tanks_id=tanks.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: capacity,
                      attribute: "Capacity",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Capacity",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.lastfill_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "LastFill Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.nextfill_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "NextFill Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: policynumber,
                      attribute: "Insurance Policy #",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Insurance Policy #",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.policydue_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Insurance Policy Due Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context){
                      return  MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                TanksServices.add_Tanks(null,token,0,name.text,tanks_response['locationDropDown'][selected_tanks_id]['locationId'], capacity.text,lastfill_date,nextfill_date,policynumber.text,policydue_date)                                .then((respons){
                                  pd.dismiss();
                                  if(respons!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Tank Added"),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pop(context);
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Tank not Added"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              }
                            });
                          }
                        },
                        child: Text("Save",style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.teal,
                      );
                    },

                  ),
                ],
                ),
              ),

            ],
          ),
        ),

      ),
    );

  }
}