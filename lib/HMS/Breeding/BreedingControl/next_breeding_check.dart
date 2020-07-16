import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';

class next_breeding_check extends StatefulWidget{
  String token;
 int nextchexkId;
  next_breeding_check(this.token,this.nextchexkId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _next_breeding_check(token,nextchexkId);
  }

}
class _next_breeding_check extends State<next_breeding_check>{
  DateTime date;
  var breeding_control_list;
  String token;
  int nextchexkId;
  _next_breeding_check(this.token, this.nextchexkId);
  TextEditingController comments;
  String selected_reason;
  int selected_reason_id =0;
  List<String> reason_list=['Follicle Scan','Routine'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comments=TextEditingController();
  }
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Next Breeding Check"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16,top:16),
                        child:FormBuilderDateTimePicker(
                          attribute: "Next Check",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            setState(() {
                              this.date=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Reason",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Reason"),
                          items: reason_list.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onChanged: (value){
                            setState(() {
                              this.selected_reason=value;
                              this.selected_reason_id=reason_list.indexOf(value)+1;
                            });
                          },
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Reason",
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
                    ],
                  ),
                ),
                Center(
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
                                  network_operations.save_next_breeding_check(token, nextchexkId, true, date, selected_reason_id, comments.text, null)
                                      .then((respons){
                                    pd.dismiss();
                                    setState(() {
                                      var parsedjson  = jsonDecode(respons);
                                      if(parsedjson != null){
                                        if(parsedjson['isSuccess'] == true){
                                          print("Successfully data Saved");
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
                        )
                    )
                )            ],
            )
          ],
        ),
      ),
    );
  }

}
