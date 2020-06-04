import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import '../../../Utils.dart';
import 'utils/flushes_services_json.dart';


class flushes_update extends StatefulWidget{
  final token,specificflushing;
  flushes_update(this.token, this.specificflushing);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _flushes_update(token, specificflushing );
  }

}
class _flushes_update extends State<flushes_update>{
  final token;
  var specificflushing;
  _flushes_update(this.token,this.specificflushing);
  String ddvalue,selected_horse, selected_vet, selected_success;
  DateTime Select_date = DateTime.now();
  int selected_horse_id=0, selected_vet_id=0;
  bool selected_success_id;
  List<String> horse_name =[], vet=[], success=['Yes', 'No'];
  var flushes_response;
  TextEditingController embryos,comments;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool flushes_loaded=false;
  bool update_flushes_visibility;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.embryos=TextEditingController();
    this.comments=TextEditingController();
    setState(() {
      if(specificflushing['embryos']!=null){
        embryos.text=specificflushing['embryos'].toString();
      }
      if(specificflushing['comments']!=null){
        comments.text=specificflushing['comments'];
      }

    });
    FlushesServicesJson.flushesdropdowns(token).then((response){
      if(response!=null){
        setState(() {
          flushes_response=json.decode(response);
              for(int i=0;i<flushes_response['horseDropDown'].length;i++)
                horse_name.add(flushes_response['horseDropDown'][i]['name']);
              for(int i=0;i<flushes_response['vetDropDown'].length;i++)
                vet.add(flushes_response['vetDropDown'][i]['name']);
        });
      }
    });
  }
//  String get_vet_by_id(int id){
//    var vet_name;
//    if(specificflushing!=null&&flushes_response['vetDropDown']!=null&&id!=null){
//      for(int i=0;i<vet.length;i++){
//        if(breeddropdown['damDropDown'][i]['id']==id){
//          vet_name=breeddropdown['damDropDown'][i]['name'];
//        }
//      }
//      return vet_name;
//    }else
//      return null;
//  }
  String get_yesno(bool b){
    var yesno;
    if(b!=null){
      if(b){
        yesno="Yes";
      }else {
        yesno = "No";
      }
    }
    return yesno;
  }
//  @override
//  void initState() {
//    this.embryos=TextEditingController();
//    this.comments=TextEditingController();
//    // local_db=sqlite_helper();
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
//
//  }

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Embryo Retrieval"),),
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
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                         // visible: flushes_loaded,
                          child: FormBuilderDropdown(
                            initialValue: specificflushing['horseName']['name'],
                            attribute: "Horse",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Horse"),
                            items:horse_name!=null?horse_name.map((horse)=>DropdownMenuItem(
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
                                this.selected_horse_id=horse_name.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_horse=value;
                                this.selected_horse_id=horse_name.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child:  FormBuilderDateTimePicker(
                          initialValue: specificflushing['date']!=null?DateTime.parse(specificflushing['date']):null,
                          onChanged: (value){
                            setState(() {
                              this.Select_date=value;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.Select_date=value;
                            });
                          },
                          attribute: "date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("dd-MM-yyyy"),
                          decoration: InputDecoration(labelText: "Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Vet",
                          initialValue: specificflushing['vetName']['contactName']['name'],
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Vet"),
                          items: vet!=null?vet.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Vet",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_vet=value;
                              this.selected_vet_id=vet.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_vet=value;
                              this.selected_vet_id=vet.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Success?",
                          initialValue: get_yesno(specificflushing['isSuccess']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Success?"),
                          items: success!=null?success.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Success?",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              if(value == "Yes")
                                selected_success_id = true;
                              else if(value == "No")
                                selected_success_id = false;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              if(value == "Yes")
                                selected_success_id = true;
                              else if(value == "No")
                                selected_success_id = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          controller: embryos,
                          attribute: "Embryos",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Embryos",
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
//
                      MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            _fbKey.currentState.save();
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                FlushesServicesJson.add_flushes(specificflushing['createdBy'],token,specificflushing['id'],flushes_response['horseDropDown'][selected_horse_id]['id'],Select_date, flushes_response['vetDropDown'][selected_vet_id]['id'],selected_success_id,embryos.text, comments.text )
                                    .then((response){
                                 pd.dismiss();
                                 if(response!=null){
                                   Scaffold.of(context).showSnackBar(SnackBar(
                                     content: Text("Flushes Updated"),
                                     backgroundColor: Colors.green,
                                   ));
                                   Navigator.pop(context);
                                 }else{
                                   Scaffold.of(context).showSnackBar(SnackBar(
                                     content: Text("Flushes not Updated"),
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