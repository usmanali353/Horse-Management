import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:intl/intl.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';



class update_horse extends StatefulWidget{
  final token;
  var horsedata;

  update_horse (this.token,this.horsedata);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_horse_state(token,horsedata);
  }

}
class _update_horse_state extends State<update_horse>{
  final token;
  var horsedata;


  _update_horse_state (this.token,this.horsedata);
  int select_gender_id,select_barn_id,select_trainer_id,select_color_id,select_category_id,select_sire_id,select_dam_id,select_headmark_id;
  int select_legmark_id,select_bodymark_id,select_diet_id,select_breeder_id,select_vet_id,select_incharge_id,select_associate_id,select_rider_id;
  int select_breed_id,select_ironbrand_id,select_location_id;
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
  int horseId,barnid;
  String intaial_gender_value,createdBy;
  sqlite_helper local_db;
  var getinfo;
  bool _isvisible=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Future<void> initState()  {
    ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
    pd.show();
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
//
//    Add_horse_services.horseDashBoard(token,horsedata['horseId']).then((response){
//      pd.dismiss();
//      setState(() {
//        getinfo = jsonDecode(response);
//        print(getinfo['horseDetails']);
//        pd.dismiss();
//        _isvisible =true;
//      });
//    });


    Add_horse_services.horsesdropdown(token).then((response){
      setState(() {
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
       _isvisible =true;
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
          intaial_gender_value = 'Gielding';
        });
      }
    }else{
      intaial_gender_value = null;
      print("genderlist null a");
    }
    setState(() {
      print(horsedata);
       horseId = horsedata['horseId'];
       createdBy = horsedata['createdBy'];
       name.text = horsedata['name'];
       number.text = horsedata['number'] != null ?horsedata['number'].toString():null;
       passport.text = horsedata['passportNo'] != null ?horsedata['passportNo'].toString():null;
       chip.text = horsedata['microchipNo'] != null ? horsedata['microchipNo'].toString():null;
       dna.text = horsedata['horseDetails']['dna'] != null ? horsedata['horseDetails']['dna'].toString():null;
    });

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Horse"),),
        body: Visibility(
          visible: _isvisible,
          child: ListView(
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
                            initialValue: DateTime.parse(horsedata['dateOfBirth'] != null ? horsedata['dateOfBirth']:DateTime.now().toString()),
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
                            onSaved: (value){
                              setState(() {
                                this.Select_date = value;
                                print(Select_date);
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: FormBuilderDropdown(
                            attribute: "Gender",
                            //initialValue: get_gender_info_by_id(horsedata['genderId'] != null ? horsedata['genderId']:null),
                            initialValue: intaial_gender_value,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
                            items: gender.map((name) => DropdownMenuItem(
                                value: name,
                                child: Text(name)))
                                .toList(),
                            onChanged: (value){

                              setState(() {
                                this.select_gender=value;
                                this.select_gender_id=gender.indexOf(value)+1;

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

                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: FormBuilderDropdown(
                           initialValue:horsedata['barnId'] != null ? get_barn_by_id(horsedata['barnId']):null,
                            attribute: "Barn",
                            hint: Text("- Select -"),
                            items: barn.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Barn",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              this.selected_barn=value;
                              this.select_barn_id=barn.indexOf(value);
                            },
                            onSaved: (value){
                              this.selected_barn=value;
                              this.select_barn_id=barn.indexOf(value);
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
                           initialValue:horsedata['breedId'] != null ? horsedata['breedName']['name']:null,
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
                              setState(() {
                                this.selected_breed=value;
                                this.select_breed_id=breeding.indexOf(value);
                              });
                              },
                            onSaved: (value){
                              setState(() {
                                this.selected_breed=value;
                                this.select_breed_id=breeding.indexOf(value);
                              });
                              },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
                            controller: passport,
                            attribute: "Passport#",
                            decoration: InputDecoration(labelText: "Passport#",
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
                            keyboardType: TextInputType.number,
                            controller: chip,
                            attribute: "Chip#",
                            decoration: InputDecoration(labelText: "Chip#",
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
                            initialValue: horsedata['colorId'] != null ? horsedata['colorName']['name']:null,
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
                            onSaved: (value){
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
                           // initialValue: getinfo['categoryName']['name']!= null?getinfo['categoryName']['name']:Text(''),
                            initialValue: horsedata['horseCategoryId'] != null ? get_category_by_id(horsedata['horseCategoryId']):null,
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
                              setState(() {
                                this.selected_category=value;
                                this.select_category_id=category.indexOf(value);

                              });
                              },
                            onSaved: (value){
                              setState(() {
                                this.selected_category=value;
                                this.select_category_id=category.indexOf(value);

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "sireName",
                            initialValue: horsedata['sireId'] != null ? horsedata['sireName']['name']:null,
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
                              setState(() {
                                this.selected_sire=value;
                                this.select_sire_id=sire.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_sire=value;
                                this.select_sire_id=sire.indexOf(value);
                              });

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "damName",
                            initialValue: horsedata['damId'] != null ? horsedata['damName']['name']:null,
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
                              setState(() {
                                this.selected_dam=value;
                                this.select_dam_id=dam.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_dam=value;
                                this.select_dam_id=dam.indexOf(value);
                              });

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Diet",
                            //initialValue: horsedata['diet'] != null ? getinfo['dietName']['name']:null,
                            initialValue: horsedata['dietId'] != null ? get_diet_by_id(horsedata['dietId']):null ,
                            hint: Text("- Select -"),
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
                              setState(() {
                                this.selected_diet=value;
                                this.select_diet_id=diet.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_diet=value;
                                this.select_diet_id=diet.indexOf(value);
                              });

                            },
                          ),
                        ),
                        Text("Particular Marking",textScaleFactor: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "headMarking",
                            initialValue: horsedata['headmarkingId'] != null ? get_headmark_by_id(horsedata['headmarkingId']):null,
                            hint: Text("- Select -"),
                            items: headmark.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Head Marking",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_headMark=value;
                                this.select_headmark_id=headmark.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_headMark=value;
                                this.select_headmark_id=headmark.indexOf(value);
                              });

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Leg",
                            initialValue: horsedata['legmarkingId'] != null ? get_legmark_by_id(horsedata['legmarkingId']):null,
                            hint: Text("- Select -"),
                            items: legmark.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Leg Marking",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_legMark=value;
                                this.select_legmark_id=legmark.indexOf(value);
                              });

                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_legMark=value;
                                this.select_legmark_id=legmark.indexOf(value);
                              });

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "body",
                            //initialValue: getinfo['bodymarkingId'] != null ? getinfo['bodyMarkingName']['name']:null,
                            initialValue: horsedata['bodymarkingId'] != null ? get_bodymark_by_id(horsedata['bodymarkingId']):null,
                            hint: Text("- Select -"),
                            items: bodymark.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Body Marking",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_bodymark=value;
                                this.select_bodymark_id=bodymark.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_bodymark=value;
                                this.select_bodymark_id=bodymark.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Text("More Information",textScaleFactor: 2,),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Breeder",
                           // initialValue: getinfo['horseDetails']['breederId'] != null ? getinfo['horseDetail']['breederName']['contactName']['name']:null,
                           initialValue: horsedata['horseDetails']['breederId'] != null ? get_breeder_by_id(horsedata['horseDetails']['breederId']):null,
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
                              setState(() {
                                this.selected_breeder=value;
                                this.select_breeder_id=breeder.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_breeder=value;
                                this.select_breeder_id=breeder.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "vet",
                           // initialValue: getinfo['horseDetails']['vetId'] != null ? getinfo['horseDetails']['vetName']['contactName']['name']:null,
                            initialValue: horsedata['horseDetails']['vetId'] != null? get_vet_by_id(horsedata['horseDetails']['vetId']):null,
                            hint: Text("- Select -"),
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
                              setState(() {
                                this.selected_vet=value;
                                this.select_vet_id=vet.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_vet=value;
                                this.select_vet_id=vet.indexOf(value);
                              });
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "",
                          initialValue: horsedata['brandId']!= null? get_ironbrand_by_id(horsedata['brandId']):null,
                          hint: Text("- Select -"),
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
                            setState(() {
                              this.selected_ironbrand=value;
                              this.select_ironbrand_id=ironbrand.indexOf(value);
                              print(selected_ironbrand);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_ironbrand=value;
                              this.select_ironbrand_id=ironbrand.indexOf(value);
                              print(selected_ironbrand);
                            });
                          },
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "rider",
                           // initialValue: getinfo['horseDetails']['riderId'] != null ? getinfo['horseDetails']['riderName']['contactName']['name']:null,
                            initialValue: horsedata['horseDetails']['riderId']!= null? get_rider_by_id(horsedata['horseDetails']['riderId']):null,
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
                              setState(() {
                                this.selected_rider=value;
                                this.select_rider_id=rider.indexOf(value);

                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_rider=value;
                                this.select_rider_id=rider.indexOf(value);

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "incharge",
                            //initialValue: getinfo['horseDetails']['inchargeId'] != null ? getinfo['horseDetails']['inchargeName']['contactName']['name']:null,
                            initialValue: horsedata['horseDetails']['inchargeId']!= null? get_incharge_by_id(horsedata['horseDetails']['inchargeId']):null,
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
                             setState(() {
                               this.selected_incharge=value;
                               this.select_incharge_id=incharge.indexOf(value);
                             });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_incharge=value;
                                this.select_incharge_id=incharge.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "location",
                            hint: Text("- Select -"),
                            initialValue: horsedata['horseDetails']['locationId']!= null? get_location_by_id(horsedata['horseDetails']['locationId']):null,
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
                             setState(() {
                               this.selected_location=value;
                               this.select_location_id=location.indexOf(value);
                             });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_location=value;
                                this.select_location_id=location.indexOf(value);

                              });},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "associ",
                            initialValue: horsedata['horseDetails']['associationId']!= null? get_association_by_id(horsedata['horseDetails']['associationId']):null,
                            //initialValue: horsedata['horseDetails']['associationId'] != null ?getinfo['horseDetails']['associationName']['name']:null,
                            hint: Text("- Select -"),
                            items: association.map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Associations",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_associate=value;
                                this.select_associate_id=association.indexOf(value);
                              });
                              },
                            onSaved: (value){
                              setState(() {
                                this.selected_associate=value;
                                this.select_associate_id=association.indexOf(value);
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: dna,
                            attribute: "DNA",
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
                        child: add_horse_button(fbKey: _fbKey,token: token,createdBy: createdBy,horseId: horseId,name: name ,select_gender_id: select_gender_id,genderlist: genderlist,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id,headmarkid: select_headmark_id,legmarkid: select_legmark_id,bodymarkid: select_bodymark_id,barnid: select_barn_id,dietid: select_diet_id,breederid: select_breeder_id,vetid: select_vet_id,riderid: select_rider_id,inchargeid: select_incharge_id,ironbrandid: select_ironbrand_id,associationid: select_associate_id ,locationid: select_location_id,dna: dna.text),

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
          ),
        )
    );
  }

  String get_gender_info_by_id(int genderid){
    var gender_name;
    if(horsedata!=null&&genderlist!=null&&genderid!=null)
    for(int i=0;i<gender.length;i++){
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

  String get_legmark_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['legMarkingsDropDown']!=null&&id!=null){
      for(int i=0;i<legmark.length;i++){
        if(getHorses['legMarkingsDropDown'][i]['id']==id){
          plan_name=getHorses['legMarkingsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_bodymark_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['bodyMarkingsDropDown']!=null&&id!=null){
      for(int i=0;i<bodymark.length;i++){
        if(getHorses['bodyMarkingsDropDown'][i]['id']==id){
          plan_name=getHorses['bodyMarkingsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }

  String get_headmark_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['headMarkingsDropDown']!=null&&id!=null){
      for(int i=0;i<headmark.length;i++){
        if(getHorses['headMarkingsDropDown'][i]['id']==id){
          plan_name=getHorses['headMarkingsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_diet_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['dietDropDown']!=null&&id!=null){
      for(int i=0;i<diet.length;i++){
        if(getHorses['dietDropDown'][i]['id']==id){
          plan_name=getHorses['dietDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['horseCategoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(getHorses['horseCategoryDropDown'][i]['id']==id){
          plan_name=getHorses['horseCategoryDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_breeder_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['breederDropDown']!=null&&id!=null){
      for(int i=0;i<breeder.length;i++){
        if(getHorses['breederDropDown'][i]['id']==id){
          plan_name=getHorses['breederDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_vet_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['vetDropDown']!=null&&id!=null){
      for(int i=0;i<vet.length;i++){
        if(getHorses['vetDropDown'][i]['id']==id){
          plan_name=getHorses['vetDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_rider_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['riderDropDown']!=null&&id!=null){
      for(int i=0;i<rider.length;i++){
        if(getHorses['riderDropDown'][i]['id']==id){
          plan_name=getHorses['riderDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_incharge_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['inchargeDropDown']!=null&&id!=null){
      for(int i=0;i<incharge.length;i++){
        if(getHorses['inchargeDropDown'][i]['id']==id){
          plan_name=getHorses['inchargeDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_association_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['associationDropDown']!=null&&id!=null){
      for(int i=0;i<association.length;i++){
        if(getHorses['associationDropDown'][i]['id']==id){
          plan_name=getHorses['associationDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_location_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['locationDropDown']!=null&&id!=null){
      for(int i=0;i<location.length;i++){
        if(getHorses['locationDropDown'][i]['id']==id){
          plan_name=getHorses['locationDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_ironbrand_by_id(int id){
    var plan_name;
    if(horsedata!=null&&getHorses['ironBrandDropDown']!=null&&id!=null){
      for(int i=0;i<ironbrand.length;i++){
        if(getHorses['ironBrandDropDown'][i]['id']==id){
          plan_name=getHorses['ironBrandDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }

}





class add_horse_button extends StatelessWidget {
  const add_horse_button({
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.token,
    @required this.createdBy,
    @required this.horseId,
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
    this.vetid,
    this.breederid,
    this.locationid,
     this.riderid,
     this.inchargeid,
     this.associationid,
     this.dna,


     //@required this.gender_name,


  }) : _fbKey = fbKey, super();
  final String token,createdBy;
  final GlobalKey<FormBuilderState> _fbKey;
  final int select_gender_id,horseId;
  final TextEditingController name;
  final DateTime dateofbirth;
  final genderlist,getHorses;

  final String number,passport,microchip,dna;
  final int colorid,breedid,categoryid,sireid,damid,vetid,breederid,locationid;
  final int associationid,headmarkid,bodymarkid,legmarkid,dietid,ironbrandid,riderid,inchargeid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        //print(select_gender_id);
        print(dateofbirth);
        print(select_gender_id);
        print(getHorses['barnDropDown'][barnid]['id']);
        print(number);
        print(passport);
        print(microchip);
        print(horseId.toString());
        print(getHorses['damDropDown'][damid]['id']);
        print(getHorses['sireDropDown'][sireid]['id']);
        print(getHorses['horseCategoryDropDown'][categoryid]['id']);
        print("abc");
        print(getHorses['headMarkingsDropDown'][headmarkid]['id']);
        print(getHorses['dietDropDown'][dietid]['id']);
        print(getHorses['riderDropDown'][riderid]['id']);
        print(riderid);
        print(getHorses['associationDropDown'][associationid]['id']);
        print(dna);
        print(legmarkid);
        print(locationid);
        print("abc");
        print(getHorses['locationDropDown'][locationid]['id']);
        print(getHorses['barnDropDown'][barnid]['id']);
        print(getHorses['legMarkingsDropDown'][legmarkid]['id']);
        print(ironbrandid);

        print("End");
//        print(getHorses['colorDropDown'][colorid]['id']);
//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
          _fbKey.currentState.save();
//          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((
       // ,getHorses['headMarkDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],riderid,inchargeid,associtaionid
          Add_horse_services.horseupdate(token,createdBy,horseId , name.text,select_gender_id, true,number,passport,microchip,dateofbirth,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkingsDropDown'][bodymarkid]['id'],getHorses['legMarkingsDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['vetDropDown'][vetid]['id'],getHorses['breederDropDown'][breederid]['id'],getHorses['locationDropDown'][locationid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],getHorses['associationDropDown'][associationid]['id'],dna).then((
              response) {
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
      child:Text("Update Horse",style: TextStyle(color: Colors.white),),
    );
  }
}