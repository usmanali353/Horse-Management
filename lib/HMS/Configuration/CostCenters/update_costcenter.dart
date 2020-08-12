import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/CostCenters/costcenter_json.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';

import '../../../Utils.dart';


class update_costcenter extends StatefulWidget{
  final token;
  var specificCostcenter;
  update_costcenter(this.token, this.specificCostcenter);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_costcenter(token, specificCostcenter);
  }

}
class _update_costcenter extends State<update_costcenter>{
  final token;
  var specificCostcenter;
  _update_costcenter(this.token,this.specificCostcenter);
  TextEditingController costcenter_name,description;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.costcenter_name=TextEditingController();
    this.description=TextEditingController();
    setState(() {
      if(specificCostcenter['name']!=null){
        costcenter_name.text=specificCostcenter['name'];
      }
      if(specificCostcenter['description']!=null){
        description.text=specificCostcenter['description'];
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
        appBar: AppBar(title: Text("Update Cost Center"),),
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
                          controller: costcenter_name,
                          attribute: "Cost Center Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Cost Center Name",
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
                          controller: description,
                          attribute: "Description",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Description",
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
                                              CostCenterServices.addCostCenter(token,specificCostcenter['id'],costcenter_name.text,description.text,specificCostcenter['createdBy'],).then((respons){
                                                pd.dismiss();
                                                if(respons!=null){
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Cost Center Updated Successfully",
                                                      style: TextStyle(
                                                          color: Colors.red
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.green,
                                                  ));
                                                  Navigator.pop(context);
                                                }else{
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Cost Center Updated Failed",
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
//                                CostCenterServices.addCostCenter(token,specificCostcenter['id'],costcenter_name.text,description.text,specificCostcenter['createdBy'],).then((respons){
//                                  pd.dismiss();
//                                  if(respons!=null){
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Cost Center Updated"),
//                                      backgroundColor: Colors.green,
//                                    ));
//                                    Navigator.pop(context);
//                                  }else{
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Cost Center not Updated"),
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