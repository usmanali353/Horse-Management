import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:intl/intl.dart';
import 'horsegroup_services.dart';


class add_HorseGroup extends StatefulWidget{
  final token;

  add_HorseGroup (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(token);
  }

}
class _add_horse_state extends State<add_HorseGroup>{
  final token;
  _add_horse_state (this.token);

  List<String> gender=[];List<String> colors=[];List<String> barn=[];List<String> sire=[];List<String> category=[];List<String> dam=[];
  List<String> breeding=[];List<String> diet=[];
  List<String> breeder=[];List<String> vet=[];List<String> rider=[],owner=[];List<String> location=[];List<String> incharge=[];List<String> association=[];

  int select_gender_id,select_barn_id,select_trainer_id,select_color_id,select_category_id,select_sire_id,select_dam_id, select_breeder_id,
      select_vet_id, select_incharge_id,select_associate_id, select_owner_id,select_rider_id,select_breed_id,select_ironbrand_id,select_location_id;

  String select_gender,selected_barn,selected_trainer,selected_color,selected_category,selected_sire,selected_dam,
      selected_breeder,selected_vet,selected_location,selected_incharge,selected_associate,selected_owner,selected_rider,selected_breed,selected_bodymark;
//  DateTime Select_date = DateTime.now();
  DateTime birthfrom,birthto,createdfrom,createdto,modifiedfrom,modifiedto;
  TextEditingController name;

  var getHorses,genderlist;

