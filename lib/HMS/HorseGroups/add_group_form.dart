import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/HorseGroups/utils/database_helper.dart';
import 'package:horse_management/HMS/HorseGroups/models/group.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:async';

class GroupDetail extends StatefulWidget {

  final String appBarTitle;
  final Groups group;

  GroupDetail(this. group, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return GroupDetailState(this.group, this.appBarTitle);
  }
}

class GroupDetailState extends State<GroupDetail> {

  static var _dynamics = ['Yes', 'No'];

  DatabaseHelper helper = DatabaseHelper();
  var data;
  //bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  String appBarTitle;
  Groups group;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GroupDetailState(this.group, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = group.name;
    descriptionController.text = group.comments;

    return WillPopScope(

        onWillPop: () {
          // Write some code to control things, when user press Back navigation button in device navigationBar
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(title: Text("Add Horse Group"),

            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
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
                  Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child: FormBuilderTextField(
                        controller: titleController ,
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateTitle();
                        },
                      ),
                    ),
              Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child: FormBuilderTextField(
                        controller: descriptionController,
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Comments",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value) {
                          debugPrint('Something changed in Description Text Field');
                          updateDescription();
                        },
                      ),
                    ),
              Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child:  FormBuilderDropdown(
                          attribute: "name",
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Dynamic",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          // initialValue: 'Male',
                          hint: Text('No'),
                          // validators: [FormBuilderValidators.required()],
                          items: _dynamics
                              .map((dynamics) => DropdownMenuItem(
                              value: dynamics, child: Text("$dynamics")))
                              .toList(),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              updatePriorityAsInt(valueSelectedByUser);
                            });
                          }
                    ),
              ),
                  ],
                  ),
              ),

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint("Save button clicked");
                                _save();
                              });
                            },
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
            ),

            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        group.dynamics = 1;
        break;
      case 'Low':
        group.dynamics = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String dynamic;
    switch (value) {
      case 1:
        dynamic = _dynamics[0];  // 'High'
        break;
      case 2:
        dynamic = _dynamics[1];  // 'Low'
        break;
    }
    return dynamic;
  }

  // Update the title of Note object
  void updateTitle(){
    group.name = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    group.comments = descriptionController.text;
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    group.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (group.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(group);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(group);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (group.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(group.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
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

}
//class AddGroups extends StatefulWidget{
//  final String name;
//  final Groups groups;
//
//  AddGroups(this.groups, this.name);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return AddGroupsState(this.groups, this.name);
//  }
//
//}
//class AddGroupsState extends State<AddGroups>{
//  static var _dynamics = ['Yes', 'No'];
//
//  DatabaseHelper helper = DatabaseHelper();
//
//  String appBarTitle;
//  Groups groups;
//  var data;
//  bool autoValidate = true;
//  bool readOnly = false;
//  bool showSegmentedControl = true;
//  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
//  final _formkey = GlobalKey<FormState>();
//  String _date = "Date";
//  String _Name =  "";
//  TextEditingController nameController = TextEditingController();
//  TextEditingController commentsController = TextEditingController();
//
//  AddGroupsState(Groups groups, String appBarTitle);
//
//  @override
//  Widget build(BuildContext context) {
//    nameController.text = groups.name;
//    commentsController.text = groups.comments;
//
//    // TODO: implement build
//    return WillPopScope(
//      onWillPop: () {
//        // Write some code to control things, when user press Back navigation button in device navigationBar
//        moveToLastScreen();
//      },
//    child: Scaffold(
//      appBar: AppBar(
//
//        leading: IconButton(icon: Icon(
//            Icons.arrow_back),
//            onPressed: () {
//              // Write some code to control things, when user press back button in AppBar
//              moveToLastScreen();
//            }
//        ),
//      ),
//      body:  Padding(
//        padding: EdgeInsets.all(10),
//        child: SingleChildScrollView(
//          child: Column(
//              children: <Widget>[
//                FormBuilder(
//                  key: _fbKey,
//                  initialValue: {
//                    'date': DateTime.now(),
//                    'accept_terms': false,
//                  },
//                  autovalidate: true,
//                  child: Column(children: <Widget>[
//                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
//                      child: FormBuilderTextField(
//                        controller: nameController ,
//                        attribute: 'text',
//                        style: Theme.of(context).textTheme.body1,
//                        validators: [FormBuilderValidators.required()],
//                        decoration: InputDecoration(labelText: "Name",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value) {
//                          debugPrint('Something changed in Title Text Field');
//                          updateName();
//                        },
//                      ),
//                    ),
//                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
//                      child: FormBuilderTextField(
//                        controller: commentsController,
//                        attribute: 'text',
//                        style: Theme.of(context).textTheme.body1,
//                        //validators: [FormBuilderValidators.required()],
//                        decoration: InputDecoration(labelText: "Comments",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                        onChanged: (value) {
//                          debugPrint('Something changed in Description Text Field');
//                          updateComments();
//                        },
//                      ),
//                    ),
//                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
//                      child:  FormBuilderDropdown(
//                          attribute: "name",
//                          style: Theme.of(context).textTheme.body1,
//                          decoration: InputDecoration(labelText: "Dynamic",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(9.0),
//                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                            ),
//                          ),
//                          // initialValue: 'Male',
//                          hint: Text('No'),
//                          // validators: [FormBuilderValidators.required()],
//                          items: _dynamics
//                              .map((name) => DropdownMenuItem(
//                              value: name, child: Text("$name")))
//                              .toList(),
//                          onChanged: (value) {
//                            setState(() => _Name = value);
//                            print(value);
//                          }
//                      ),
//                    ),
//                    MaterialButton(
//                      onPressed: () {
//                        setState(() {
//                          debugPrint("Save button clicked");
//                          _save();
//                        });
//                      },
//                      child: Text("Save",style: TextStyle(color: Colors.white),
//                      ),
//                      color: Colors.teal,
//                    ),
//                  ],
//                  ),
//                ),
//              ]
//          ),
//        ),
////
//      ),
//    ),
//    );
//
//  }
//  void moveToLastScreen() {
//    Navigator.pop(context, true);
//  }
//  void updateName(){
//    groups.name = nameController.text;
//  }
//  void updateComments() {
//    groups.comments = commentsController.text;
//  }
//  void _save() async {
//
//    moveToLastScreen();
//
//    groups.date = DateFormat.yMMMd().format(DateTime.now());
//    int result;
//    if (groups.id != null) {  // Case 1: Update operation
//      result = await helper.updateNote(groups);
//    } else { // Case 2: Insert Operation
//      result = await helper.insertNote(groups);
//    }
//
//    if (result != 0) {  // Success
//      _showAlertDialog('Status', 'Note Saved Successfully');
//    } else {  // Failure
//      _showAlertDialog('Status', 'Problem Saving Note');
//    }
//  }
//  void _showAlertDialog(String title, String message) {
//
//    AlertDialog alertDialog = AlertDialog(
//      title: Text(title),
//      content: Text(message),
//    );
//    showDialog(
//        context: context,
//        builder: (_) => alertDialog
//    );
//  }
//}