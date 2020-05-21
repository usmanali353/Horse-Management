import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Breeds/breeds_json.dart';
import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class update_breed extends StatefulWidget{
  final token;
  var specificBreed;
  update_breed(this.token, this.specificBreed);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_breed(token, specificBreed);
  }

}
class _update_breed extends State<update_breed>{
  final token;
  var specificBreed;
  _update_breed(this.token,this.specificBreed);
  TextEditingController breed;
  //int selected_currency_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  @override
  void initState() {
    this.breed=TextEditingController();
    setState(() {
      if(specificBreed['name']!=null){
        breed.text=specificBreed['name'];
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
        appBar: AppBar(title: Text("Update Breed"),),
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
                          controller: breed,
                          attribute: "Breed Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Breed Name",
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
                                      child: Text("Save",style: TextStyle(color: Colors.white),),
                                      onPressed: (){
                                        if (_fbKey.currentState.validate()) {
                                          Utils.check_connectivity().then((result){
                                            if(result){
                                              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                              pd.show();
                                              BreedsServices.addBreed(token,specificBreed['id'],breed.text,specificBreed['createdBy']).then((respons){
                                                pd.dismiss();
                                                if(respons!=null){
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Breed Updated Successfully",
                                                      style: TextStyle(
                                                          color: Colors.red
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.green,
                                                  ));
                                                  Navigator.pop(context);
                                                }else{
                                                  Scaffold.of(context).showSnackBar(SnackBar(
                                                    content: Text("Breed not Updated",
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
//                                BreedsServices.addBreed(token,specificBreed['id'],breed.text,specificBreed['createdBy']).then((respons){
//                                  pd.dismiss();
//                                  if(respons!=null){
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Breed Added"),
//                                      backgroundColor: Colors.green,
//                                    ));
//                                    Navigator.pop(context);
//                                  }else{
//                                    Scaffold.of(context).showSnackBar(SnackBar(
//                                      content: Text("Breed not Added"),
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