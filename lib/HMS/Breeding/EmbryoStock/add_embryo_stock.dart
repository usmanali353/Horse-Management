
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/Training.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'embryo_stock_json.dart';

class add_embryo_stock extends StatefulWidget{
  String token;

  add_embryo_stock(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_embryo_stock(token);
  }
}



class _add_embryo_stock extends State<add_embryo_stock>{
  String token;
  _add_embryo_stock(this.token);
  String ddvalue,selected_horse,selected_tank, selected_sire, selected_gender, select_on_sale;
  DateTime Collection_date = DateTime.now();
  int selected_horse_id=0,selected_tank_id=0,selected_sire_id=0,selected_gender_id;
      bool selected_on_sale_id;
 // sqlite_helper local_db;

  List<String> horses=[],tanks=[],sire=[],gender=['Male', 'Female','Geilding'], on_sale=['Yes','No'];
  var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController price,grade,stage,status,comments;
  bool _isvisible=false;
  bool stocks_loaded=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.price=TextEditingController();
    this.grade=TextEditingController();
    this.stage=TextEditingController();
    this.status=TextEditingController();
    this.comments=TextEditingController();
   // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        EmbryoStockServices.get_embryo_stock_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              stock_response=json.decode(response);
              for(int i=0;i<stock_response['horseDropDown'].length;i++)
                horses.add(stock_response['horseDropDown'][i]['name']);
              for(int i=0;i<stock_response['tankDropDown'].length;i++)
                tanks.add(stock_response['tankDropDown'][i]['name']);
              for(int i=0;i<stock_response['sireDropDown'].length;i++)
                sire.add(stock_response['sireDropDown'][i]['name']);
             stocks_loaded=true;
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
        appBar: AppBar(title: Text("Add Embryo Stock"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                        child: Visibility(
                          visible: stocks_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Horse",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Horse"),
                            items:horses!=null?horses.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
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
                                this.selected_horse_id=horses.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Tanks",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Tanks"),
                          items: tanks!=null?tanks.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Tanks",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_tank=value;
                              this.selected_tank_id=tanks.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Sire",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Sire"),
                          items: sire!=null?sire.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Sire",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_sire=value;
                              this.selected_sire_id=sire.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Gender",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Gender"),
                          items: gender!=null?gender.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Gender",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              if(value == "Male")
                              selected_gender_id = 1;
                              else if(value == "Female")
                                selected_gender_id = 2;
                              else if(value == "Geilding")
                                selected_gender_id = 3;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "Collection Date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Collection Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            setState(() {
                              this.Collection_date=value;
                            });
                          },
                        ),
                      ),
                      

                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "On Sale",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("On Sale"),
                          items: on_sale!=null?on_sale.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "On Sale",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              if(value == "Yes")
                                selected_on_sale_id = true;
                              else if(value == "No")
                                selected_on_sale_id = false;
                            });
                          },
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          controller: price,
                          attribute: "Price",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Price",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: Text("Embryo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          controller: grade,
                          attribute: "Grade",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Grade",
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
                          controller: stage,
                          attribute: "Stage",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Stage",
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
                          controller: status,
                          attribute: "Status",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Status",
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
                          controller: comments,
                          attribute: "Comments",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Comments",
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
                      child:MaterialButton(
                        color: Colors.teal,
                        child: Text("Save",style: TextStyle(color: Colors.white),),

                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                EmbryoStockServices.add_embryo_stock(null, token, 0, stock_response['horseDropDown'][selected_horse_id]['id'], stock_response['tankDropDown'][selected_tank_id]['id'], stock_response['sireDropDown'][selected_sire_id]['id'], selected_gender_id, Collection_date,selected_on_sale_id, price.text, grade.text, stage.text, status.text, comments.text).then((response){
                                  pd.dismiss();
                                  setState(() {
                                    var parsedjson  = jsonDecode(response);
                                    if(parsedjson != null){
                                      if(parsedjson['isSuccess'] == true){
                                        print("Successfully data saved");
                                      }else
                                        print("not saved");
                                    }else
                                      print("json response null");
                                  });
                                });
                              }
                            });

                          }
                        },

                      )
                    )
                )
              ],
            )
          ]
        )
    );
  }

}

//class add_stock_button extends StatelessWidget {
//  const add_stock_button({
//    Key key,
//    @required GlobalKey<FormBuilderState> fbKey,
//    @required this.ddvalue,
//    @required this.selected_horse,
//    @required this.selected_tank,
//    @required this.selected_sire,
//    @required this.selected_gender,
//    @required this.collection_date,
//    @required this.selected_on_sale,
//    @required this.price,
//    @required this.grade,
//    @required this.stage,
//    @required this.status,
//    @required this.comments,
//    @required this.selected_horse_id,
//    @required this.selected_tank_id,
//    @required this.selected_sire_id,
//    @required this.selected_gender_id,
//  }) : _fbKey = fbKey, super(key: key);
//  final int selected_horse_id;
//  final int selected_tank_id;
//  final int selected_sire_id;
//  final int selected_gender_id;
//  final int selected_on_sale;
//  final String token;
//  final GlobalKey<FormBuilderState> _fbKey;
//
//  final String ddvalue;
//  final String selected_horse;
//  final String selected_tank;
//  final String selected_sire;
//  final String selected_gender;
//  final DateTime collection_date;
//  final int selects_on_sale;
//  final TextEditingController price, grade,stage,status,comments;
//  
//  @override
//  Widget build(BuildContext context) {
//    return MaterialButton(
//      color: Colors.teal,
//      onPressed: () {
//        if (_fbKey.currentState.validate()) {
//          Utils.check_connectivity().then((result){
//            if(result){
//              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
//              pd.show();
//              network_operations.add_training(0,selected_horse.toString(),Start_date, End_Date,training_response['horses'][selected_horse_id]['id'], training_center.text, target_date, target_competition.text,token,training_response['trainerDropDown'][selected_trainer_id]['id'],selected_horse,training_response['trainingPlans'][selected_excercise_plan]['id']!=null?training_response['trainingPlans'][selected_excercise_plan]['id']:null,selected_trainer!=null?selected_trainer:'',excerciseplan!=null?excerciseplan:null,'').then((response){
//                pd.dismiss();
//                print(response);
//                if(response!=null) {
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                    backgroundColor: Colors.green,
//                    content: Text("Training Added Sucessfully"),
//                  ));
//                }else{
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                    backgroundColor: Colors.red,
//                    content: Text("Training not Added"),
//                  ));
//                }
//              });
//            }else{
//              Scaffold.of(context).showSnackBar(SnackBar(
//                backgroundColor: Colors.red,
//                content: Text("Network not Available"),
//              ));
//              // local_db.create_training(Training(selected_horse,selected_trainer,'',training_center.text,Start_date.toString(),End_Date.toString(),target_date.toString(),excerciseplan,));
//            }
//          });
//
//        }
//      },
//      child:Text("Add Training",style: TextStyle(color: Colors.white),),
//    );
//  }
//}