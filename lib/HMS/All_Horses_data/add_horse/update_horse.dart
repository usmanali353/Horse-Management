import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:intl/intl.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class update_horse extends StatefulWidget{
   String token;
  var horsedata;
  update_horse (this.token,this.horsedata);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_horse_state(token,horsedata);
  }

}
class _update_horse_state extends State<update_horse>{
  String token;
  var horsedata;
   String createdBy;

  _update_horse_state (this.token,this.horsedata);
  int select_gender_id,select_barn_id,select_trainer_id,select_color_id,select_category_id,select_sire_id,select_dam_id,select_headmark_id;
  int select_legmark_id,select_bodymark_id,select_diet_id,select_breeder_id,select_vet_id,select_incharge_id,select_associate_id,select_rider_id;
  int select_breed_id,select_ironbrand_id,selected_location_id;
  String select_gender,selected_barn,selected_trainer,selected_color,selected_category,selected_sire,selected_dam,selected_headMark,selected_legMark;
  String selected_diet,selected_ironbrand,selected_location,selected_breeder,selected_vet,selected_incharge,selected_associate,selected_rider,selected_breed,selected_bodymark;
  DateTime Select_date = DateTime.now();
  TextEditingController name,number,chip,passport,dna;
//   var colorlist,genderlist,genderidlist,barnlist,sirelist,categorylist,damlist,breedlist,dietlist,headmarklist,bodymarklist,legmarklist,ironbrandlist,breederlist,vetlist;
//   var riderlist,inchargelist,locationlist,associationlist;
  List<String> gender=[];List<String> genderid=[];List<String> colors=[];List<String> barn=[];List<String> sire=[];List<String> category=[];List<String> dam=[];
  List<String> breeding=[];List<String> diet=[];List<String> headmark=[];List<String> bodymark=[];List<String> legmark=[];List<String> ironbrand=[];
  List<String> breeder=[];List<String> vet=[];List<String> rider=[];List<String> location=[];List<String> incharge=[];List<String> association=[];
  var getHorses,genderlist;
  int horseId;
  String intaial_gender_value;
//  String End_Date = "End Date";
//  String target_date="Target Date";
  String _excerciseplan="Select Excercise Plan";
  sqlite_helper local_db;
  bool _isvisible=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Future<void> initState()  {
//    SharedPreferences  prefs= await SharedPreferences.getInstance();
//   var token =  await prefs.getString("token");
//   print(token);

    name= TextEditingController();
    number= TextEditingController();
    chip= TextEditingController();
    dna= TextEditingController();
    passport= TextEditingController();
    local_db=sqlite_helper();
    local_db.getTraining().then((list){
//      if(list!=null) {
//        print("Number of Records "+list.length.toString());
//      }else{
//        print("No Training Found");
//      }
    });



    Add_horse_services.horsesdropdown(token).then((response){
      setState(() {
        //genderlist  = jsonDecode(response);
        print(response);


        getHorses=json.decode(response);
        for(int i=0;i<getHorses['damDropDown'].length;i++)
          dam.add(getHorses['damDropDown'][i]['name']);
        for(int i=0;i<getHorses['sireDropDown'].length;i++)
          sire.add(getHorses['sireDropDown'][i]['name']);
        for(int i=0;i<getHorses['ironBrandDropDown'].length;i++)
          ironbrand.add(getHorses['ironBrandDropDown'][i]['name']);
        for(int i=0;i<getHorses['barnDropDown'].length;i++)
          barn.add(getHorses['barnDropDown'][i]['name']);
        for(int i=0;i<getHorses['breederDropDown'].length;i++)
          breeder.add(getHorses['breederDropDown'][i]['name']);
        for(int i=0;i<getHorses['vetDropDown'].length;i++)
          vet.add(getHorses['vetDropDown'][i]['name']);
        for(int i=0;i<getHorses['associationDropDown'].length;i++)
          association.add(getHorses['associationDropDown'][i]['name']);
        for(int i=0;i<getHorses['locationDropDown'].length;i++)
          location.add(getHorses['locationDropDown'][i]['name']);
        for(int i=0;i<getHorses['riderDropDown'].length;i++)
          rider.add(getHorses['riderDropDown'][i]['name']);
        for(int i=0;i<getHorses['inchargeDropDown'].length;i++)
          incharge.add(getHorses['inchargeDropDown'][i]['name']);
        for(int i=0;i<getHorses['colorDropDown'].length;i++)
          colors.add(getHorses['colorDropDown'][i]['name']);
        for(int i=0;i<getHorses['breedDropDown'].length;i++)
          breeding.add(getHorses['breedDropDown'][i]['name']);
        for(int i=0;i<getHorses['dietDropDown'].length;i++)
          diet.add(getHorses['dietDropDown'][i]['name']);
        for(int i=0;i<getHorses['horseCategoryDropDown'].length;i++)
          category.add(getHorses['horseCategoryDropDown'][i]['name']);
        for(int i=0;i<getHorses['headMarkingsDropDown'].length;i++)
          headmark.add(getHorses['headMarkingsDropDown'][i]['name']);
        for(int i=0;i<getHorses['bodyMarkingsDropDown'].length;i++)
          bodymark.add(getHorses['bodyMarkingsDropDown'][i]['name']);
        for(int i=0;i<getHorses['legMarkingsDropDown'].length;i++)
          legmark.add(getHorses['legMarkingsDropDown'][i]['name']);

//        print(gender.length.toString());
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


    if(horsedata != null) {
      if (horsedata['genderId'] == 1) {
        setState(() {
          intaial_gender_value = 'Male';
        });
      }
      else if (horsedata['genderId'] == 2) {
        setState(() {
          intaial_gender_value = 'Female';
        });
      }
      else if (horsedata['genderId'] == 3) {
        setState(() {
          intaial_gender_value = 'Geilding';
        });
      }
    }else{
      print("genderlist null a");
    }
    setState(() {
      print(horsedata);
       horseId = horsedata['horseId'];

       name.text = horsedata['name'];
    });

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Horse"),),
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
                          controller: name,

                          initialValue: horsedata['name'],
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
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          initialValue: DateTime.parse(horsedata['dateOfBirth']),
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Start Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            setState(() {
                              this.Select_date=value;
                            });

                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Gender",
                          initialValue: get_gender_info_by_id(horsedata['genderId']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Gender"),
                          items: gender.map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(name)))
                              .toList(),
                          onChanged: (value){

                            setState(() {
                              this.select_gender=value;
                              this.select_gender_id=gender.indexOf(value)+1;
                              print(select_gender_id);

                            });

                          },
                          onSaved: (value){
                            setState(() {
                              this.select_gender=value;
                              this.select_gender_id=gender.indexOf(value)+1;
                              print(select_gender_id);
                            });
                          },
//                          onChanged: (value){
//                            this.ddvalue=value;
//                            if(value=="Customized"){
//                              setState(() {
//                                _isvisible=true;
//                              });
//                            }else{
//                              setState(() {
//                                _isvisible=false;
//                              });
//                            }
//                          },
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Gender",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

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
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderDropdown(
                          initialValue: get_barn_by_id(horsedata['barnId']),
                          attribute: "Barn",
                          hint: Text("Barn"),
                          items: barn.map((name) => DropdownMenuItem(
                              value: name, child: Text(name)))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Barn",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_barn=value;
                              this.select_barn_id=barn.indexOf(value);
                            });

                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_barn=value;
                              this.select_barn_id=barn.indexOf(value);
                            });
                          },
                        ),
                      ),

