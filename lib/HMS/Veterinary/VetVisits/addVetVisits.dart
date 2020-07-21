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
  List<String> horses=[],vet=[],type=['Emergency','Routine','Mornitoring'],responsible=[],mucus_membrane=['Pink', 'Pale', 'Icetrus', 'Cynotics', 'Congested'],
      Pulse=['Normal', 'Increased', 'Decreased'], Hoof_FL=['Normal', 'Hot', 'Cold'], Hoof_FR=['Normal', 'Hot', 'Cold'], Hoof_RL=['Normal', 'Hot', 'Cold'], Hoof_RR=['Normal', 'Hot', 'Cold'], Movements_L=['Normal', 'Increased', 'Decreased'], Movements_R=['Normal', 'Increased', 'Decreased'],
      Feces_Present=['Yes', 'No'], Feces_Consistency=['Firm', 'Pasty', 'Liquid'], Effort=['Normal', 'Increased', 'Decreased'], Pulmonary_Auscultation=['Normal','Diminished', 'Wheezing', 'Rales'], Trachea_Auscultation=['Air', 'Liquid', 'Stridor'];
  String selected_horse,selected_vet,selected_type,selected_responsible, selected_mucus_membrane, selected_pulse, selected_Hoof_FL, selected_Hoof_FR, selected_Hoof_RL,selected_Hoof_RR, selected_Movements_L, selected_Movements_R,
      selected_Feces_Present, selected_Feces_Consistency, selected_Effort, selected_Pulmonary_Auscultation, selected_Trachea_Auscultation;

  int selected_horse_id, selected_vet_id, selected_type_id, selected_responsible_id, selected_mucus_membrane_id, selected_pulse_id, selected_Hoof_FL_id, selected_Hoof_FR_id, selected_Hoof_RL_id, selected_Hoof_RR_id, selected_Movements_L_id, selected_Movements_R_id,
      selected_Feces_Present_id, selected_Feces_Consistency_id, selected_Effort_id, selected_Pulmonary_Auscultation_id, selected_Trachea_Auscultation_id;
  var vetVisitsDropdowns;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  TextEditingController reason, temperature, heart_rate, breathing_freq, capillary_filling, dehydration, overall_mood, observation, diagnosis, DT_observation,treatment ;



  @override
  void initState() {
    reason=TextEditingController();
    temperature=TextEditingController();
    heart_rate=TextEditingController();
    breathing_freq=TextEditingController();
    capillary_filling=TextEditingController();
    dehydration=TextEditingController();
    overall_mood=TextEditingController();
    observation=TextEditingController();
    diagnosis=TextEditingController();
    DT_observation=TextEditingController();
    treatment=TextEditingController();

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
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            //keyboardType: TextInputType.number,
                            controller: reason,
                            attribute: "Reason",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Reason",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:30, right: 250),
                            child: Text("Parameters", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            //keyboardType: TextInputType.number,
                            controller: temperature,
                            attribute: "Temperature(C)",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Temperature(C)",
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
                            controller: heart_rate,
                            attribute: "Heart Rate (per min.)",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Heart Rate (per min.)",
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
                            controller: breathing_freq,
                            attribute: "Breathing Freq. (per min.)",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Breathing Freq. (per min.)",
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
                            controller: capillary_filling,
                            attribute: "Capillary Filling (seg)",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Capillary Filling (seg)",
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
                            controller: dehydration,
                            attribute: "Dehydration (%)",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Dehydration (%)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                            child: FormBuilderDropdown(
                              attribute: "Mucus Membranes",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Mucus Membranes"),
                              items:mucus_membrane!=null?mucus_membrane.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Mucus Membranes",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_mucus_membrane=value;
                                this.selected_mucus_membrane_id=mucus_membrane.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            //keyboardType: TextInputType.number,
                            controller: overall_mood,
                            attribute: "Overall Mood",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Overall Mood",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:30, right: 250),
                            child: Text("Hooves", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Pulse",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Pulse"),
                            items:Pulse!=null?Pulse.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Pulse",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_pulse=value;
                                this.selected_pulse_id=Pulse.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Hoof (Front Left)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Hoof (Front Left)"),
                            items:Hoof_FL!=null?Hoof_FL.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Hoof (Front Left)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Hoof_FL=value;
                                this.selected_Hoof_FL_id=Hoof_FL.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Hoof (Front Right)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Hoof (Front Right)"),
                            items:Hoof_FR!=null?Hoof_FR.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Hoof (Front Right)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Hoof_FR=value;
                                this.selected_Hoof_FR_id=Hoof_FR.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Hoof (Rear Left)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Hoof (Rear Left)"),
                            items:Hoof_RL!=null?Hoof_RL.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Hoof (Real Left)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Hoof_RL=value;
                                this.selected_Hoof_RL_id=Hoof_RL.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Hoof (Rear Right)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Hoof (Rear Right)"),
                            items:Hoof_RR!=null?Hoof_RR.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Hoof (Rear Right)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Hoof_RR=value;
                                this.selected_Hoof_RR_id=Hoof_RR.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:30, right: 250),
                            child: Text("Intestines", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Movements (Left)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Movements (Left)"),
                            items:Movements_L!=null?Movements_L.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Movements (Left)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Movements_L=value;
                                this.selected_Movements_L_id=Movements_L.indexOf(value);
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Movements (Right)",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Movements (Right)"),
                            items:Movements_R!=null?Movements_R.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Movements (Right)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Movements_R=value;
                                this.selected_Movements_R_id=Movements_R.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Presence of Feces",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Presence of Feces"),
                            items:Feces_Present!=null?Feces_Present.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Presence of Feces",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Feces_Present=value;
                                this.selected_Feces_Present_id=Feces_Present.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Consistency of Feces",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Consistency of Feces"),
                            items:Feces_Consistency!=null?Feces_Consistency.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Consistency of Feces",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Feces_Consistency=value;
                                this.selected_Feces_Consistency_id=Feces_Consistency.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            //keyboardType: TextInputType.number,
                            controller: observation,
                            attribute: "Observation",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Observation",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:30, right: 250),
                            child: Text("Respiratory", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Effort",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Effort"),
                            items:Effort!=null?Effort.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Effort",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Effort=value;
                                this.selected_Effort_id=Effort.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Effort",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Effort"),
                            items:Effort!=null?Effort.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Effort",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Effort=value;
                                this.selected_Effort_id=Effort.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Pulmonary Auscultation",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Pulmonary Auscultation"),
                            items:Pulmonary_Auscultation!=null?Pulmonary_Auscultation.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Pulmonary Auscultation",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Pulmonary_Auscultation=value;
                                this.selected_Pulmonary_Auscultation_id=Pulmonary_Auscultation.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
                          child: FormBuilderDropdown(
                            attribute: "Trachea Auscultation",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Trachea Auscultation"),
                            items:Trachea_Auscultation!=null?Trachea_Auscultation.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Trachea Auscultation",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_Trachea_Auscultation=value;
                                this.selected_Trachea_Auscultation_id=Trachea_Auscultation.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:30, right: 200),
                            child: Text("Diagnosis & Treatment", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            //keyboardType: TextInputType.number,
                            controller: diagnosis,
                            attribute: "Diagnosis",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Diagnosis",
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
                            controller: DT_observation,
                            attribute: "Observation",
                            validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Observation",
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
                            controller: treatment,
                            attribute: "Treatment",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Treatment",
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
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        onPressed: () async{
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          if(_fbKey.currentState.validate()){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductsApplied(
                                prefs.getString("token"),
                                date,
                                vetVisitsDropdowns['horseDropDown'][selected_horse_id]['id'],
                                vetVisitsDropdowns['vetDropDown'][selected_vet_id]['id'],
                                selected_type_id,
                                vetVisitsDropdowns['vetVisitProduct']['inventoryProductsDropDown'],
                                vetVisitsDropdowns['responsibleDropDown'][selected_responsible_id]['id'],
                                reason.text,
                                temperature.text,
                                heart_rate.text,
                                breathing_freq.text,
                                capillary_filling.text,
                                dehydration.text,
                                selected_mucus_membrane_id,
                                overall_mood.text,
                                selected_pulse_id,
                                selected_Hoof_FL_id,
                                selected_Hoof_FR_id,
                                selected_Hoof_RL_id,
                                selected_Hoof_RR_id,
                                selected_Movements_L_id,
                                selected_Movements_R_id,
                                true,
                                selected_Feces_Consistency_id,
                                observation.text,
                                selected_Effort_id,
                                selected_Pulmonary_Auscultation_id,
                                selected_Trachea_Auscultation_id,
                                diagnosis.text,
                                DT_observation.text,
                                treatment.text
                            )));
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