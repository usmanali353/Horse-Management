import 'dart:convert';

import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/OperationNotes/utils/database_helper.dart';
import 'package:horse_management/HMS/OperationNotes/models/notes.dart';
import 'package:horse_management/HMS/OperationNotes/operation_notes_json.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Utils.dart';

class add_new_opertation_note extends StatefulWidget{
  final token;
  add_new_opertation_note(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_opertation_note(token);
  }

}
class _add_new_opertation_note extends State<add_new_opertation_note>{
  final token;
  _add_new_opertation_note(this.token,);
  String selected_notes;
  DateTime select_date = DateTime.now();
  int selected_notes_id=0;

  List<String> notes=[];
  var notes_response;
  TextEditingController details;


  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool _isvisible=false;
  //bool notes_loaded=false;
  bool update_notes_visibility;


  @override
  void initState() {
    this.details=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        OperationNotesServices.get_Operation_Notes_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              notes_response=json.decode(response);
              for(int i=0;i<notes_response['generalCategoeyDropDown'].length;i++)
                notes.add(notes_response['generalCategoeyDropDown'][i]['name']);
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
      appBar: AppBar(title: Text("Add Operation Notes"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                //autovalidate: true,
                child: Column(children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.select_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      //visible: sale_loaded,
                      child: FormBuilderDropdown(
                        attribute: "General Category",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("- Select -"),
                        items:notes!=null?notes.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "General Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_notes=value;
                            this.selected_notes_id=notes.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: details,
                      attribute: "Details",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Details",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),

                  Builder(
                    builder: (BuildContext context){
                      return MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                OperationNotesServices.add_Operation_Notes(null,token,0,DateTime.now(),notes_response['generalCategoeyDropDown'][selected_notes_id]['id'], details.text)                                .then((respons){
                                  pd.dismiss();
                                  if(respons!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Operational Notes Added"),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pop(context);
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Operational Notes not Added"),
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
