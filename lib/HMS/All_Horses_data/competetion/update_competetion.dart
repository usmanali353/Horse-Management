import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:horse_management/HMS/All_Horses_data/services/competetion_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class update_competetion extends StatefulWidget{
  String token;
  var competetionlist;

  update_competetion (this.competetionlist,this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(competetionlist,token);
  }

}
class _state_add_farrier extends State<update_competetion>{
  int selected_horse_id,selected_performance_id;
  List<String> horse=[];List<String> performance=[];
  String selected_horse,selected_performance;
  DateTime select_date = DateTime.now();
  TextEditingController eventName,city,category,result,rider,judges,comment;
  String token;
  var competetiondropdown,competetionlist;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  _state_add_farrier (this.competetionlist,this.token);

  @override
  void initState() {
    eventName= TextEditingController();city= TextEditingController();
    category= TextEditingController();result= TextEditingController();
    rider= TextEditingController();judges= TextEditingController();
    comment= TextEditingController();

    setState(() {
      eventName.text = competetionlist['eventName'].toString();
      city.text = competetionlist['city'].toString();
      category.text = competetionlist['category'].toString();
      result.text = competetionlist['result'].toString();
      rider.text = competetionlist['rider'].toString();
      judges.text = competetionlist['judges'].toString();
      comment.text = competetionlist['comment'].toString();
    });


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        competetion_services.competetionDropdown(token).then((response){
          pd.dismiss();
          setState(() {
            print(response);
            competetiondropdown=json.decode(response);
            for(int i=0;i<competetiondropdown['horseDropDown'].length;i++)
              horse.add(competetiondropdown['horseDropDown'][i]['name']);
            for(int i=0;i<competetiondropdown['performanceTypeDropDown'].length;i++)
              performance.add(competetiondropdown['performanceTypeDropDown'][i]['name']);

          });
        });
      }else
        Flushbar(message: "Network Error",backgroundColor: Colors.red,duration: Duration(seconds: 3),).show(context);
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Competetion"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          initialValue: competetionlist['horseName']['name'],
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: horse!=null?horse.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Horse",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          initialValue: DateTime.parse(competetionlist['date']!= null ? competetionlist['date']:DateTime.now()),
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Start Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.select_date=value;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "perform",
                          initialValue: competetionlist['performanceId']!=null ? competetionlist['performanceTypeName']['name']:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: performance!=null?performance.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Performance",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              this.selected_performance=value;
                              selected_performance_id=performance.indexOf(value);

                            });
                          },
                          onSaved: (value){
                            setState((){
                              this.selected_performance=value;
                              selected_performance_id=performance.indexOf(value);

                            });
                          },
                        ),

                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: eventName,
                          attribute: "event",
                          decoration: InputDecoration(labelText: "Event Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: city,
                          attribute: "city",
                          decoration: InputDecoration(labelText: "City",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: category,
                          attribute: "Dose",
                          decoration: InputDecoration(labelText: "Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: result,
                          attribute: "result",
                          decoration: InputDecoration(labelText: "Result",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: rider,
                          attribute: "rider",
                          decoration: InputDecoration(labelText: "Rider",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: judges,
                          attribute: "judges",
                          decoration: InputDecoration(labelText: "Judges",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                           keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FormBuilderTextField(
                          controller: comment,
                          attribute: "judges",
                          decoration: InputDecoration(labelText: "Comments",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          //keyboardType: TextInputType.multiline,
                        ),
                      ),



                    ],
                  ),
                ),
                Center(
                    child:Padding(
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                            _fbKey.currentState.save();


                            print(token);print(competetiondropdown['horseDropDown'][selected_horse_id]['id']);
                            print(comment.text);
                             print(judges.text);
                             print( competetiondropdown['performanceTypeDropDown'][selected_performance_id]['id']);
                             print(4);

                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            competetion_services.competetionSave(competetionlist['createdBy'],token,competetionlist['competitionId'], competetiondropdown['horseDropDown'][selected_horse_id]['id'],select_date, competetiondropdown['performanceTypeDropDown'][selected_performance_id]['id'],eventName.text,city.text,category.text,result.text,rider.text,1,comment.text).then((response){
                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "Update Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);}
                                else{
                                  Flushbar(message: "Not Update",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not Update",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                            });








                          }
                        },
                        child:Text("Add Competetion",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }

}