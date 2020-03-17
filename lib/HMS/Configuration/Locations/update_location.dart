import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/CostCenters/costcenter_json.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';

import '../../../Utils.dart';
import 'location_json.dart';



class update_location extends StatefulWidget{
  final token;
  var specificlocation;
  update_location(this.token, this.specificlocation);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_location(token, specificlocation);
  }

}
class _update_location extends State<update_location>{
  final token;
  var specificlocation;
  _update_location(this.token,this.specificlocation);
  TextEditingController location_name,description;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.location_name=TextEditingController();
    this.description=TextEditingController();
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
        appBar: AppBar(title: Text("Update Location"),),
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
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          //keyboardType: TextInputType.number,
                          controller: location_name,
                          attribute: "Location Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Location Name",
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
                      MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                LocationServices.addLocation(token,specificlocation['id'],location_name.text,description.text,specificlocation['createdBy']).then((respons){
                                  pd.dismiss();
                                  if(respons!=null){
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Updated "),
//                                      backgroundColor: Colors.green,
//                                    ));
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Not Updated "),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              }
                            });
                          }
                        },
                        child: Text("Update",style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.teal,
                      ),
                    ],
                    ),
                  ),
                ]
            ),
          ),
        ));

  }

}