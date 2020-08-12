import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Colors/colors_json.dart';
import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';


class update_color extends StatefulWidget{
  final token;
  var specificColor;
  update_color(this.token, this.specificColor);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_color(token, specificColor);
  }

}
class _update_color extends State<update_color>{
  final token;
  var specificColor;
  _update_color(this.token,this.specificColor);
  TextEditingController color_name,abbreviation;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.color_name=TextEditingController();
    this.abbreviation=TextEditingController();
    setState(() {
      if(specificColor['name']!=null){
        color_name.text=specificColor['name'];
      }
      if(specificColor['abbrivation']!=null){
        abbreviation.text=specificColor['abbrivation'];
      }
    });
    // local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        FlushesServicesJson.flushesdropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              flushes_response=json.decode(response);
//              for(int i=0;i<flushes_response['horseDropDown'].length;i++)
//                horse_name.add(flushes_response['horseDropDown'][i]['name']);
//              for(int i=0;i<flushes_response['vetDropDown'].length;i++)
//                vet.add(flushes_response['vetDropDown'][i]['name']);
//              flushes_loaded=true;
//              update_flushes_visibility=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Color"),),
        body:  Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    //autovalidate: true,
                    child: Column(children: <Widget>[
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          //keyboardType: TextInputType.number,
                          controller: color_name,
                          attribute: "Color Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Color Name",
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
                          //keyboardType: TextInputType.number,
                          controller: abbreviation,
                          attribute: "Abbreviation",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Abbreviation",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Builder(
                          builder:(BuildContext context){
                            return Center(
                                child:Padding(
                                    padding: const EdgeInsets.all(16),
                                    child:MaterialButton(
                                      color: Colors.teal,
                                      child: Text("Update",style: TextStyle(color: Colors.white),),
                                      onPressed: (){
                                        if (_fbKey.currentState.validate()) {
                                          _fbKey.currentState.save();
                                          Utils.check_connectivity().then((result){
                                            if(result){
                                              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                              pd.show();
                                              ColorsServices.addColor(token,specificColor['id'],color_name.text,abbreviation.text,specificColor['createdBy'],).then((respons){
                                                pd.dismiss();
                                                if(respons!=null){
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Color Updated Successfully",
                                                      style: TextStyle(
                                                          color: Colors.red
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.green,
                                                  ));
                                                  Navigator.pop(context);
                                                }else{
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Color Updated Failed",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ));
                                                }
                                              });
                                            }
                                          });
                                        }
                                      },

                                    )
                                )
                            );
                          }

                      ),
//                      MaterialButton(
//                        onPressed: (){
//                          if (_fbKey.currentState.validate()) {
//                            _fbKey.currentState.save();
//                            Utils.check_connectivity().then((result){
//                              if(result){
//                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
//                                pd.show();
//                                ColorsServices.addColor(token,specificColor['id'],color_name.text,abbreviation.text,specificColor['createdBy'],).then((respons){
//                                  pd.dismiss();
//                                  if(respons!=null){
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Color Updated"),
//                                      backgroundColor: Colors.green,
//                                    ));
//                                    Navigator.pop(context);
//                                  }else{
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Color not Updated"),
//                                      backgroundColor: Colors.red,
//                                    ));
//                                  }
//                                });
//                              }
//                            });
//                          }
//                        },
//                        child: Text("Update",style: TextStyle(color: Colors.white),
//                        ),
//                        color: Colors.teal,
//                      ),
                    ],
                    ),
                  ),
                ]
            ),
          ),
        ));

  }

}