//                      Padding(
//                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                        child:FormBuilderDateTimePicker(
//                          attribute: "date",
//                          style: Theme.of(context).textTheme.body1,
//                          inputType: InputType.date,
//                          validators: [FormBuilderValidators.required()],
//                          format: DateFormat("MM-dd-yyyy"),
//                          decoration: InputDecoration(labelText: "End Date",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(9.0),
//                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                            ),),
//                          onChanged: (value){
//                            this.End_Date=value.toString();
//                          },
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
//                        child:FormBuilderDateTimePicker(
//                          attribute: "date",
//                          style: Theme.of(context).textTheme.body1,
//                          inputType: InputType.date,
//                          validators: [FormBuilderValidators.required()],
//                          format: DateFormat("MM-dd-yyyy"),
//                          decoration: InputDecoration(labelText: "Target Date",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(9.0),
//                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                            ),),
//                          onChanged: (value){
//                            this.target_date=value.toString();
//                          },
//                        ),
//                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Breed",
                          hint: Text("Breed"),
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
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: number,
                          attribute: "Number",
                          decoration: InputDecoration(labelText: "Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: passport,
                          attribute: "Passpost#",
                          decoration: InputDecoration(labelText: "Passpost#",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(

                          controller: chip,
                          attribute: "Chip No",
                          decoration: InputDecoration(labelText: "Chip No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Color",
                          hint: Text("Color"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Category",
                          hint: Text("Category"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "sireName",
                          hint: Text("SirName"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "damName",
                          hint: Text("DamName"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Diet",
                          hint: Text("Diet"),
                          items: diet.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Diet",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_diet=value;
                            this.select_diet_id=diet.indexOf(value);
                          },
                        ),
                      ),
                      Text("Particular Marking",textScaleFactor: 2,),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "headMarking",
                          hint: Text("Head Marking"),
                          items: headmark.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Head Mark",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_headMark=value;
                            this.select_headmark_id=headmark.indexOf(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Leg",
                          hint: Text("Leg Mark"),
                          items: legmark.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Leg MArking",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_legMark=value;
                            this.select_legmark_id=legmark.indexOf(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "body",
                          hint: Text("Body Mark"),
                          items: bodymark.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "BodyMark",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_bodymark=value;
                            this.select_bodymark_id=bodymark.indexOf(value);
                          },
                        ),
                      ),
                      Text("More Information",textScaleFactor: 2,),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Breeder",
                          hint: Text("Breeder"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("Vet"),
                          items: vet.map((name) => DropdownMenuItem(
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
                            this.selected_vet=value;
                            this.select_vet_id=vet.indexOf(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("Location"),
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
                            this.selected_location_id=location.indexOf(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("IronBrand"),
                          items: ironbrand.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Iron Brand",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_ironbrand=value;
                            this.select_ironbrand_id=ironbrand.indexOf(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("Rider"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("Incharge"),
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
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          hint: Text("Association"),
                          items: association.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Association",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            this.selected_associate=value;
                            this.select_associate_id=association.indexOf(value);
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderTextField(
                          attribute: "DNA",
                          controller: dna,
                          decoration: InputDecoration(labelText: "DNA",
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
                    child:
                    Padding(
                      padding: const EdgeInsets.all(16),
//                      child: add_horse_button(fbKey: _fbKey,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,dateofbirth: Select_date,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id,headmarkid: select_headmark_id,bodymarkid: select_bodymark_id,legmarkid: select_legmark_id,dietid: select_diet_id,barnid: select_barn_id,ironbrandid:select_ironbrand_id,riderid: select_rider_id,inchargeid: select_incharge_id,associationid:select_associate_id,dna: name.text,genderlist: genderlist,getHorses:getHorses),
                      child: add_horse_button(fbKey: _fbKey,token: token,horseId: horseId,name: name ,select_gender_id: select_gender_id,genderlist: genderlist,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id,headmarkid: select_headmark_id,bodymarkid: select_bodymark_id,legmarkid: select_legmark_id,dietid: select_diet_id,barnid: select_barn_id,vetid: select_vet_id,breederid: select_breeder_id,locationid: selected_location_id,riderid: select_rider_id,inchargeid: select_incharge_id,associationid:select_associate_id,horselist: horsedata,dna: dna.text,),

//                      child: add_horse_button(fbKey: _fbKey,getHorses:getHorses,genderlist: genderlist,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,breedid: select_breed_id,categoryid: select_category_id,colorid: select_color_id,dateofbirth: Select_date,bodymarkid: select_bodymark_id,headmarkid: select_headmark_id,damid: select_dam_id,dietid: select_diet_id,barnid: select_barn_id,sireid: select_sire_id,dna: name.text,inchargeid: select_incharge_id,legmarkid: select_legmark_id,ironbrandid:select_associate_id,riderid: select_rider_id,),
                    )
//                      padding: const EdgeInsets.all(16),
//                      child: MaterialButton(
//                        color: Colors.teal,
//                        onPressed: (){
//
//                          if (_fbKey.currentState.validate()) {
//                            print(_fbKey.currentState.value);
//                            int id= genderlist!=null?get_gender_info_by_id(select_gender):'';
//                            print(id);
//                            Add_horse_services.horsesave(token,0,name.text,id,true).then((response){
//                              setState(() {
//                                var parsedjson  = jsonDecode(response);
//                                if(parsedjson != null){
//                                  if(parsedjson['isSuccess'] == true){
//                                    print("Successfully data save");
//                                  }else
//                                    print("not save");
//                                }else
//                                  print("json response null");
//                              });
//                            });
//
//
//                          }
//                        },
//                        child:Text("Add Horse",style: TextStyle(color: Colors.white),),
//                      ),
//                    )
                )
              ],
            )
          ],
        )
    );
  }
//
  String get_gender_info_by_id(int genderid){
    var gender_name;
    for(int i=0;i<genderlist.length;i++){
      if(genderlist[i]['id']==genderid){
        gender_name=genderlist[i]['name'];
      }
    }
    return gender_name;
  }
  String get_barn_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['barnDropDown']!=null&&id!=null){
      for(int i=0;i<barn.length;i++){
        if(getHorses['barnDropDown'][i]['id']==id){
          plan_name=getHorses['barnDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
}





class add_horse_button extends StatelessWidget {
  const add_horse_button({
     GlobalKey<FormBuilderState> fbKey,
     this.token,
     this.horseId,
     this.name,
     this.select_gender_id,
     this.genderlist,
     this.getHorses,
     this.number,
     this.passport,
     this.microchip,
     this.dateofbirth,
     this.colorid,
     this.breedid,
     this.categoryid,
     this.sireid,
     this.damid,
     this.headmarkid,
     this.bodymarkid,
     this.legmarkid,
     this.dietid,
     this.barnid,
     this.ironbrandid,
    this.locationid,
    this.vetid,
    this.breederid,
     this.riderid,
     this.inchargeid,
     this.associationid,
    this.horselist,
     this.dna,


     //@required this.gender_name,


  }) : _fbKey = fbKey, super();
  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final int select_gender_id,horseId;
  final TextEditingController name;
  final DateTime dateofbirth;
  final genderlist,getHorses;
  final horselist;
  final String number,passport,microchip,dna;
 // final int colorid,breedid,categoryid,sireid,damid;
  final int colorid,breedid,associationid,categoryid,sireid,damid,headmarkid,bodymarkid,legmarkid,dietid,ironbrandid,locationid,vetid,breederid,riderid,inchargeid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        //print(select_gender_id);
        print(token);
        print(horseId);
        print(name.text);
        print(dna);
        print(barnid);
        print(select_gender_id);
        print(number);
        print(passport);
        print(microchip);
       // print(getHorses['breedDropDown'][breedid]['id']);
       // print(getHorses['colorDropDown'][colorid]['id']);
         print(1);
      //  print(getHorses['inchargeDropDown'][inchargeid]['id']);
        print(getHorses['barnDropDown'][barnid]['id']);
       // print(getHorses['riderDropDown'][riderid]['id']);
        print(getHorses['dietDropDown'][dietid]['id']);
        print(getHorses['breedDropDown'][breedid]['id']);
        print(getHorses['horseCategoryDropDown'][categoryid]['id']);
        print(getHorses['legMarkingsDropDown'][legmarkid]['id']);
        print(getHorses['colorDropDown'][colorid]['id']);
//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
          _fbKey.currentState.save();
          Add_horse_services.horseupdate(horselist['createdBy'],token, horseId, name.text,3,number,passport,microchip,dateofbirth,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkingsDropDown'][bodymarkid]['id'],getHorses['legMarkingsDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['vetDropDown'][vetid]['id'],getHorses['breederDropDown'][breederid]['id'],getHorses['locationDropDown'][locationid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],getHorses['associationDropDown'][associationid]['id'],dna).then((

              response) {
            if (response != null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text("update horse Sucessfully"),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("horse not updated"),
              ));
            }
          });
        }
      },
      child:Text("Update Horse",style: TextStyle(color: Colors.white),),
    );
  }
}