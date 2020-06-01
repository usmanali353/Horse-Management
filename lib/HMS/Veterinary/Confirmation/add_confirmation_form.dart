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
  Map<String, String> _rfdata = {};
  Map<String, String> _lfdata = {};
  Map<String, String> _rhdata = {};
  Map<String, String> _lhdata = {};
  var _rflist = List<Widget>();
  var _lflist = List<Widget>();
  var _rhlist = List<Widget>();
  var _lhlist = List<Widget>();
  int _rfindex = 1;
  int _lfindex = 1;
  int _rhindex = 1;
  int _lhindex = 1;
  add_confirmationState(this.token);

  DateTime date=DateTime.now();
  bool horses_loaded=false,vet_loaded=false;
  List<String> horses=[],vet=[],opinion=['Well','Appropriate','Deficient'];
  List<String> forejoint=[],hindjoint=[],confirmationstation =[],respons=[],confirmatioonmovement=[],lession=[],score=[];
  String selected_horse,selected_vet,selected_opinion;
  int selected_horse_id=0,selected_vet_id=0,selected_opinion_id;
  TextEditingController comments;


  void _rflimb() {
    int keyValue = _rfindex;
    _rflist = List.from(_rflist)
      ..add(Column(
        key: Key("${keyValue}"),
        children: <Widget>[
          ListTile(
            //leading: Text('Pet $_index : '),
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:forejoint!=null?forejoint.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Joint",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rfdata['foreLimbJoint${keyValue - 1}']=forejoint.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmationstation!=null?confirmationstation.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "conformation-station",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rfdata['conformationStation${keyValue - 1}']=confirmationstation.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmatioonmovement!=null?confirmatioonmovement.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Conformation Movement",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rfdata['conformationMovement${keyValue - 1}']=confirmatioonmovement.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:lession!=null?lession.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Lession",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rfdata['lesion${keyValue - 1}']=lession.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderTextField(
              // keyboardType: TextInputType.number,
              attribute: "treatment",
              validators: [FormBuilderValidators.required()],
              onChanged: (val) {
                _rfdata['treatment${keyValue - 1}'] = val;
              },
              decoration: InputDecoration(labelText: "Treatment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("Response"),
              items:respons!=null?respons.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Response",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rfdata['response${keyValue - 1}']=respons.indexOf(value).toString();
                });
              },
            ),
          ),
          Divider()
        ],
      ));

    setState(() => ++_rfindex);
  }
  void _lflimb() {
    int keyValue = _lfindex;
    _lflist = List.from(_lflist)
      ..add(Column(
        key: Key("${keyValue}"),
        children: <Widget>[
          ListTile(
            //leading: Text('Pet $_index : '),
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:forejoint!=null?forejoint.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Joint",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                    _lfdata['conformationDetailId']='0';
                   _lfdata['limb']='2';
                   _lfdata['hindLimbJoint']='0';
                  _lfdata['foreLimbJoint']=(forejoint.indexOf(value)+1).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmationstation!=null?confirmationstation.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "conformation-station",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lfdata['conformationStation']=confirmationstation.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmatioonmovement!=null?confirmatioonmovement.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Conformation Movement",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lfdata['conformationMovement']=confirmatioonmovement.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:lession!=null?lession.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Lession",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lfdata['lesion']=lession.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderTextField(
              // keyboardType: TextInputType.number,
              attribute: "treatment",
              validators: [FormBuilderValidators.required()],
              onChanged: (val) {
                _lfdata['treatment'] = val;
              },
              decoration: InputDecoration(labelText: "Treatment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("Response"),
              items:respons!=null?respons.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Response",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lfdata['response']=respons.indexOf(value).toString();
                });
              },
            ),
          ),
          Divider()
        ],
      ));

    setState(() => ++_lfindex);
  }
  void _rhlimb() {
    int keyValue = _rhindex;
    _rhlist = List.from(_rhlist)
      ..add(Column(
        key: Key("${keyValue}"),
        children: <Widget>[
          ListTile(
            //leading: Text('Pet $_index : '),
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:hindjoint!=null?hindjoint.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Joint",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rhdata['hindLimbJoint${keyValue - 1}']=hindjoint.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmationstation!=null?confirmationstation.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "conformation-station",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rhdata['conformationStation${keyValue - 1}']=confirmationstation.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmatioonmovement!=null?confirmatioonmovement.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Conformation Movement",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rhdata['conformationMovement${keyValue - 1}']=confirmatioonmovement.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:lession!=null?lession.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Lession",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rhdata['lesion${keyValue - 1}']=lession.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderTextField(
              // keyboardType: TextInputType.number,
              attribute: "treatment",
              validators: [FormBuilderValidators.required()],
              onChanged: (val) {
                _rhdata['treatment${keyValue - 1}'] = val;
              },
              decoration: InputDecoration(labelText: "Treatment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("Response"),
              items:respons!=null?respons.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Response",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _rhdata['response${keyValue - 1}']=respons.indexOf(value).toString();
                });
              },
            ),
          ),
          Divider()
        ],
      ));

    setState(() => ++_rhindex);
  }
  void _lhlimb() {
    int keyValue = _lhindex;
    _lhlist = List.from(_lhlist)
      ..add(Column(
        key: Key("${keyValue}"),
        children: <Widget>[
          ListTile(
            //leading: Text('Pet $_index : '),
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:hindjoint!=null?hindjoint.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Joint",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lhdata['hindLimbJoint${keyValue - 1}']=hindjoint.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmationstation!=null?confirmationstation.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "conformation-station",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lhdata['conformationStation${keyValue - 1}']=confirmationstation.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:confirmatioonmovement!=null?confirmatioonmovement.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Conformation Movement",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lhdata['conformationMovement${keyValue - 1}']=confirmatioonmovement.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("select"),
              items:lession!=null?lession.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Lession",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lhdata['lesion${keyValue - 1}']=lession.indexOf(value).toString();
                });
              },
            ),
          ),
          ListTile(
            title: FormBuilderTextField(
              // keyboardType: TextInputType.number,
              attribute: "treatment",
              validators: [FormBuilderValidators.required()],
              onChanged: (val) {
                _lhdata['treatment${keyValue - 1}'] = val;
              },
              decoration: InputDecoration(labelText: "Treatment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
            ),
          ),
          ListTile(
            title: FormBuilderDropdown(attribute: "Horse",
              hint: Text("Response"),
              items:respons!=null?respons.map((horse)=>DropdownMenuItem(
                child: Text(horse),
                value: horse,
              )).toList():[""].map((name) => DropdownMenuItem(
                  value: name, child: Text("$name")))
                  .toList(),
              //style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(labelText: "Response",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                ),
              ),
              onChanged: (value){
                setState(() {
                  //_rfdata['name${keyValue - 1}']=value;
                  _lhdata['response${keyValue - 1}']=respons.indexOf(value).toString();
                });
              },
            ),
          ),
          Divider()
        ],
      ));

    setState(() => ++_lhindex);
  }





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
              for(int i=0;i<confirmationDropdowns['conformationDetail']['foreLimbJointDropDown'].length;i++)
                forejoint.add(confirmationDropdowns['conformationDetail']['foreLimbJointDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['hindLimbJointDropDown'].length;i++)
                hindjoint.add(confirmationDropdowns['conformationDetail']['hindLimbJointDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['lesionDropDown'].length;i++)
                lession.add(confirmationDropdowns['conformationDetail']['lesionDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['movementDropDown'].length;i++)
                confirmatioonmovement.add(confirmationDropdowns['conformationDetail']['movementDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['stationDropDown'].length;i++)
                confirmationstation.add(confirmationDropdowns['conformationDetail']['stationDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['scoresDropDown'].length;i++)
                score.add(confirmationDropdowns['conformationDetail']['scoresDropDown'][i]['name']);
              for(int i=0;i<confirmationDropdowns['conformationDetail']['responseDropDown'].length;i++)
                respons.add(confirmationDropdowns['conformationDetail']['responseDropDown'][i]['name']);

            });

          }
        });
      }else{

      }
    });
    super.initState();
   // _add();
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
                    onPressed: _rflimb,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: _rflist,
                ),
                Padding(padding: EdgeInsets.only(top:30,right: 250),
                    child: Text("Left Forelimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                ),
                Padding(padding: EdgeInsets.only(right: 350),
                  child: IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.teal,
                    tooltip: 'Add Left Forlimb',
                    onPressed: _lflimb,
                  ),
                ),
                ListView(
                  shrinkWrap: true,

                  children: _lflist,
                ),
                Padding(padding: EdgeInsets.only(top:30,right: 250),
                    child: Text("Right Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                ),
                Padding(padding: EdgeInsets.only(right: 350),
                  child: IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.teal,
                    tooltip: 'Add Right Hindlimb',
                    onPressed: _rhlimb,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: _rhlist,
                ),
                Padding(padding: EdgeInsets.only(top:30,right: 250),
                    child: Text("Left Hindlimb", style: TextStyle(color: Colors.teal,fontSize: 20, fontWeight: FontWeight.bold),)
                ),
                Padding(padding: EdgeInsets.only(right: 350),
                  child: IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.teal,
                    onPressed: _lhlimb,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: _lhlist,
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: MaterialButton(
                onPressed: () async{
                 // print(_rfdata);
                  print(_lfdata);
                 // print(_rhdata);
                 // print(_lhdata);
                  List<Map> confirmationDetails=[];
                  confirmationDetails.add(_lfdata);

                  ConfirmationServices.add_confirmation(token, 0,confirmationDropdowns['horseDropDown'][selected_horse_id]['id'], date,confirmationDropdowns['vetDropDown'][selected_vet_id]['id'], selected_opinion_id, '', confirmationDetails).then((response){
                    if(response!=null){

                    }else{

                    }
                  });
                  SharedPreferences prefs= await SharedPreferences.getInstance();
                  if(_fbKey.currentState.validate()){
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>addProductsApplied(prefs.getString("token"),date,selected_horse_id,selected_vet_id,selected_opinion_id,confirmationDropdowns['conformationDetail']['foreLimbJointDropDown'])));
                  }
                },
                child: Text("Save",style: TextStyle(color: Colors.white),),
                color: Colors.teal,
              ),
            ),
          )
        ],
        shrinkWrap: true,
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
