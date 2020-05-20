import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/HMS/All_Horses_data/services/weight_hieght_services.dart';


class add_weight_and_height extends StatefulWidget{
  String token;

  add_weight_and_height (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_weight_and_height(token);
  }

}
class _add_weight_and_height extends State<add_weight_and_height>{
  String selected_horse,token;int selected_horse_id;

  _add_weight_and_height (this.token);

  List<String> horse=[];
  DateTime Select_date = DateTime.now();
  TextEditingController weight,height,bodyindex,comment;
  var weightHieghtdropdown;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    weight= TextEditingController();
    height= TextEditingController();
    bodyindex= TextEditingController();
    comment= TextEditingController();


    weight_hieght_services.weight_hieghtdropdown(token).then((response){
      setState(() {
        print(response);
        weightHieghtdropdown=json.decode(response);
        for(int i=0;i<weightHieghtdropdown['horseDropDown'].length;i++)
          horse.add(weightHieghtdropdown['horseDropDown'][i]['name']);


      });
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Weight & Hieght"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
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
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });

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
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Start Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.Select_date=value;
                          },
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: weight,
                          attribute: "Weight",
                          decoration: InputDecoration(labelText: "Weight(kg)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: height,
                          attribute: "Height",
                          decoration: InputDecoration(labelText: "Height(cm)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: bodyindex,
                          attribute: "body index",
                          decoration: InputDecoration(labelText: "Body Cond Index",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: comment,
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                              hintText: "Add Comment",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),



                    ],
                  ),
                ),
                Center(
                    child:Padding(
                      padding: const EdgeInsets.all(16),
                      child: addWeightButton(fbKey: _fbKey, token: token, weightHieghtdropdown: weightHieghtdropdown, selected_horse_id: selected_horse_id, Select_date: Select_date, weight: weight, height: height, bodyindex: bodyindex, comment: comment),
                    )
                )
              ],
            )
          ],
        )
    );
  }


}

class addWeightButton extends StatelessWidget {
  const addWeightButton({
    Key key,
     GlobalKey<FormBuilderState> fbKey,
     this.token,
     this.weightHieghtdropdown,
     this.selected_horse_id,
     this.Select_date,
     this.weight,
     this.height,
     this.bodyindex,
     this.comment,
  }) : _fbKey = fbKey, super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;
  final String token;
  final weightHieghtdropdown;
  final int selected_horse_id;
  final DateTime Select_date;
  final TextEditingController weight;
  final TextEditingController height;
  final TextEditingController bodyindex;
  final TextEditingController comment;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        if (_fbKey.currentState.validate()) {
          print(_fbKey.currentState.value);
          ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
          pd.show();

          weight_hieght_services.weight_hieghtSave(null,token, 0,weightHieghtdropdown['horseDropDown'][selected_horse_id]['id'], Select_date,
            weight.text,height.toString(),bodyindex.text,comment.text).then((response){
            pd.dismiss();
            if(response !=null) {
              print("Successfully income  added");
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Successfully Added"),backgroundColor: Colors.green,));
            Navigator.of(context).pop();
            }else{
              print("data not added");
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Failed"),backgroundColor: Colors.red,));
            }
          });




        }
      },
      child:Text("Add",style: TextStyle(color: Colors.white),),
    );
  }
}