  String _excerciseplan="Select Excercise Plan";
  sqlite_helper local_db;
  bool _isvisible=false,isdynamic;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Future<void> initState()  {
//    SharedPreferences  prefs= await SharedPreferences.getInstance();
//   var token =  await prefs.getString("token");
//   print(token);

    name= TextEditingController();

    Add_horsegroup_services.horsesdropdown(token).then((response){
      setState(() {
        print(response);
        getHorses=json.decode(response);
        for(int i=0;i<getHorses['damDropDown'].length;i++)
          dam.add(getHorses['damDropDown'][i]['name']);
        for(int i=0;i<getHorses['sireDropDown'].length;i++)
          sire.add(getHorses['sireDropDown'][i]['name']);
        for(int i=0;i<getHorses['breederDropDown'].length;i++)
          breeder.add(getHorses['breederDropDown'][i]['name']);
        for(int i=0;i<getHorses['locationDropDown'].length;i++)
          location.add(getHorses['locationDropDown'][i]['name']);
        for(int i=0;i<getHorses['ownerDropDown'].length;i++)
          owner.add(getHorses['ownerDropDown'][i]['name']);
        for(int i=0;i<getHorses['riderDropDown'].length;i++)
          rider.add(getHorses['riderDropDown'][i]['name']);
        for(int i=0;i<getHorses['inchargeDropDown'].length;i++)
          incharge.add(getHorses['inchargeDropDown'][i]['name']);
        for(int i=0;i<getHorses['colorDropDown'].length;i++)
          colors.add(getHorses['colorDropDown'][i]['name']);
        for(int i=0;i<getHorses['breedDropDown'].length;i++)
          breeding.add(getHorses['breedDropDown'][i]['name']);
        for(int i=0;i<getHorses['horseCategoryDropDown'].length;i++)
          category.add(getHorses['horseCategoryDropDown'][i]['name']);
        for(int i=0;i<getHorses['locationDropDown'].length;i++)
          location.add(getHorses['locationDropDown'][i]['name']);

      });
    });

    Add_horse_services.gender(token).then((response){
      setState(() {
        genderlist  = jsonDecode(response);
        print(response);

        for(int i=0;i<genderlist.length;i++){
          gender.add(genderlist[i]['name']);
        }
        print(gender.length.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add HorseGroup"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
//
//
//                      Padding(
//                        padding: const EdgeInsets.only(left: 16,right: 16),
//                        child: DropdownButtonFormField<String>(
//                          value: select_gender,
//                          isExpanded: true,
//                          isDense: true,
//                          items: gender.map((options) {
//                            return  DropdownMenuItem<String>(
//                              value: options,
//                              child: new Text(options),
//
//                            );
//
////                            items: genderlist.map<String>((item) => DropdownMenuItem<String>(
////                                value: item,
////                                child: Text(item['Description'])),
//
//                          }).toList(),
//                          onChanged: (String value) {
//                            print(value);
//                            setState(() {
//                              select_gender = value;
//                            });
//                          },
//                          decoration: InputDecoration(
//                              labelText: "Horse",
//                              hintText: "Horse"
//                          ),
//
//                        ),
//                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16,left: 16,top: 16),
                        child: FormBuilderTextField(
                          controller: name,
                          attribute: "Name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Horse Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "dynamic",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: ["Yes","No"].map((name) => DropdownMenuItem(value: name, child: Text(name))).toList(),
                          onChanged: (value){
                            //this.ddvalue=value;
                            if(value=="Yes"){
                              setState(() {
                                _isvisible=true;
                                isdynamic = true;
                              });
                            }else{
                              setState(() {
                                isdynamic = false;
                                _isvisible=false;
                              });
                            }
                          },
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Gender",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)),),
                        ),
                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 16,right:16),
//                        child: Visibility(
//                          visible: _isvisible,
//                          child:FormBuilderDropdown(
//                            attribute: "Exercise Plan",
//                            validators: [FormBuilderValidators.required()],
//                            hint: Text("Excercise Plan"),
//                            items: gender.map((name) => DropdownMenuItem(
//                                value: name, child: Text("$name")))
//                                .toList(),
//                            onChanged: (value){
//                              this._excerciseplan=value;
//                            },
//                            style: Theme.of(context).textTheme.body1,
//                            decoration: InputDecoration(labelText: "Excercise Plan",
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(9.0),
//                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                              ),
//                            ),
//
//                          ),
//                        ),
//                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16,),
                          child: FormBuilderDropdown(
                            attribute: "Gender",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: gender.map((name) => DropdownMenuItem(value: name, child: Text(name))).toList(),
                            onChanged: (value){
                              setState(() {
                                this.select_gender=value;
                                this.select_gender_id=gender.indexOf(value)+1;
                              });
                            },
                            style: Theme.of(context).textTheme.body1, decoration: InputDecoration(labelText: "Gender",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)),
                            ),

                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "location",
                            hint: Text("- Select -"),
                            items: location.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Location",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_location=value;
                              this.select_location_id=location.indexOf(value);
                            },
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Breed",
                            hint: Text("- Select -"),
                            items: breeding.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Breed",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_breed=value;
                              this.select_breed_id=breeding.indexOf(value);
                            },
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Color",
                            hint: Text("- Select -"),
                            items: colors.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Color",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_color=value;
                                this.select_color_id=colors.indexOf(value);
                              });

                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Category",
                            hint: Text("- Select -"),
                            items: category.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Category",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_category=value;
                              this.select_category_id=category.indexOf(value);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "sireName",
                            hint: Text("- Select -"),
                            items: sire.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Sire",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_sire=value;
                              this.select_sire_id=sire.indexOf(value);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "damName",
                            hint: Text("- Select -"),
                            items: dam.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Dam",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_dam=value;
                              this.select_dam_id=dam.indexOf(value);
                            },
                          ),
                        ),
                      ),
                     // Text("More Information",textScaleFactor: 2,),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Breeder",
                            hint: Text("- Select -"),
                            items: breeder.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Breeder",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_breeder=value;
                              this.select_breeder_id=breeder.indexOf(value);
                            },
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "rider",
                            hint: Text("- Select -"),
                            items: rider.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Rider",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_rider=value;
                              this.select_rider_id=rider.indexOf(value);

                            },
                          ),
                        ),
                      ),

                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "owner",
                            hint: Text("- Select -"),
                            items: rider.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Owner",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_owner=value;
                              this.select_owner_id=owner.indexOf(value);

                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "incharge",
                            hint: Text("- Select -"),
                            items: incharge.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Incharge",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_incharge=value;
                              this.select_incharge_id=incharge.indexOf(value);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDateTimePicker(
                            attribute: "date",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "DateofBirth From",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              this.birthfrom=value;
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDateTimePicker(
                            attribute: "date",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "DateOfBirth To",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              this.birthto=value;
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDateTimePicker(
                            attribute: "date",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "Created From",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              this.createdfrom=value;
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isvisible,
                        child: Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDateTimePicker(
                            attribute: "date",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "Created To",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              this.createdto=value;
                            },
                          ),
                        ),
                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                        child:Visibility(
//                          visible: _isvisible,
//                          child: FormBuilderDateTimePicker(
//                            attribute: "date",
//                            style: Theme.of(context).textTheme.body1,
//                            inputType: InputType.date,
//                            format: DateFormat("MM-dd-yyyy"),
//                            decoration: InputDecoration(labelText: "Modifiedd From",
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(9.0),
//                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                              ),),
//                            onChanged: (value){
//                              this.modifiedfrom=value;
//                            },
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                        child:FormBuilderDateTimePicker(
//                          attribute: "date",
//                          style: Theme.of(context).textTheme.body1,
//                          inputType: InputType.date,
//                          format: DateFormat("MM-dd-yyyy"),
//                          decoration: InputDecoration(labelText: "Modified To",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(9.0),
//                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                            ),),
//                          onChanged: (value){
//                            this.modifiedto=value;
//                          },
//                        ),
//                      ),
                    ],
                  ),
                ),
                Center(
                    child:
                    Padding(
                     // padding: const EdgeInsets.all(16),
                     // child: add_horse_button(fbKey: _fbKey,select_gender_id:select_gender_id,name: name ,token: token,isdynamic: isdynamic,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id,barnid: select_barn_id,breederid: select_breeder_id,locationid: select_location_id,ownerid: select_owner_id,riderid: select_rider_id,inchargeid: select_incharge_id,associationid:select_associate_id,genderlist: genderlist,getHorses: getHorses,birthfrom: birthfrom,birthto: birthto,createdfrom: createdfrom,createdto: createdto,),
                      // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),

//                      child: add_horse_button(fbKey: _fbKey,getHorses:getHorses,genderlist: genderlist,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,breedid: select_breed_id,categoryid: select_category_id,colorid: select_color_id,dateofbirth: Select_date,bodymarkid: select_bodymark_id,headmarkid: select_headmark_id,damid: select_dam_id,dietid: select_diet_id,barnid: select_barn_id,sireid: select_sire_id,dna: name.text,inchargeid: select_incharge_id,legmarkid: select_legmark_id,ironbrandid:select_associate_id,riderid: select_rider_id,),
                   // )
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                           print(isdynamic);
                          if (_fbKey.currentState.validate()) {
                            if (isdynamic == false) {
                              Add_horsegroup_services.horseGroupSave(token, null, 0, name.text, isdynamic, null, null, null, null, null, null, null, null, null, null, null, null, null, null).then((response) {
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
                            } else {
                              Add_horsegroup_services.horseGroupSave(token, null, 0, name.text, isdynamic, select_gender_id,
                                  getHorses['locationDropDown'][select_location_id]['id'],
                                  null,
                                  null,
                                  getHorses['damDropDown'][select_dam_id]['id'],
                                  getHorses['sireDropDown'][select_sire_id]['id'],
                                  getHorses['breederDropDown'][select_breeder_id]['id'],
                                  getHorses['ownerDropDown'][select_owner_id]['id'],
                                 null,
                                  getHorses['riderDropDown'][select_rider_id]['id'], birthfrom, birthto, createdfrom, createdto).then((response) {
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
                          }
                        },
                        child:Text("Add HorseGroup",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }

  int get_gender_info_by_id(String gender){
    var gender_id;
    for(int i=0;i<genderlist.length;i++){
      if(genderlist[i]['name']==gender){
        gender_id=genderlist[i]['id'];
      }
    }
    return gender_id;
  }

}





class add_horse_button extends StatelessWidget {
  const add_horse_button({
    GlobalKey<FormBuilderState> fbKey,
    // this.select_gender_id,
    this.name,
    this.token,
    this.isdynamic,
    this.select_gender_id,
    this.number,
    this.birthfrom,
    this.birthto,
    this.createdfrom,
    this.createdto,
    this.genderlist,
    this.getHorses,
    this.colorid,
    this.breedid,
    this.categoryid,
    this.sireid,
    this.damid,
    this.barnid,
    this.locationid,
    this.breederid,
    this.ownerid,
    this.riderid,
    this.inchargeid,
    this.associationid,
    //  this.gender_name,


  }) : _fbKey = fbKey, super();
  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final int select_gender_id;
  final bool isdynamic;
  final TextEditingController name;
  final DateTime birthfrom,birthto,createdfrom,createdto;
  final genderlist,getHorses;
  final String number;
  final int colorid,breedid,categoryid,sireid,damid;
  final int associationid,ownerid,riderid,inchargeid,locationid,breederid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        print("object");
        print(name.text);
        //print([breedid]);
//        print(getHorses['colorDropDown'][colorid]['id']);
//        print(getHorses['damDropDown'][damid]['id']);
//        print(getHorses['inchargeDropDown'][inchargeid]['id']);
//        print(getHorses['barnDropDown'][barnid]['id']);
//        print(getHorses['breedDropDown'][breedid]['id']);
//        print(getHorses['horseCategoryDropDown'][categoryid]['id']);

//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
//          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((
          Add_horsegroup_services.horseGroupSave(token, null, 0, name.text,isdynamic, select_gender_id, getHorses['locationDropDown'][locationid]['id'], getHorses['colorDropDown'][colorid]['id'], getHorses['breedDropDown'][breedid]['id'], getHorses['damDropDown'][damid]['id'], getHorses['sireDropDown'][sireid]['id'], getHorses['breederDropDown'][breederid]['id'], getHorses['ownerDropDown'][ownerid]['id'], getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['riderDropDown'][riderid]['id'], birthfrom, birthto, createdfrom, createdto).then((response) {
            if (response != null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text("Added Sucessfully"),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(" not Added"),
              ));
            }
          });
        }
      },
      child:Text("Add Horse",style: TextStyle(color: Colors.white),),
    );
  }
}