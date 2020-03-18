import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Barns/barn_json.dart';
import 'dart:convert';

import 'package:horse_management/HMS/Configuration/PerformanceType/performancetype_json.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class update_performancetype extends StatefulWidget{
  final token;
  var specifictype;
  update_performancetype(this.token, this.specifictype);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_performancetype(token, specifictype);
  }

}
class _update_performancetype extends State<update_performancetype>{
  final token;
  var specifictype;
  _update_performancetype(this.token,this.specifictype);
  TextEditingController type;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.type=TextEditingController();
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
        appBar: AppBar(title: Text("Add Cost Center"),),
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
                          controller: type,
                          attribute: "Performance Type",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Performance Type",
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
                                PerformanceTypesServices.addPerformanceType(token,specifictype['performanceId'],type.text,specifictype['createdBy']).then((respons){
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