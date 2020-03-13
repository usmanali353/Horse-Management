import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/Utils.dart';


class AddNewDiet extends StatefulWidget{
  String token;

  AddNewDiet(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_note_state(token);
  }

}
class _add_new_note_state extends State<AddNewDiet>{
  Map<String, String> _formdata = {};
  var _myPets = List<Widget>();
  int _index = 1;

  String token;
  DateTime date;
  var notes_data;
  var dietItemDropdown;
  bool horses_loaded=false;
  List<String> dietItem = ['abc','xyzz'],time = ['Am','Lunch','Pm','Night'];
  TextEditingController name,description;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _add_new_note_state(this.token);

  @override
  void initState() {
    super.initState();
    _add();
    name=TextEditingController();
    description=TextEditingController();
    Utils.check_connectivity().then((result){
      if(result){
        DietServices.inventoryProductDropDown(token).then((response){
          if(response!=null){
            setState(() {
              dietItemDropdown=json.decode(response);
              horses_loaded=true;
              for(int i=0;i<dietItemDropdown['inventoryDropDown'].length;i++){
                dietItem.add(dietItemDropdown['inventoryDropDown'][i]['name']);
              }
            });
          }else{

          }
        });
      }else{
            print("network not available");
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
//                      Padding(
//                        padding: const EdgeInsets.all(16),
//                        child: Visibility(
//                          visible: horses_loaded,
//                          child: FormBuilderDropdown(
//                            attribute: "item",
//                            validators: [FormBuilderValidators.required()],
//                            hint: Text("Select Item"),
//                            items: category.map((name) => DropdownMenuItem(
//                                value: name, child: Text("$name")))
//                                .toList(),
//                            style: Theme.of(context).textTheme.body1,
//                            decoration: InputDecoration(labelText: "Inventory Items",
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(9.0),
//                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                              ),
//                            ),
//                            onSaved: (value){
//                              setState(() {
//                                this.selected_items=value;
//                                selected_item_id= inventoryItem.indexOf(value);
//                              });
//                            },
//                            onChanged: (value){
//                              setState(() {
//                                this.selected_items=value;
//                                selected_item_id= inventoryItem.indexOf(value);
//                              });
//                            },
//                          ),
//                        ),
//                      ),

                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          attribute: "cost",
                          controller: name,
                          decoration: InputDecoration(labelText: "Name",
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
                          attribute: "des",
                          controller: description,
                          decoration: InputDecoration(labelText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                        ),
                      ),Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment:  MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Diet Details",textScaleFactor: 1.3,),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: IconButton(
                                  icon: Icon(Icons.add_circle),
                                  color: Colors.teal,
                                  onPressed: ()  {
                                    _add();
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),

                      ListView(
                        shrinkWrap: true,
                        children: _myPets,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  color: Colors.teal,
                  onPressed: (){
                    print(_formdata);
                    Utils.check_connectivity().then((result){
                      if(result){
                        if(_fbKey.currentState.validate()){
                          _fbKey.currentState.save();
                          DietServices.newDietSave(null, token, 0, name.text, description.text, 0, 1, 1, 2).then((response){
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
                //add_note_button(fbKey: _fbKey,token: token,name: name,description: description,key: _formdata,)
              ],
            )
          ],
        )

    );
  }

  void _add() {
    int keyValue = _index;
    _myPets = List.from(_myPets)
      ..add(
          Column(
            key: Key("${keyValue}"),
            children: <Widget>[
              ListTile(
                // leading: Text('Pet $_index : '),
                title:FormBuilderDropdown(
                    attribute: "name",
                    decoration: InputDecoration(labelText: "Select Item $_index",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    // initialValue: 'Male',
                    hint: Text('select item'),
                    validators: [FormBuilderValidators.required()],
                    items: dietItem!=null?dietItem.map((name)=>DropdownMenuItem(
                      child: Text("$name"),
                      value: name,
                    )).toList():["no item yet"].map((name) => DropdownMenuItem(
                        value: name, child: Text("$name")))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _formdata['dietItemId${keyValue - 1}'] = dietItem.indexOf(value).toString());
                      print(value);
                      print(_formdata['dietItemId${keyValue - 1}']);
                    }
                ),
              ),
              ListTile(
               // leading: Text('Quantity $_index : '),
                title: FormBuilderTextField(
                  attribute: "des",
                  controller: description,
                  decoration: InputDecoration(labelText: "Quantity $_index",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: BorderSide(color: Colors.teal, width: 1.0)
                    ),
                  ),
                  onChanged: (val) {
                    _formdata['quantity${keyValue - 1}'] = val;
                  },
                ),
//                TextField(
//                  onChanged: (val) {
//                    _formdata['quantity${keyValue - 1}'] = val;
//                  },
//                ),
              ),
              ListTile(
                // leading: Text('Pet $_index : '),
                title:FormBuilderDropdown(
                    attribute: "time",
                    decoration: InputDecoration(labelText: "Select Time",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    // initialValue: 'Male',
                    hint: Text('Select '),
                    validators: [FormBuilderValidators.required()],
                    items: time.map((name) => DropdownMenuItem(
                        value: name, child: Text("$name")))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _formdata['TimeId${keyValue - 1}'] = time.indexOf(value).toString());
                      print(value);
                      print(_formdata['TimeId${keyValue - 1}']);
                    }
                ),
              ),
              SizedBox(height: 15,)
            ],
          ));
    print(_formdata);
    setState(() => ++_index);
  }

}

class add_note_button extends StatelessWidget {
  const add_note_button({
    Key key,
    this.token,
    this.name,
    this.description,

    GlobalKey<FormBuilderState> fbKey,

  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final TextEditingController name,description;
  final GlobalKey<FormBuilderState> _fbKey;
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
                DietServices.newDietSave(null, token, 0, name.text, description.text, 0, 1, 1, 2).then((response){
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