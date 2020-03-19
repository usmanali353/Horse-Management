import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Tanks/tanks_json.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Utils.dart';

class update_tanks_form extends StatefulWidget{
  final token;
  var specifictank;
  update_tanks_form(this.token, this.specifictank);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_tanks_form(token, specifictank);
  }

}
class _update_tanks_form extends State<update_tanks_form>{
  final token;
  var specifictank;
  _update_tanks_form(this.token,this.specifictank);
  String selected_tanks;

  DateTime lastfill_date = DateTime.now();
  DateTime nextfill_date = DateTime.now();
  DateTime policydue_date = DateTime.now();
  int selected_tanks_id=0;

  List<String> tanks=[];
  var tanks_response;
  TextEditingController name, capacity,policynumber;


  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool _isvisible=false;
  //bool notes_loaded=false;
  bool update_notes_visibility;
  var location_name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.name=TextEditingController();
    this.capacity=TextEditingController();
    this.policynumber=TextEditingController();
    setState(() {
      if(specifictank['name']!=null){
        name.text=specifictank['name'];
      }
      if(specifictank['capacity']!=null){
        capacity.text=specifictank['capacity'].toString();
      }
      if(specifictank['insurancePolicy']!=null){
        policynumber.text=specifictank['insurancePolicy'];
      }
    });
    TanksServices.get_Tanks_dropdowns(token).then((response){
      if(response!=null) {
        setState(() {
          tanks_response=json.decode(response);
              for(int i=0;i<tanks_response['locationDropDown'].length;i++) {
                tanks.add(tanks_response['locationDropDown'][i]['name']);
              }
//              //notes_loaded=true;
//              update_notes_visibility=true;
        });
      }});
  }
  String get_location_by_id(int id){
    var location_name;
    if(specifictank!=null&&tanks_response['locationDropDown']!=null&&id!=null){
      for(int i=0;i<tanks.length;i++){
        if(tanks_response['locationDropDown'][i]['id']==id){
          location_name=tanks_response['locationDropDown'][i]['name'];
        }
      }
      return location_name;
    }else
      return null;
  }

//  @override
//  void initState() {
//    this.name=TextEditingController();
//    this.capacity=TextEditingController();
//    this.policynumber=TextEditingController();
//    // local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        TanksServices.get_Tanks_dropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              tanks_response=json.decode(response);
//              for(int i=0;i<tanks_response['locationDropDown'].length;i++)
//                tanks.add(tanks_response['locationDropDown'][i]['name']);
//              //notes_loaded=true;
//              update_notes_visibility=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });
//  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Update Tanks"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,

               // autovalidate: true,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: name,
                      attribute: "Tanks Name",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Tanks Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      //visible: sale_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Location",
                        initialValue: get_location_by_id(specifictank['locationId'])!= null ?get_location_by_id(specifictank['locationId']):null,
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Location"),
                        items:tanks!=null?tanks.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Location",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_tanks=value;
                            this.selected_tanks_id=tanks.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: capacity,
                      attribute: "Capacity",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Capacity",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      initialValue: specifictank['lastFill']!=null?DateTime.parse(specifictank['lastFill']):null,
                      onChanged: (value){
                        this.lastfill_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "LastFill Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      initialValue: specifictank['nextFill']!=null?DateTime.parse(specifictank['nextFill']):null,
                      onChanged: (value){
                        this.nextfill_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "NextFill Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
                      controller: policynumber,
                      attribute: "Insurance Policy #",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Insurance Policy #",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      initialValue: specifictank['insurancePolicyDueDate']!=null?DateTime.parse(specifictank['insurancePolicyDueDate']):null,
                      onChanged: (value){
                        this.policydue_date=value;
                      },
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Insurance Policy Due Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
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
                            TanksServices.add_Tanks(specifictank['createdBy'],token,specifictank['id'],name.text,tanks_response['locationDropDown'][selected_tanks_id]['locationId'], capacity.text,lastfill_date,nextfill_date,policynumber.text,policydue_date)
                                .then((respons){
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

            ],
          ),
        ),

      ),
    );

  }
}