import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/performancetype_json.dart';
import 'dart:convert';



class add_performancetype extends StatefulWidget{
  final token;
  add_performancetype(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_performancetype(token);
  }

}
class _add_performancetype extends State<add_performancetype>{
  final token;
  _add_performancetype(this.token,);
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
        appBar: AppBar(title: Text("Add Barn"),),
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
                            PerformanceTypesServices.addPerformanceType(token,0,type.text,null).then((response){
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
                        },
                        child: Text("Save",style: TextStyle(color: Colors.white),
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