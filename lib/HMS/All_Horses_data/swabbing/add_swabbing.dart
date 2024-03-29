import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:horse_management/HMS/All_Horses_data/services/swabbing_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MainPageState extends StatelessWidget {
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Colors.grey,
        appBar: new AppBar(
          title: const Text("Zyz"),
        ),
        body: new Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return new Center(
            child: new MaterialButton(onPressed: (){

              createSnackBar("cxx",context);

            },child: Text("abbbbb"),),
          );
        }));

  }


 static void createSnackBar(String message ,BuildContext context) {
    final snackBar = new SnackBar(content: new Text(message),duration: Duration(seconds: 5),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }
}


















class add_swabbing extends StatefulWidget{
  String token;

  add_swabbing (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(token);
  }

}
class _state_add_farrier extends State<add_swabbing>{
  int selected_horse_id;
  List<String> horse=[];
  String selected_horse;
  DateTime swabbing_date = DateTime.now();
  DateTime treatment_date = DateTime.now();
  TextEditingController antibiotic,result,amount,comment;
  String token;
  var swabbingdropdown;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  _state_add_farrier (this.token);

  @override
  void initState() {
    antibiotic= TextEditingController();
    result= TextEditingController();
    amount= TextEditingController();
    comment= TextEditingController();



    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        swabbing_services.swabbing_Dropdown(token).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              swabbingdropdown=json.decode(response);
              for(int i=0;i<swabbingdropdown['horsesDropDown'].length;i++){
                horse.add(swabbingdropdown['horsesDropDown'][i]['name']);
              }
            });
          }else{
          }
        });
      }else
       Flushbar(message: "Network Error",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Swabbing"),),
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
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
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: antibiotic,
                          attribute: "city",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Antibiotic",
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
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);


                            print(token);print(swabbingdropdown['horseDropDown'][selected_horse_id]['id']);
                            print(comment.text);
                            print(int.parse(amount.text));
                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            swabbing_services.swabbingSave(null,token,0, swabbingdropdown['horseDropDown'][selected_horse_id]['id'],swabbing_date,treatment_date,antibiotic.text,result.text,amount.text,comment.text).then((response){

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
                        child:Text("Add Swabbing",style: TextStyle(color: Colors.white),),
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



