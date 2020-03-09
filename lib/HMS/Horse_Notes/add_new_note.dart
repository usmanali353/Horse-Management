import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';

import '../../Utils.dart';

class add_new_note extends StatefulWidget{
  String token;

  add_new_note(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_note_state(token);
  }

}
class _add_new_note_state extends State<add_new_note>{
  String token;
   DateTime date;
   String  selected_horse;
   int selected_horse_id;
   var notes_data;
   var notes_dropdowns;
   bool horses_loaded=false;
  List<String> horse_name =[];
   TextEditingController details;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _add_new_note_state(this.token);

  @override
  void initState() {
    super.initState();
    details=TextEditingController();
    Utils.check_connectivity().then((result){
       if(result){
         network_operations.get_notes_dropdown(token).then((response){
           if(response!=null){
             setState(() {
               notes_dropdowns=json.decode(response);
               horses_loaded=true;
               for(int i=0;i<notes_dropdowns['horseDropDown'].length;i++){
                 horse_name.add(notes_dropdowns['horseDropDown'][i]['name']);
               }
             });
           }else{

           }
         });
       }else{

       }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Notes"),),
      body:ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Visibility(
                        visible: horses_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: horse_name.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Horse",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onSaved: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id= horse_name.indexOf(value);
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id= horse_name.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                   Padding(
                     padding: EdgeInsets.only(left: 16,right: 16),
                     child: FormBuilderDateTimePicker(
                       attribute: "Date",
                       style: Theme.of(context).textTheme.body1,
                       inputType: InputType.date,
                       format: DateFormat("MM-dd-yyyy"),
                       validators: [FormBuilderValidators.required()],
                       decoration: InputDecoration(labelText: "Date",
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(9.0),
                             borderSide: BorderSide(color: Colors.teal, width: 1.0)
                         ),
                       ),
                       onSaved: (value){
                         setState(() {
                           this.date=value;
                         });
                       },
                       onChanged: (value){
                         setState(() {
                           this.date=value;
                         });
                       },
                     ),
                   ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        attribute: "Details",
                        controller: details,
                        decoration: InputDecoration(labelText: "Details",
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
              add_note_button(notes_dropdowns:notes_dropdowns,token: token,description: details ,date: date,selected_horse: selected_horse,selected_horse_id: selected_horse_id,notes_data: notes_data,fbKey: _fbKey,)
            ],
          )
        ],
      )

    );
  }

}

class add_note_button extends StatelessWidget {
  const add_note_button({
    Key key,
    @required this.token,
    @required this.description,
    @required this.date,
    @required this.selected_horse,
    @required this.selected_horse_id,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.notes_data,
    @required this.notes_dropdowns
  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final TextEditingController description;
  final DateTime date;
  final String selected_horse;
  final int selected_horse_id;
  final GlobalKey<FormBuilderState> _fbKey;
  final notes_data,notes_dropdowns;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: Colors.teal,
        onPressed: (){
          Utils.check_connectivity().then((result){
             if(result){
                if(_fbKey.currentState.validate()){
                  _fbKey.currentState.save();
                  network_operations.add_notes(token, 0, notes_dropdowns['horseDropDown'][selected_horse_id]['id'], description.text, date,'', selected_horse).then((response){
                     if(response!=null){
                       Scaffold.of(context).showSnackBar(SnackBar(
                         backgroundColor: Colors.green,
                         content: Text("Notes Added Sucessfully"),
                       ));
                     }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Notes not Added"),
                    ));
                     }
                  });
                }
             }else{
               Scaffold.of(context).showSnackBar(SnackBar(
                 backgroundColor: Colors.red,
                 content: Text("Network not Available"),
               ));
             }
          });
        },
        child: Text("Add Notes",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}