import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Veterinary/Confirmation/confirmation_json.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/addProductsApplied.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils.dart';

class add_confirmation extends StatefulWidget{
  String token;

  add_confirmation(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_confirmationState(token);
  }

}
class add_confirmationState extends State<add_confirmation>{
  String token;

  add_confirmationState(this.token);

  DateTime date=DateTime.now();
  bool horses_loaded=false,vet_loaded=false;
  List<String> horses=[],vet=[],opinion=['Well','Appropriate','Deficient'];
  String selected_horse,selected_vet,selected_opinion;
  int selected_horse_id=0,selected_vet_id=0,selected_opinion_id;
  TextEditingController comments;
  var confirmationDropdowns;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.comments=TextEditingController();
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        ConfirmationServices.get_conformations_dropdowns(token).then((response){
          pd.hide();
          if(response!=null){
            setState(() {
              confirmationDropdowns=json.decode(response);
              print(confirmationDropdowns['conformationDetail']['foreLimbJointDropDown'].toString());
//              if(confirmationDropdowns['horseDropDown']!=null&&confirmationDropdowns['horseDropDown'].length>0){
//                for(int i=0;i<confirmationDropdowns['horseDropDown'].length;i++){
//                  horses.add(confirmationDropdowns['horseDropDown'][i]['name']);
//                }
//                horses_loaded=true;
//              }
//              if(confirmationDropdowns['vetDropDown']!=null&&confirmationDropdowns['vetDropDown'].length>0){
//                for(int i=0;i<confirmationDropdowns['vetDropDown'].length;i++){
//                  vet.add(confirmationDropdowns['vetDropDown'][i]['name']);
//                }
//                vet_loaded=true;
//              }
              for(int i=0;i<confirmationDropdowns['horseDropDown'].length;i++)
                horses.add(confirmationDropdowns['horseDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['vetDropDown'].length;i++)
                vet.add(confirmationDropdowns['vetDropDown'][i]['name']);
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
      appBar: AppBar(title: Text("Add Confirmation Form"),),
      body: ListView(
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
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Visibility(
                   // visible: vet_loaded,
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
                    // visible: vet_loaded,
                    child: FormBuilderDropdown(
                      attribute: "Opinion",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Opinion"),
                      items:opinion!=null?opinion.map((horse)=>DropdownMenuItem(
                        child: Text(horse),
                        value: horse,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Opinion",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          this.selected_opinion=value;
                          this.selected_opinion_id=opinion.indexOf(value);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: comments,
                    // keyboardType: TextInputType.number,
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
      Padding(padding: EdgeInsets.only(top:30, right: 250),
                child: Text("Right Forelimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
            ),
        Padding(padding: EdgeInsets.only(right: 350),
          child: IconButton(
                      icon: Icon(Icons.add_circle),
                      color: Colors.teal,
                      tooltip: 'Add Right Forlimb',
                      onPressed: () async
                      {
//                        List<PersonEntry> persons = await Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => SOF(),
//                          ),
//                        );
                       // if (persons != null) persons.forEach(print);
                      },
                    ),
               ),
      Padding(padding: EdgeInsets.only(top:30,right: 250),
          child: Text("Left Forelimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
      ),
      Padding(padding: EdgeInsets.only(right: 350),
        child: IconButton(
          icon: Icon(Icons.add_circle),
          color: Colors.teal,
          tooltip: 'Add Left Forlimb',
          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
          },
        ),
      ),
      Padding(padding: EdgeInsets.only(top:30,right: 250),
          child: Text("Right Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
      ),
      Padding(padding: EdgeInsets.only(right: 350),
        child: IconButton(
          icon: Icon(Icons.add_circle),
          color: Colors.teal,
          tooltip: 'Add Right Hindlimb',
          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
          },
        ),
      ),
      Padding(padding: EdgeInsets.only(top:30,right: 250),
          child: Text("Left Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
      ),
      Padding(padding: EdgeInsets.only(right: 350),
        child: IconButton(
          icon: Icon(Icons.add_circle),
          color: Colors.teal,
          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
          },
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
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductsApplied(prefs.getString("token"),date,selected_horse_id,selected_vet_id,selected_opinion_id,confirmationDropdowns['conformationDetail']['foreLimbJointDropDown'])));
                  }
                },
                child: Text("Add Products Applied",style: TextStyle(color: Colors.white),),
                color: Colors.teal,
              ),
            ),
          )
        ],
      ),
    );
  }

}








//import 'package:flutter/material.dart';
//import  'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:intl/intl.dart';
//
//class add_confirmation_form extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _add_confirmation_form();
//  }
//}
//
//class _add_confirmation_form extends State<add_confirmation_form>{
//  var data;
//  var nameTECs = <TextEditingController>[];
//  bool autoValidate = true;
//  bool readOnly = false;
//  bool showSegmentedControl = true;
//  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
//  final _formkey = GlobalKey<FormState>();
//  String _date = "Date";
//  String _Name =  "";
//  TextEditingController _controller = TextEditingController();
//  TextEditingController nameController = TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Create New Conformation"),),
//        body:  Padding(
//          padding: EdgeInsets.all(10),
//          child: SingleChildScrollView(
//    child: Column(
//      children: <Widget>[
//      FormBuilder(
//      key: _fbKey,
//      initialValue: {
//        'date': DateTime.now(),
//        'accept_terms': false,
//      },
//      autovalidate: true,
//      child: Column(children: <Widget>[
//      Padding(padding: EdgeInsets.only(top:5 ,bottom: 13),
//      child:  FormBuilderDropdown(
//        attribute: "name",
//        style: Theme.of(context).textTheme.body1,
//        decoration: InputDecoration(labelText: "Horse",
//          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(9.0),
//              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//          ),
//        ),
//        // initialValue: 'Male',
//        hint: Text('Select Horse'),
//        validators: [FormBuilderValidators.required()],
//        items: ['Male', 'Female', 'Other']
//            .map((name) => DropdownMenuItem(
//            value: name, child: Text("$name")))
//            .toList(),
//          onChanged: (value) {
//            setState(() => _Name = value);
//            print(value);
//          }
//      ),
//    ),
//            Padding(padding: EdgeInsets.only(top:2 ,bottom: 2),
//              child:  FormBuilderDateTimePicker(
//                attribute: "date",
//                style: Theme.of(context).textTheme.body1,
//                inputType: InputType.date,
//                validators: [FormBuilderValidators.required()],
//                format: DateFormat("dd-MM-yyyy"),
//                decoration: InputDecoration(labelText: "Date",
//                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(9.0),
//                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                  ),),
//              ),
//            ),
//            Padding(padding: EdgeInsets.only(top:5 ,bottom: 13),
//              child:  FormBuilderDropdown(
//                attribute: "name",
//                style: Theme.of(context).textTheme.body1,
//                decoration: InputDecoration(labelText: "Vet",
//                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(9.0),
//                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                  ),
//                ),
//                // initialValue: 'Male',
//                hint: Text('Select Vet'),
//                validators: [FormBuilderValidators.required()],
//                items: ['Select Vet']
//                    .map((name) => DropdownMenuItem(
//                    value: name, child: Text("$name")))
//                    .toList(),
//                  onChanged: (value) {
//                    setState(() => _Name = value);
//                    print(value);
//                  }
//              ),
//            ),
//            Padding(padding: EdgeInsets.only(top:5 ,bottom: 13),
//              child:  FormBuilderDropdown(
//                attribute: "name",
//                style: Theme.of(context).textTheme.body1,
//                decoration: InputDecoration(labelText: "Opinion",
//                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(9.0),
//                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                  ),
//                ),
//                // initialValue: 'Male',
//                hint: Text('Well'),
//                validators: [FormBuilderValidators.required()],
//                items: ['Well', 'Appropriate', 'Deficient']
//                    .map((name) => DropdownMenuItem(
//                    value: name, child: Text("$name")))
//                    .toList(),
//                  onChanged: (value) {
//                    setState(() => _Name = value);
//                    print(value);
//                  }
//              ),
//            ),
//            Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
//              child: FormBuilderTextField(
//                attribute: 'text',
//                style: Theme.of(context).textTheme.body1,
//                //validators: [FormBuilderValidators.required()],
//                decoration: InputDecoration(labelText: "Comments",
//                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(9.0),
//                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                  ),
//                ),
//              ),
//            ),
//            Padding(padding: EdgeInsets.only(right: 250),
//                child: Text("Right Forelimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
//            ),
//        Padding(padding: EdgeInsets.only(right: 350),
//          child: IconButton(
//                      icon: Icon(Icons.add_circle),
//                      color: Colors.teal,
//                      tooltip: 'Add Right Forlimb',
//                      onPressed: () async {
//                        List<PersonEntry> persons = await Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => SOF(),
//                          ),
//                        );
//                        if (persons != null) persons.forEach(print);
//                      },
//                    ),
//        ),
//      Padding(padding: EdgeInsets.only(right: 250),
//          child: Text("Left Forelimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
//      ),
//      Padding(padding: EdgeInsets.only(right: 350),
//        child: IconButton(
//          icon: Icon(Icons.add_circle),
//          color: Colors.teal,
//          tooltip: 'Add Left Forlimb',
//          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
//          },
//        ),
//      ),
//      Padding(padding: EdgeInsets.only(right: 250),
//          child: Text("Right Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
//      ),
//      Padding(padding: EdgeInsets.only(right: 350),
//        child: IconButton(
//          icon: Icon(Icons.add_circle),
//          color: Colors.teal,
//          tooltip: 'Add Right Hindlimb',
//          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
//          },
//        ),
//      ),
//      Padding(padding: EdgeInsets.only(right: 250),
//          child: Text("Left Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
//      ),
//      Padding(padding: EdgeInsets.only(right: 350),
//        child: IconButton(
//          icon: Icon(Icons.add_circle),
//          color: Colors.teal,
//          onPressed: () async {
//            List<PersonEntry> persons = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => SOF(),
//              ),
//            );
//            if (persons != null) persons.forEach(print);
//          },
//        ),
//      ),
//      MaterialButton(
//        onPressed: (){
//          _fbKey.currentState.save();
//          if (_fbKey.currentState.validate()) {
//            print(_fbKey.currentState.value);
//          }
//        },
//        child: Text("Save",style: TextStyle(color: Colors.white),
//        ),
//        color: Colors.teal,
//      ),
//      ],
//      )
//      ),
//
//      ],
//    ),
//
//          ),
//
//
//
//        ),
//    );
//
//  }
//
//}
//class SOF extends StatefulWidget {
//  @override
//  _SOFState createState() => _SOFState();
//}
//class _SOFState extends State<SOF> {
//
//  var nameTECs = <TextEditingController>[];
//  var ageTECs = <TextEditingController>[];
//  var jobTECs = <TextEditingController>[];
//  var cards = <Card>[];
//
//  Card createCard() {
//    var nameController = TextEditingController();
//    var ageController = TextEditingController();
//    var jobController = TextEditingController();
//    nameTECs.add(nameController);
//    ageTECs.add(ageController);
//    jobTECs.add(jobController);
//    return Card(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Text('Person ${cards.length + 1}'),
//          TextField(
//              controller: nameController,
//              decoration: InputDecoration(labelText: 'Full Name')),
//          TextField(
//              controller: ageController,
//              decoration: InputDecoration(labelText: 'Age')),
//          TextField(
//              controller: jobController,
//              decoration: InputDecoration(labelText: 'Study/ job')),
//        ],
//      ),
//    );
//  }
//  @override
//  void initState() {
//    super.initState();
//    cards.add(createCard());
//  }
//  _onDone() {
//    List<PersonEntry> entries = [];
//    for (int i = 0; i < cards.length; i++) {
//      var name = nameTECs[i].text;
//      var age = ageTECs[i].text;
//      var job = jobTECs[i].text;
//      entries.add(PersonEntry(name, age, job));
//    }
//    Navigator.pop(context, entries);
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(),
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView.builder(
//              itemCount: cards.length,
//              itemBuilder: (BuildContext context, int index) {
//                return cards[index];
//              },
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: RaisedButton(
//              child: Text('add new'),
//              onPressed: () => setState(() => cards.add(createCard())),
//            ),
//          )
//        ],
//      ),
//      floatingActionButton:
//      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
//    );
//  }
//}
//class PersonEntry {
//  final String name;
//  final String age;
//  final String studyJob;
//
//  PersonEntry(this.name, this.age, this.studyJob);
//  @override
//  String toString() {
//    return 'Person: name= $name, age= $age, study job= $studyJob';
//  }
//}
