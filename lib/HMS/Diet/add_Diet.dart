import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Diet/dietDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addDiet extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addDietState();
  }

}
class addDietState extends State<addDiet>{
  TextEditingController dietName,dietDescription;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    dietName=TextEditingController();
    dietDescription=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Diet"),),
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
                       controller: dietName,
                       attribute: "Diet Name",
                       validators: [FormBuilderValidators.required()],
                       decoration: InputDecoration(labelText: "Diet Name",
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(9.0),
                             borderSide: BorderSide(color: Colors.teal, width: 1.0)
                         ),
                       ),

                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.only(left: 16,right:16),
                     child: FormBuilderTextField(
                       controller: dietDescription,
                       attribute: "Diet Description",
                       validators: [FormBuilderValidators.required()],
                       decoration: InputDecoration(labelText: "Diet Description",
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
                    color: Colors.teal,
                    child: Text("Add Diet Details",style: TextStyle(color: Colors.white),),
                    onPressed: ()async{
                       SharedPreferences prefs=await SharedPreferences.getInstance();
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>dietDetails(prefs.getString("token"),dietName.text,dietDescription.text)));
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}