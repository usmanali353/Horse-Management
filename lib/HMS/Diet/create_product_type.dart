import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';

import 'diet_services.dart';


class addProductType extends StatefulWidget{
  String token;

  addProductType(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_new_note_state(token);
  }

}
class _add_new_note_state extends State<addProductType>{
  String token;
  DateTime date;
  String  selected_category;
  int selected_category_id;
  var notes_data;
  var notes_dropdowns;
  bool horses_loaded=false;
  List<String> category =['Grain','Supplements','Forage','Rations'];
  TextEditingController name;
  TextEditingController cost;
  TextEditingController unit;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _add_new_note_state(this.token);

  @override
  void initState() {
    super.initState();
    name=TextEditingController();
    cost=TextEditingController();
    unit=TextEditingController();
//    Utils.check_connectivity().then((result){
//      if(result){
//        network_operations.get_notes_dropdown(token).then((response){
//          if(response!=null){
//            setState(() {
//              notes_dropdowns=json.decode(response);
//              horses_loaded=true;
//              for(int i=0;i<notes_dropdowns['horseDropDown'].length;i++){
//                category.add(notes_dropdowns['horseDropDown'][i]['name']);
//              }
//            });
//          }else{
//
//          }
//        });
//      }else{
//
//      }
//    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Create Product Type"),),
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
                        child: FormBuilderDropdown(
                          attribute: "category",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
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

                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          attribute: "name",
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
                          keyboardType: TextInputType.number,
                          attribute: "cost",
                          controller: cost,
                          decoration: InputDecoration(labelText: "Cost",
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
                          keyboardType: TextInputType.number,
                          attribute: "unit",
                          controller: unit,
                          decoration: InputDecoration(labelText: "Unit",
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
                add_note_button(token: token,selected_category_id: selected_category_id,name: name,cost: cost,unit: unit,fbKey: _fbKey,)
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
    this.selected_category_id,
    this.name,
    this.cost,
    this.unit,

    @required GlobalKey<FormBuilderState> fbKey,
  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final TextEditingController name,unit,cost;
  final int selected_category_id;
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
                DietServices.productTypeSave(null, token, 0, selected_category_id, name.text, int.parse(cost.text), int.parse(unit.text)).then((response){
                  if(response!=null){
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("prouct Added Sucessfully"),
                    ));
                    Navigator.of(context).pop();
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("product not Added"),
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
        child: Text("Add Product",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}