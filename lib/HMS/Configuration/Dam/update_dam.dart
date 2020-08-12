import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_json.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_json.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:horse_management/main.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class update_dam extends StatefulWidget{
  String token;
  var specificdam;

  update_dam(this.token, this.specificdam);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_dam(token,specificdam);
  }
}



class _update_dam extends State<update_dam>{
  String token;
  var specificdam;
  _update_dam(this.token, this.specificdam);
  int select_gender_id,select_barn_id,select_trainer_id,select_color_id,select_category_id,select_sire_id,select_dam_id,select_headmark_id;
  int select_legmark_id,select_bodymark_id,select_diet_id,select_breeder_id,select_vet_id,select_incharge_id,select_associate_id,select_rider_id;
  int select_breed_id,select_ironbrand_id;

  String select_gender,selected_barn,selected_trainer,selected_color,selected_category,selected_sire,selected_dam,selected_headMark,selected_legMark;
  String selected_diet,selected_ironbrand,selected_,selected_breeder,selected_vet,selected_incharge,selected_associate,selected_rider,selected_breed,selected_bodymark;
  DateTime Select_date = DateTime.now();
  TextEditingController name,number,chip,passport,dna;

  // sqlite_helper local_db;
  List<String> barn = [], gender=[], breed=[],  color=[], category=[], sire=[], dam=[], diet=[];
  List<String> headmark=[], bodymark=[], legmark=[], ironbrand=[];
  List<String> breeder=[], vet=[], rider=[], location=[], incharge=[], association=[];
  DateTime select_DOB;
  var dam_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  var getHorses,genderlist;
  int horseId,barnid;
  String intaial_gender_value;
  var getinfo;
  bool dam_loaded=false;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  var breed_name,color_name;
  @override
  void initState() {
    name= TextEditingController();
    number= TextEditingController();
    chip= TextEditingController();
    dna= TextEditingController();
    passport= TextEditingController();
    setState(() {
      if(specificdam['name']!=null){
        name.text=specificdam['name'];
      }
      if(specificdam['number']!=null){
        number.text=specificdam['number'];
      }
      if(specificdam['microchipNo']!=null){
        chip.text=specificdam['microchipNo'];
      }
    });
    DamServices.get_Dam_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          getHorses=json.decode(response);
          print(dam_response);
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
            color.add(getHorses['colorDropDown'][i]['name']);
          for(int i=0;i<getHorses['breedDropDown'].length;i++)
            breed.add(getHorses['breedDropDown'][i]['name']);
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
        });
      }else{

      }
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
    super.initState();
  }
  String get_breed_by_id(int id){
    var breed_name;
    if(specificdam!=null&&dam_response['breedDropDown']!=null&&id!=null){
      for(int i=0;i<breed.length;i++){
        if(dam_response['breedDropDown'][i]['id']==id){
          breed_name=dam_response['breedDropDown'][i]['name'];
        }
      }
      return breed_name;
    }else
      return null;
  }
  String get_color_by_id(int id){
    var color_name;
    if(specificdam!=null&&dam_response['colorDropDown']!=null&&id!=null){
      for(int i=0;i<color.length;i++){
        if(dam_response['colorDropDown'][i]['id']==id){
          color_name=dam_response['colorDropDown'][i]['name'];
        }
      }
      return color_name;
    }else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Sire"),),
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
                            child: FormBuilderTextField(
                              controller: name,
                              attribute: "Sire Name",
                              validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Sire Name",
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
                              //initialValue: DateTime.parse(horsedata['dateOfBirth'] != null ? horsedata['dateOfBirth']:DateTime.now().toString()),
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
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Gender",
                              // initialValue: get_gender_info_by_id(horsedata['genderId'] != null ? horsedata['genderId']:null),
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

                                });

                              },
                              onSaved: (value){
                                setState(() {
                                  this.select_gender=value;
                                  this.select_gender_id=gender.indexOf(value)+1;

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
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              //initialValue:horsedata['barnId'] != null ? get_barn_by_id(barnid):Text(""),
                              attribute: "Barn",
                              hint: Text("Barn"),
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
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Breed",
                              //initialValue:horsedata['breedId'] != null ? horsedata['breedName']['name']:Text(''),
                              hint: Text("Breed"),
                              items: breed.map((name) => DropdownMenuItem(
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
                                this.select_breed_id=breed.indexOf(value);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
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
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderTextField(
                              keyboardType: TextInputType.number,
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
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderTextField(
                              keyboardType: TextInputType.number,
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
                              //initialValue: horsedata['colorId'] != null ? horsedata['colorName']['name']:Text(''),
                              hint: Text("Color"),
                              items: color.map((name) => DropdownMenuItem(
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
                                  this.select_color_id=color.indexOf(value);
                                });

                              },
                              onSaved: (value){
                                setState(() {
                                  this.selected_color=value;
                                  this.select_color_id=color.indexOf(value);
                                });

                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Category",
                              // initialValue: getinfo['categoryName']['name']!= null?getinfo['categoryName']['name']:Text(''),
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
                              // initialValue: horsedata['sireId'] != null ? horsedata['sireName']['name']:null,
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
                              //initialValue: horsedata['damId'] != null ? horsedata['damName']['name']:null,
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
                          Padding(
                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                              child: Text("Particular Marking",textScaleFactor: 2, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), )),
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "headMarking",
                              // initialValue: getinfo['headmarkingId'] != null ? getinfo['headMarkingName']['name']:null,
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
                              //initialValue: getinfo['legmarkingId'] != null ? getinfo['legMarkingName']['name']:null,
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
                          Padding(
                              padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                              child: Text("More Information",textScaleFactor: 2, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Breeder",
                              // initialValue: getinfo['horseDetails']['breederId'] != null ? getinfo['horseDetail']['breederName']['contactName']['name']:null,
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
                              //initialValue: getinfo['horseDetails']['vetId'] != null ? getinfo['horseDetails']['vetName']['contactName']['name']:null,
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
                              attribute: "rider",
                              //initialValue: getinfo['horseDetails']['riderId'] != null ? getinfo['horseDetails']['riderName']['contactName']['name']:null,
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
                              attribute: "associ",
                              // initialValue: horsedata['horseDetails']['associationId'] != null ?getinfo['horseDetails']['associationName']['name']:null,
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
                            padding: EdgeInsets.only(left: 16,right: 16, top: 16),
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
                    Builder(
                      builder: (BuildContext context){
                        return Center(
                            child:Padding(
                                padding: EdgeInsets.only(top:16,left: 16,right: 16),
                                child:MaterialButton(
                                  color: Colors.teal,
                                  child: Text("Update",style: TextStyle(color: Colors.white),),
                                  onPressed: (){
                                    if (_fbKey.currentState.validate()) {
                                      _fbKey.currentState.save();
                                      print(specificdam['horseId']);
                                      print(specificdam['createdBy']);
                                      Utils.check_connectivity().then((result){
                                        if(result){
                                          ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                          pd.show();
                                          //SireServices.addSire(token, specificdam['horseId'], name.text,2,specificdam['createdBy'],dam_response['breedDropDown'][selected_breed_id]['id'],select_DOB, dam_response['colorDropDown'][selected_color_id]['id'], number.text, microchip.text)
                                          DamServices.dam_update(specificdam['createdBy'], token, specificdam['horseId'], name.text, select_gender_id, true, number.text,passport.text,chip.text,Select_date,getHorses['colorDropDown'][select_color_id]['id'],getHorses['breedDropDown'][select_breed_id]['id'],getHorses['horseCategoryDropDown'][select_category_id]['id'],getHorses['sireDropDown'][select_sire_id]['id'],getHorses['damDropDown'][select_dam_id]['id'],dna.text)
                                              .then((respons){
                                            pd.dismiss();
                                            if(respons!=null){
                                              Navigator.pop(context);
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text("Dam Updated Successfully",
                                                  style: TextStyle(
                                                      color: Colors.red
                                                  ),
                                                ),
                                                backgroundColor: Colors.green,
                                              ));
                                              Navigator.pop(context);
                                            }else{
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text("Sire Updated Failed",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          });
                                        }
                                      });
                                    }
                                  },
                                )
                            )
                        );
                      },

                    )
                  ],
                )
              ]
          ),
        )
    );
  }

}

