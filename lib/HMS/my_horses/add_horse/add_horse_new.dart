import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:intl/intl.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';



class add_newHorse extends StatefulWidget{
  final token;

  add_newHorse (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(token);
  }

}
class _add_horse_state extends State<add_newHorse>{
 final token;


 _add_horse_state (this.token);
  int select_gender_id,select_barn_id,select_trainer_id,select_color_id,select_category_id,select_sire_id,select_dam_id,select_headmark_id;
  int select_legmark_id,select_bodymark_id,select_diet_id,select_breeder_id,select_vet_id,select_incharge_id,select_associate_id,select_rider_id;
  int select_breed_id,select_ironbrand_id,select_location_id;
 String select_gender,selected_barn,selected_trainer,selected_color,selected_category,selected_sire,selected_dam,selected_headMark,selected_legMark;
  String selected_diet,selected_ironbrand,selected_,selected_breeder,selected_vet,selected_location,selected_incharge,selected_associate,selected_rider,selected_breed,selected_bodymark;
  DateTime Select_date = DateTime.now();
  TextEditingController name,number,chip,passport,dna;
//   var colorlist,genderlist,genderidlist,barnlist,sirelist,categorylist,damlist,breedlist,dietlist,headmarklist,bodymarklist,legmarklist,ironbrandlist,breederlist,vetlist;
//   var riderlist,inchargelist,locationlist,associationlist;
  List<String> gender=[];List<String> genderid=[];List<String> colors=[];List<String> barn=[];List<String> sire=[];List<String> category=[];List<String> dam=[];
  List<String> breeding=[];List<String> diet=[];List<String> headmark=[];List<String> bodymark=[];List<String> legmark=[];List<String> ironbrand=[];
  List<String> breeder=[];List<String> vet=[];List<String> rider=[];List<String> location=[];List<String> incharge=[];List<String> association=[];
  var getHorses,genderlist;

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
    passport= TextEditingController();
    dna= TextEditingController();

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
//        for(int i=0;i<getHorses['locationDropDown'].length;i++)
//          location.add(getHorses['locationDropDown'][i]['name']);

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
//    Add_horse_services.colors(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        colorlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<colorlist.length;i++)
//          colors.add(colorlist[i]['name']);
//        print(colors.length.toString());
//      });
//    });
//    Add_horse_services.barns(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        barnlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<barnlist.length;i++)
//          barn.add(barnlist[i]['name']);
//        print(barn.length.toString());
//      });
//    });
//    Add_horse_services.sire(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        sirelist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<sirelist.length;i++)
//          sire.add(sirelist[i]['name']);
//        print(sire.length.toString());
//      });
//    });
//    Add_horse_services.dam(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        damlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<damlist.length;i++)
//          dam.add(damlist[i]['name']);
//        print(dam.length.toString());
//      });
//    });
//    Add_horse_services.diet(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        dietlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<dietlist.length;i++)
//          diet.add(dietlist[i]['name']);
//        print(diet.length.toString());
//      });
//    });
//    Add_horse_services.breed(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        breedlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<breedlist.length;i++)
//          breeding.add(breedlist[i]['name']);
//        print(colors.length.toString());
//      });
//    });
//    Add_horse_services.headmarking(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        headmarklist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<headmarklist.length;i++)
//          headmark.add(headmarklist[i]['name']);
//        print(headmark.length.toString());
//      });
//    });
//    Add_horse_services.bodymarking(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        bodymarklist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<bodymarklist.length;i++)
//          bodymark.add(bodymarklist[i]['name']);
//        print(colors.length.toString());
//      });
//    });
//    Add_horse_services.legmarking(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        legmarklist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<legmarklist.length;i++)
//          legmark.add(legmarklist[i]['name']);
//        print(legmark.length.toString());
//      });
//    });
//    Add_horse_services.ironbrand(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        ironbrandlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<ironbrandlist.length;i++)
//          ironbrand.add(ironbrandlist[i]['name']);
//        print(ironbrand.length.toString());
//      });
//    });
//    Add_horse_services.breeder(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        breederlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<breederlist.length;i++)
//          breeder.add(breederlist[i]['name']);
//        print(breeder.length.toString());
//      });
//    });
//    Add_horse_services.vet(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        vetlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<vetlist.length;i++)
//          vet.add(vetlist[i]['name']);
//        print(vet.length.toString());
//      });
//    });
//    Add_horse_services.rider(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        riderlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<riderlist.length;i++)
//          rider.add(riderlist[i]['name']);
//        print(rider.length.toString());
//      });
//    });
//    Add_horse_services.location(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        locationlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<locationlist.length;i++)
//          location.add(locationlist[i]['name']);
//        print(location.length.toString());
//      });
//    });
//    Add_horse_services.incharge(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        inchargelist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<inchargelist.length;i++)
//          incharge.add(inchargelist[i]['name']);
//        print(incharge.length.toString());
//      });
//    });
//    Add_horse_services.association(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        associationlist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<associationlist.length;i++)
//          association.add(associationlist[i]['name']);
//        print(association.length.toString());
//      });
//    });
//    Add_horse_services.horsecategory(token).then((response){
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        categorylist  = jsonDecode(response);
//        print(response);
//
//        for(int i=0;i<categorylist.length;i++)
//          category.add(categorylist[i]['name']);
//        print(category.length.toString());
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Horse"),),
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
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Gender"),
                          items: gender.map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(name)))
                              .toList(),
                          onChanged: (value){

                            setState(() {
                              this.select_gender=value;
                              this.select_gender_id=gender.indexOf(value);

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

                          attribute: "Barn",
                          hint: Text("Barn"),
                          items: barn.map((name) => DropdownMenuItem(
                              value: name, child: Text("name")))
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
                          decoration: InputDecoration(labelText: "Vet",
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
                      child: add_horse_button(fbKey: _fbKey,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,dateofbirth: Select_date,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id,headmarkid: select_headmark_id,bodymarkid: select_bodymark_id,legmarkid: select_legmark_id,dietid: select_diet_id,barnid: select_barn_id,vetid: select_vet_id,breederid: select_breeder_id,locationid: select_location_id,riderid: select_rider_id,inchargeid: select_incharge_id,associationid:select_associate_id,dna: dna.text,genderlist: genderlist,getHorses:getHorses),
                     // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),

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
     this.select_gender_id,
     this.number,
     this.passport,
     this.microchip,
     this.dateofbirth,
     this.genderlist,
     this.getHorses,
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
    this.locationid,
    this.vetid,
    this.breederid,
    this.riderid,
     this.inchargeid,
     this.associationid,
     this.dna,
   //  this.gender_name,


  }) : _fbKey = fbKey, super();
  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final int select_gender_id;
  final TextEditingController name;
  final DateTime dateofbirth;
  final genderlist,getHorses;
  final String number,passport,microchip,dna;
  final int colorid,breedid,categoryid,sireid,damid;
   final int associationid,headmarkid,bodymarkid,legmarkid,dietid,riderid,inchargeid,locationid,vetid,breederid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        print(dateofbirth);
        //print(getHorses['headMarkingsDropDown'][headmarkid]['id']);
      // print(getHorses['legMarkingsDropDown'][legmarkid]['id']);
        print(dna);
        print(select_gender_id);
        print(number);
        print(passport);
        print(microchip);
        print(getHorses['breedDropDown'][breedid]['id']);
        print(getHorses['colorDropDown'][colorid]['id']);
        print(getHorses['damDropDown'][damid]['id']);
        print(getHorses['inchargeDropDown'][inchargeid]['id']);
        print(getHorses['barnDropDown'][barnid]['id']);
        print(getHorses['riderDropDown'][riderid]['id']);
        print(getHorses['dietDropDown'][dietid]['id']);
        print(getHorses['breedDropDown'][breedid]['id']);
        print(getHorses['horseCategoryDropDown'][categoryid]['id']);

//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
//          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((

              Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,number,passport,microchip,dateofbirth,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkingsDropDown'][bodymarkid]['id'],getHorses['legMarkingsDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['vetDropDown'][vetid]['id'],getHorses['breederDropDown'][breederid]['id'],getHorses['locationDropDown'][locationid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],getHorses['associationDropDown'][associationid]['id'],dna).then((
              response) {
            if (response != null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text("Training Added Sucessfully"),
              ));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Training not Added"),
              ));
            }
          });
        }
      },
      child:Text("Add Horse",style: TextStyle(color: Colors.white),),
    );
  }
}