import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_json.dart';
import 'dart:convert';


class update_sire extends StatefulWidget{
  final token;
  var specificSire;
  update_sire(this.token, this.specificSire);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_sire(token, specificSire);
  }

}
class _update_sire extends State<update_sire>{
  final token;
  var specificSire;
  _update_sire(this.token,this.specificSire);
  TextEditingController sire;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.sire=TextEditingController();
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
                          controller: sire,
                          attribute: "Sire",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Sire",
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
                            SireServices.addSire(token,specificSire['horseId'],sire.text,specificSire['createdBy']).then((response){
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