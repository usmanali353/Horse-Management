import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:horse_management/HMS/All_Horses_data/services/swabbing_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class update_swabbing extends StatefulWidget{
  String token;
  var swabinglist;
  update_swabbing (this.swabinglist,this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(swabinglist,token);
  }

}
class _state_add_farrier extends State<update_swabbing>{
  var swabinglist;
  int selected_horse_id;
  List<String> horse=[];
  String selected_horse;
  DateTime swabbing_date = DateTime.now();
  DateTime treatment_date = DateTime.now();
  TextEditingController antibiotic,result,amount,comment;
  String token;
  var swabbingdropdown;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  _state_add_farrier (this.swabinglist,this.token);

  @override
  void initState() {
    antibiotic= TextEditingController();
    result= TextEditingController();
    amount= TextEditingController();
    comment= TextEditingController();
   setState(() {
     antibiotic.text =swabinglist['antibiotic'];
     result.text = swabinglist['result'].toString();
     amount.text = swabinglist['amount'].toString();
     comment.text = swabinglist['comments'].toString();
   });

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        swabbing_services.swabbing_Dropdown(token).then((response){
          pd.dismiss();
          setState(() {
            print(response);
            swabbingdropdown=json.decode(response);
            for(int i=0;i<swabbingdropdown['horsesDropDown'].length;i++)
              horse.add(swabbingdropdown['horsesDropDown'][i]['name']);

          });
        });
      }else
        Flushbar(message: "Network Error",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);
    });
//        swabbing_services.swabbing_Dropdown(token).then((response){
//          setState(() {
//            print(response);
//            swabbingdropdown=json.decode(response);
//            for(int i=0;i<swabbingdropdown['horsesDropDown'].length;i++)
//              horse.add(swabbingdropdown['horsesDropDown'][i]['name']);
//          });
//        });
        print(horse.length.toString());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Swabbing"),),
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
                          initialValue: swabinglist['horseId']!= null?swabinglist['horseName']['name']:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
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
                          initialValue: DateTime.parse(swabinglist['swabbingDate']!= null ? swabinglist['swabbingDate']:DateTime.now()),
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Swabbing Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.swabbing_date=value;
                          },
                          onSaved: (value){
                            this.swabbing_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          initialValue: DateTime.parse(swabinglist['dateOfTreatment']!= null ? swabinglist['dateOfTreatment']:DateTime.now()),
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Treatment Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            this.treatment_date=value;
                          },
                          onSaved: (value){
                            this.treatment_date=value;
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: antibiotic,
                          attribute: "city",
                          validators: [FormBuilderValidators.required()],
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
                          controller: amount,
                          attribute: "amount",
                          decoration: InputDecoration(labelText: "Amount",
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
                        child: TextFormField(
                          controller: comment,
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                              hintText: "Add Comment",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))
                          ),
                          keyboardType: TextInputType.multiline,
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
                          print(swabbingdropdown['horsesDropDown']);
                          print(horse);
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                            _fbKey.currentState.save();


                            print(token);print(swabbingdropdown['horsesDropDown'][selected_horse_id]['id']);
                            print(comment.text);
                            print(int.parse(amount.text));
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            swabbing_services.swabbingSave(swabinglist['createdBy'],token,swabinglist['swabbingId'], swabbingdropdown['horseDropDown'][selected_horse_id]['id'],swabbing_date,treatment_date,antibiotic.text,result.text,amount.text,comment.text).then((response){

                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "Added Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);}
                                else{
                                  Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not Added",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                            });
                          }
                        },
                        child:Text("Update",style: TextStyle(color: Colors.white),),
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