import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/addProductsApplied.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils.dart';

class addVetVisits extends StatefulWidget{
  String token;

  addVetVisits(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addVetVisitsState(token);
  }

}
class addVetVisitsState extends State<addVetVisits>{
  String token;

  addVetVisitsState(this.token);

  DateTime date=DateTime.now();
  bool horses_loaded=false,vet_loaded=false,responsible_loaded=false;
  List<String> horses=[],vet=[],type=['Emergency','Routine','Mornitoring'],responsible=[];
  String selected_horse,selected_vet,selected_type,selected_responsible;
  int selected_horse_id,selected_vet_id,selected_type_id,selected_responsible_id;
  var vetVisitsDropdowns;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        vieterniaryServices.getVetVisitsDropDowns(token).then((response){
          pd.hide();
          if(response!=null){
            setState(() {
              vetVisitsDropdowns=json.decode(response);
              if(vetVisitsDropdowns['horseDropDown']!=null&&vetVisitsDropdowns['horseDropDown'].length>0){
                for(int i=0;i<vetVisitsDropdowns['horseDropDown'].length;i++){
                  horses.add(vetVisitsDropdowns['horseDropDown'][i]['name']);
                }
                horses_loaded=true;
              }
              if(vetVisitsDropdowns['responsibleDropDown']!=null&&vetVisitsDropdowns['responsibleDropDown'].length>0){
                for(int i=0;i<vetVisitsDropdowns['responsibleDropDown'].length;i++){
                  responsible.add(vetVisitsDropdowns['responsibleDropDown'][i]['name']);
                }
                responsible_loaded=true;
              }
              if(vetVisitsDropdowns['vetDropDown']!=null&&vetVisitsDropdowns['vetDropDown'].length>0){
                for(int i=0;i<vetVisitsDropdowns['vetDropDown'].length;i++){
                  vet.add(vetVisitsDropdowns['vetDropDown'][i]['name']);
                }
                vet_loaded=true;
              }
            });

          }
        });
      }else{

      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Vet Visits"),),
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
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
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
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          //visible: horses_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Horse",
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
                        padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderDropdown(
                          attribute: "Type",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Type"),
                          items:type!=null?type.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_type=value;
                              this.selected_type_id=type.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          //  visible: vet_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Vet",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Vet"),
                            items:vet!=null?vet.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          visible: responsible_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Responsible",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Responsible"),
                            items:responsible!=null?responsible.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Responsible",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_responsible=value;
                                this.selected_responsible_id=vet.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: MaterialButton(
                      onPressed: () async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        if(_fbKey.currentState.validate()){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductsApplied(prefs.getString("token"),date,selected_horse_id,selected_vet_id,selected_type_id,vetVisitsDropdowns['vetVisitProduct']['inventoryProductsDropDown'],selected_responsible_id)));
                        }
                      },
                      child: Text("Add Products Applied",style: TextStyle(color: Colors.white),),
                      color: Colors.teal,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

}