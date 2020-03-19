import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/GeneralCategories/generalcategories_json.dart';
import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';


class update_generalcategory extends StatefulWidget{
  final token;
  var specificcategory;
  update_generalcategory(this.token, this.specificcategory);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_generalcategory(token, specificcategory);
  }

}
class _update_generalcategory extends State<update_generalcategory>{
  final token;
  var specificcategory;
  _update_generalcategory(this.token,this.specificcategory);
  TextEditingController category_name,description;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.category_name=TextEditingController();
    this.description=TextEditingController();
    setState(() {
      if(specificcategory['name']!=null){
        category_name.text=specificcategory['name'];
      }
      if(specificcategory['description']!=null){
        description.text=specificcategory['description'];
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
        appBar: AppBar(title: Text("Update General Category"),),
        body:  Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                   // autovalidate: true,
                    child: Column(children: <Widget>[
//
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          //keyboardType: TextInputType.number,
                          controller: category_name,
                          attribute: "General Category Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "General Category Name",
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
                            _fbKey.currentState.save();
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                GeneralCategoryServices.addGeneralCategory(token,specificcategory['id'],category_name.text,description.text,specificcategory['createdBy'],).then((respons){
                                  pd.dismiss();
                                  setState(() {
                                    var parsedjson  = jsonDecode(respons);
                                    if(parsedjson != null){
                                      if(parsedjson['isSuccess'] == true){
                                        print("Successfully data updated");
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