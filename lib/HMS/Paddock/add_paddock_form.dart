import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/HMS/Paddock/utils/database_helper.dart';
import 'package:horse_management/HMS/Paddock/models/paddock.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AddPaddock extends StatefulWidget{

  final String appBarTitle;
  final Paddocks paddocks;

  AddPaddock(this.paddocks,this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPaddock_form(this.paddocks, this.appBarTitle);
  }

}
class _AddPaddock_form extends State<AddPaddock>{

  static var _location = [''];
  static var _has_shade = ['Yes', 'No'];
  static var _has_water = ['Yes', 'No'];

  DatabaseHelper helper = DatabaseHelper();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  String _date = "Date";
  String _Name =  "";
  String appBarTitle;
  Paddocks paddocks;

  TextEditingController titleController = TextEditingController();
  TextEditingController mainUseController = TextEditingController();
  //TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController grassController = TextEditingController();
  TextEditingController otherAnimalsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  _AddPaddock_form(this.paddocks, this.appBarTitle);



  @override
  Widget build(BuildContext context) {
    titleController.text = paddocks.name;
    mainUseController.text = paddocks.main_use;
    areaController.text = paddocks.area;
    grassController.text = paddocks.grass;
    otherAnimalsController.text = paddocks.other_animals;
    descriptionController.text = paddocks.comments;

    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        // Write some code to control things, when user press Back navigation button in device navigationBar
        moveToLastScreen();
      },
    child: Scaffold(
      appBar: AppBar(title: Text("Add Paddock"),
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
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: titleController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateTitle();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: mainUseController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateMainUse();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Main Use",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child:  FormBuilderDropdown(
                          attribute: "name",
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          // initialValue: 'Male',
                          hint: Text('No'),
                          // validators: [FormBuilderValidators.required()],
                          items: _location
                              .map((dynamics) => DropdownMenuItem(
                              value: dynamics, child: Text("$dynamics")))
                              .toList(),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              updateLocationAsInt(valueSelectedByUser);
                            });
                          }
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: mainUseController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateArea();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Area",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child:  FormBuilderDropdown(
                          attribute: "name",
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Has Shade",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          // initialValue: 'Male',
                          hint: Text('No'),
                          // validators: [FormBuilderValidators.required()],
                          items: _has_shade
                              .map((dynamics) => DropdownMenuItem(
                              value: dynamics, child: Text("$dynamics")))
                              .toList(),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              updateHasShadeAsInt(valueSelectedByUser);
                            });
                          }
                      ),
                    ),
//                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
//                      child: FormBuilderTextField(
//                        attribute: 'text',
//                        style: Theme.of(context).textTheme.body1,
//                        //validators: [FormBuilderValidators.required()],
//                        decoration: InputDecoration(labelText: "Has Shade",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                      ),
//                    ),
                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 15),
                      child:  FormBuilderDropdown(
                          attribute: "name",
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Has Water",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          // initialValue: 'Male',
                          hint: Text('No'),
                          // validators: [FormBuilderValidators.required()],
                          items: _has_water
                              .map((dynamics) => DropdownMenuItem(
                              value: dynamics, child: Text("$dynamics")))
                              .toList(),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              updateHasWaterAsInt(valueSelectedByUser);
                            });
                          }
                      ),
                    ),
//                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
//                      child: FormBuilderTextField(
//                        attribute: 'text',
//                        style: Theme.of(context).textTheme.body1,
//                        //validators: [FormBuilderValidators.required()],
//                        decoration: InputDecoration(labelText: "Has Water",
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
//                        ),
//                      ),
//                    ),
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: grassController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateGrass();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Grass",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: otherAnimalsController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateOtherAnimals();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Other Animals",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:25 ,bottom: 25),
                      child: FormBuilderTextField(
                        controller: descriptionController ,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateDescription();
                        },
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Comments",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
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
              ]
          ),
        ),
      ),
    ),
    );

  }
  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updateLocationAsInt(String value) {
    switch (value) {
      case 'High':
        paddocks.location = 1;
        break;
      case 'Low':
        paddocks.location = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getLocationAsString(int value) {
    String dynamic;
    switch (value) {
      case 1:
        dynamic = _location[0];  // 'High'
        break;
      case 2:
        dynamic = _location[1];  // 'Low'
        break;
    }
    return dynamic;
  }

  void updateHasShadeAsInt(String value) {
    switch (value) {
      case 'High':
        paddocks.has_shade = 1;
        break;
      case 'Low':
        paddocks.has_shade = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getHasShadeAsString(int value) {
    String dynamic;
    switch (value) {
      case 1:
        dynamic = _has_shade[0];  // 'High'
        break;
      case 2:
        dynamic = _has_shade[1];  // 'Low'
        break;
    }
    return dynamic;
  }
  void updateHasWaterAsInt(String value) {
    switch (value) {
      case 'High':
        paddocks.has_water = 1;
        break;
      case 'Low':
        paddocks.has_water = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getHasWaterAsString(int value) {
    String dynamic;
    switch (value) {
      case 1:
        dynamic = _has_water[0];  // 'High'
        break;
      case 2:
        dynamic = _has_water[1];  // 'Low'
        break;
    }
    return dynamic;
  }
  // Update the title of Note object
  void updateTitle(){
    paddocks.name = titleController.text;
  }
  void updateMainUse(){
    paddocks.main_use = mainUseController.text;
  }
  void updateArea(){
    paddocks.area = areaController.text;
  }
  void updateGrass(){
    paddocks.grass = grassController.text;
  }
  void updateOtherAnimals(){
    paddocks.other_animals = otherAnimalsController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    paddocks.comments = descriptionController.text;
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    paddocks.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (paddocks.id != null) {  // Case 1: Update operation
      result = await helper.updateNote(paddocks);
    } else { // Case 2: Insert Operation
      result = await helper.insertNote(paddocks);
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
    if (paddocks.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(paddocks.id);
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