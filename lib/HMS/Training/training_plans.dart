import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Training/excercises_page.dart';
class training_plan extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return training_plan_state();
  }

}
class training_plan_state extends State<training_plan>{
  TextEditingController trainingPlan;
  TextEditingController trainingPlanDescription;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    trainingPlan=TextEditingController();
    trainingPlanDescription=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Training Plan"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: FormBuilderTextField(
                        controller: trainingPlan,
                        attribute: "Training Plan Name",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Training Plan Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: trainingPlanDescription,
                        attribute: "Training Plan Description",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Training Plan Description",
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
                  padding: EdgeInsets.only(top:16),
                  child: MaterialButton(
                    child: Text("Add Excercises",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      if(_fbKey.currentState.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>excercises(trainingPlan.text,trainingPlanDescription.text)));
                      }
                    },
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}