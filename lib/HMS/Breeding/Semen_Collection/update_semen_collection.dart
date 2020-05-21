import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';

import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class update_semen_collection extends StatefulWidget{
  String token;
  var semen_collection_data;
  update_semen_collection(this.token,this.semen_collection_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_semen_collection_state(token,semen_collection_data);
  }

}
class _update_semen_collection_state extends State<update_semen_collection>{
  String token;
   var semen_collection_data;
  _update_semen_collection_state(this.token,this.semen_collection_data);
  DateTime selected_date,hour;
  List<String> horses=[],incharge=[];
  bool horses_loaded=false,incharge_loaded=false;
  String selected_horse,selected_incharge;
  int selected_horse_id,selected_incharge_id;
  bool toFreeze;
  var semen_collection_list;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController extracted_volume,concentration,general,progressive,comments;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    extracted_volume=TextEditingController();
    concentration=TextEditingController();
    general=TextEditingController();
    progressive=TextEditingController();
    comments=TextEditingController();
    setState(() {
      if(semen_collection_data['comments']!=null){
       comments.text=semen_collection_data['comments'];
      }
      if(semen_collection_data['generalMotility']!=null){
        general.text=semen_collection_data['generalMotility'].toString();
      }
      if(semen_collection_data['progressiveMotility']!=null){
        progressive.text=semen_collection_data['progressiveMotility'].toString();
      }
      if(semen_collection_data['extractedVolume']!=null){
        extracted_volume.text=semen_collection_data['extractedVolume'].toString();
      }
      if(semen_collection_data['concentration']!=null){
        concentration.text=semen_collection_data['concentration'].toString();
      }

    });
    network_operations.get_semen_collection_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          semen_collection_list=json.decode(response);
          horses_loaded=true;
          incharge_loaded=true;
          for(int i=0;i<semen_collection_list['horseDropDown'].length;i++){
            horses.add(semen_collection_list['horseDropDown'][i]['name']);
          }
          for(int i=0;i<semen_collection_list['inChargeDropDown'].length;i++){
            incharge.add(semen_collection_list['inChargeDropDown'][i]['name']);
          }
        });
      }else{
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Update Semen Collection"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                      child: Visibility(
                       // visible: horses_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          initialValue: semen_collection_data['horseName']['name'],
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items:horses!=null?horses.map((horse)=>DropdownMenuItem(
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
                          onSaved: (value){
                            setState(() {
                              this.selected_horse=value;
                              this.selected_horse_id=horses.indexOf(value);
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              this.selected_horse=value;
                              this.selected_horse_id=horses.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child:FormBuilderDateTimePicker(
                        attribute: "Date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        initialValue: semen_collection_data['date']!=null?DateTime.parse(semen_collection_data['date']):null,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("MM-dd-yyyy"),
                        decoration: InputDecoration(labelText: "Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                        onSaved: (value){
                          setState(() {
                            this.selected_date=value;
                          });
                        },
                        onChanged: (value){
                          setState(() {
                            this.selected_date=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child:FormBuilderDateTimePicker(
                        attribute: "Hour",
                       // initialValue: semen_collection_data['hour']!=null?DateTime.parse(semen_collection_data['hour']):null,
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.time,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("hh:mm:ss"),
                        decoration: InputDecoration(labelText: "Hour",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                        onSaved: (value){
                          setState(() {
                            this.hour=value;
                          });
                        },
                        onChanged: (value){
                          setState(() {
                            this.hour=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                      child: Visibility(
                        visible: true,
                        child: FormBuilderDropdown(
                          attribute: "To Freeze",
                          initialValue: get_yesno(semen_collection_data['toFreeze']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("To Freeze"),
                          items:['Yes','No'].map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "To Freeze",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                toFreeze=true;
                              }else{
                                toFreeze=false;
                              }
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              if(value=="Yes"){
                                toFreeze=true;
                              }else{
                                toFreeze=false;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                      child: Visibility(
                        //visible: incharge_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Incharge",
                          initialValue: semen_collection_data['inChargeName']['contactName']['name'],
                         // initialValue: semen_collection_data['contactName']!=null?semen_collection_data['contactName']['name']:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Incharge"),
                          items:incharge!=null?incharge.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Incharge",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onSaved: (value){
                            setState(() {
                              this.selected_incharge=value;
                              this.selected_incharge_id=incharge.indexOf(value);
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              this.selected_incharge=value;
                              this.selected_incharge_id=incharge.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderTextField(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text("Semen Evaluation",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: extracted_volume,
                        attribute: "Extracted volume",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Extracted volume",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: concentration,
                        attribute: "Concentration",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Concentration",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: general,
                        attribute: "General motility",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "General motility",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: progressive,
                        attribute: "Progressive motility",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Progressive motility",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: update_semen_stock_button(semen_collection_data:semen_collection_data,fbKey: _fbKey, token: token, selected_date: selected_date, selected_horse: selected_horse, semen_collection_list: semen_collection_list, selected_horse_id: selected_horse_id, toFreeze: toFreeze, selected_incharge_id: selected_incharge_id, comments: comments, extracted_volume: extracted_volume, concentration: concentration, general: general, progressive: progressive, selected_incharge: selected_incharge),
                ),
              ),
            ],
          )
        ],
      ),

    );
  }

}

class update_semen_stock_button extends StatelessWidget {
  const update_semen_stock_button({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.token,
    @required this.selected_date,
    @required this.selected_horse,
    @required this.semen_collection_list,
    @required this.selected_horse_id,
    @required this.toFreeze,
    @required this.selected_incharge_id,
    @required this.comments,
    @required this.extracted_volume,
    @required this.concentration,
    @required this.general,
    @required this.progressive,
    @required this.selected_incharge,
    @required this.semen_collection_data,
  }) : _fbKey = fbKey, super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;
  final String token;
  final DateTime selected_date;
  final String selected_horse;
  final  semen_collection_list;
  final int selected_horse_id;
  final bool toFreeze;
  final semen_collection_data;
  final int selected_incharge_id;
  final TextEditingController comments;
  final TextEditingController extracted_volume;
  final TextEditingController concentration;
  final TextEditingController general;
  final TextEditingController progressive;
  final String selected_incharge;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        if (_fbKey.currentState.validate()) {
          _fbKey.currentState.save();
          Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
              pd.show();
              network_operations.add_semen_collection(token, semen_collection_data['semenCollectionId'], selected_date, selected_horse, semen_collection_list['horseDropDown'][selected_horse_id]['id'],semen_collection_data['createdBy'], toFreeze, semen_collection_list['inChargeDropDown'][selected_incharge_id]['id'], comments.text,int.parse(extracted_volume.text) ,int.parse(concentration.text) , int.parse(general.text),int.parse(progressive.text), selected_incharge,selected_incharge).then((respons){
                pd.dismiss();
                if(respons!=null){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Updated"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Not Updated"),
                    backgroundColor: Colors.red,
                  ));
                }
              });
            }
          });
        }
      },
      child: Text("Update",style: TextStyle(color: Colors.white),),
    );
  }
}