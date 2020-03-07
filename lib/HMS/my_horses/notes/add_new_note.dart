import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/Add_Note.dart';
import 'package:horse_management/Model/sqlite_helper.dart';

class add_new_note extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_new_note();
  }

}
class _state_new_note extends State<add_new_note>{

  String selected_horse;
  String select_date = "Select Date";
  TextEditingController comment;
  sqlite_helper local_db;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    comment= TextEditingController();
    local_db=sqlite_helper();
    local_db.get_add_note().then((list){
      if(list!=null) {
        print("Number of Records "+list.length.toString());
      }else{
        print("No Note Found");
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Note"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: ["Horse 1","Horse 2","Horse 3"].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Horse",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_horse=value;
                          },
                        ),
                      ),
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Select Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.select_date=value.toString();
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: comment,
                          attribute: "Comment",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Comment",
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
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          local_db.create_add_note(Add_Note(selected_horse,comment.text,select_date)).then((value){
                            if(value>0){
                              print("Add Note inserted Sucessfully");
                            }else{
                              print("No Note insertion Failed");
                            }
                          });
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                          }
                        },
                        child:Text("Add Note",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }

}