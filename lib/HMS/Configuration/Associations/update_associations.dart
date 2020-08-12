import 'package:flutter/material.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Barns/barn_json.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';

import '../../../Utils.dart';
import 'associations_json.dart';


class update_associations extends StatefulWidget{
  final token;
  var specificname;
  update_associations(this.token, this.specificname);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_associations(token, specificname);
  }

}
class _update_associations extends State<update_associations>{
  final token;
  var specificname;
  _update_associations(this.token,this.specificname);
  TextEditingController name;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.name=TextEditingController();
    setState(() {
      if(specificname['name']!=null){
        name.text=specificname['name'];
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
        appBar: AppBar(title: Text("Update Associations"),),
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
                          controller: name,
                          attribute: "Association Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Association Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),


                      Center(
                          child:Padding(
                              padding: const EdgeInsets.all(16),
                              child:Builder(
                                  builder: (BuildContext context){
                                    return  MaterialButton(
                                      color: Colors.teal,
                                      child: Text("Update",style: TextStyle(color: Colors.white),),
                                      onPressed: (){
                                        if (_fbKey.currentState.validate()) {
                                          _fbKey.currentState.save();
                                          Utils.check_connectivity().then((result){
                                            if(result){
                                              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                              pd.show();
                                              AssociationServices.addAssociations(token,specificname['id'],name.text,specificname['createdBy']).then((respons){
                                                pd.dismiss();
                                                if(respons!=null){
                                                  Navigator.pop(context);
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Association Updated Successfully",
                                                      style: TextStyle(
                                                      color: Colors.red
                                                    ),
                                                    ),
                                                    backgroundColor: Colors.green,
                                                  ));
                                                }else{
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Association not Update",
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
                                    );
                                  }

                              )
                          )
                      )
                    ],
                    ),
                  ),
                ]
            ),
          ),
        ));

  }

}