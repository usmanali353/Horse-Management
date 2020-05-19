import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/Utils.dart';


class createFromInventory extends StatefulWidget{
  String token;

  createFromInventory(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_note_state(token);
  }

}
class _add_new_note_state extends State<createFromInventory>{
  String token;
  DateTime date;
  String  selected_items,selected_category;
  int selected_item_id,selected_category_id;
  var notes_data;
  var inventoryDropdown;
  bool horses_loaded=false;
  List<String> category =['Grain','Supplements','Forage','Rations'],inventoryItem = [];
  TextEditingController cost;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _add_new_note_state(this.token);

  @override
  void initState() {
    super.initState();
    cost=TextEditingController();
    Utils.check_connectivity().then((result){
      if(result){
        DietServices.inventoryProductDropDown(token).then((response){
          if(response!=null){
            setState(() {
              inventoryDropdown=json.decode(response);
              horses_loaded=true;
              for(int i=0;i<inventoryDropdown['inventoryDropDown'].length;i++){
                inventoryItem.add(inventoryDropdown['inventoryDropDown'][i]['name']);
                print(inventoryDropdown);
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
                            attribute: "item",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Select Item"),
                            items: inventoryItem.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Inventory Items",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onSaved: (value){
                              setState(() {
                                this.selected_items=value;
                                selected_item_id= inventoryItem.indexOf(value);
                              });
                            },
                            onChanged: (value){
                              setState(() {
                                this.selected_items=value;
                                selected_item_id= inventoryItem.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Visibility(
                          visible: horses_loaded,
                          child: FormBuilderDropdown(
                            attribute: "category",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Select "),
                            items: category.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Category",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onSaved: (value){
                              setState(() {
                                this.selected_category=value;
                                selected_category_id= category.indexOf(value)+1;
                              });
                            },
                            onChanged: (value){
                              setState(() {
                                this.selected_category=value;
                                selected_category_id= category.indexOf(value)+1;
                              });
                            },
                          ),
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          attribute: "cost",
                          controller: cost,
                          decoration: InputDecoration(labelText: "CostperUnit",
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
                add_note_button(fbKey: _fbKey,token: token,selected_item_id: selected_item_id,selected_category_id: selected_category_id,cost: cost,inventoryDropdown: inventoryDropdown,)
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
     this.token,
     this.selected_item_id,
    this.selected_category_id,
    this.cost,
    this.inventoryDropdown,
     GlobalKey<FormBuilderState> fbKey,

  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final TextEditingController cost;
  final  inventoryDropdown;
  final int selected_item_id,selected_category_id;
  final GlobalKey<FormBuilderState> _fbKey;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: Colors.teal,
        onPressed: (){
          print(inventoryDropdown['inventoryDropDown'][selected_item_id]['id']);
          print(selected_category_id);
          print(1);
          Utils.check_connectivity().then((result){
            if(result){
              if(_fbKey.currentState.validate()){
                _fbKey.currentState.save();
                DietServices.inventoryProductSave(null, token, 0,inventoryDropdown['inventoryDropDown'][selected_item_id]['id'], selected_category_id,cost.text).then((response){
                  if(response!=null){
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Diet Added Sucessfully"),
                    ));
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Diet not Added"),
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
        child: Text("Add Diet",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}