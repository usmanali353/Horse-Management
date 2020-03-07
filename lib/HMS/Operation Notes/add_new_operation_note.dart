import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Operation Notes/utils/database_helper.dart';
import 'package:horse_management/HMS/Operation Notes/models/notes.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:intl/intl.dart';

class add_new_opertation_note extends StatefulWidget{
  final String appBarTitle;
  final Notes notes;

  add_new_opertation_note(this.notes, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_opertation_note_state(this.notes, this.appBarTitle);
  }

}
class _add_new_opertation_note_state extends State<add_new_opertation_note>{

  static var _general_category = ['C1', 'C2'];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Notes notes;
  _add_new_opertation_note_state(this.notes, this.appBarTitle);
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  String _date = "Date";
  String _Name =  "";
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dateController.text = notes.date;
    descriptionController.text = notes.comments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add New Operation Notes"),

        leading: IconButton(icon: Icon(
            Icons.arrow_back),
            onPressed: () {
              // Write some code to control things, when user press back button in AppBar
              moveToLastScreen();
            }
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top:2 ,bottom: 2),
                      child:  FormBuilderDateTimePicker(
                        controller: dateController ,
                        onChanged: (value) {
                          debugPrint('Date changed');
                          updateDate();
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
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "General Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('No'),
                        validators: [FormBuilderValidators.required()],
                        items: [_general_category]
                            .map((dynamic) => DropdownMenuItem(
                            value: dynamic, child: Text("$dynamic")))
                            .toList(),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              updatePriorityAsInt(valueSelectedByUser);
                            });
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        onChanged: (value) {
                          debugPrint('Something changed in Description Text Field');
                          updateDescription();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Details",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          _save();
                        });
                      },
                      child: Text("Save",style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.teal,
                    ),
                  ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );

  }
  void updateDate(){
    notes.date = dateController.text;
  }
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        notes.general_category = 1;
        break;
      case 'Low':
        notes.general_category = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String dynamic;
    switch (value) {
      case 1:
        dynamic = _general_category[0];  // 'High'
        break;
      case 2:
        dynamic = _general_category[1];  // 'Low'
        break;
    }
    return dynamic;
  }
//  void updateCategoryAsInt(String value) {
//    switch (value) {
//      case 'High':
//        notes.general_category = 1;
//        break;
//      case 'Low':
//        notes.general_category = 2;
//        break;
//    }
//  }
//
//  // Convert int priority to String priority and display it to user in DropDown
//  String getCategoryAsString(int value) {
//    String category;
//    switch (value) {
//      case 1:
//        category = _general_category[0];  // 'High'
//        break;
//      case 2:
//        category = _general_category[1];  // 'Low'
//        break;
//    }
//    return category;
//  }
  void updateDescription() {
    notes.comments = descriptionController.text;
  }
  void _save() async {

    moveToLastScreen();

    notes.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (notes.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(notes);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(notes);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }
  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
