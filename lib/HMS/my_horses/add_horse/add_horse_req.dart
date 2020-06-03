import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/HMS/my_horses/add_horse/add_horse_more_detail.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:progress_dialog/progress_dialog.dart';



class add_HorseNew extends StatefulWidget{
  final token;

  add_HorseNew (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(token);
  }

}
class _add_horse_state extends State<add_HorseNew>{
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
    Utils.openBox("AddHorseDropDown").then((resp){
      Utils.check_connectivity().then((result) {
        if (result) {
          ProgressDialog pd = ProgressDialog(
              context, type: ProgressDialogType.Normal, isDismissible: true);
          pd.show();
          Add_horse_services.horsesdropdown(token).then((response){
            pd.dismiss();
            setState(() {
              //genderlist  = jsonDecode(response);
              print(response);
              print("online");

              getHorses=json.decode(response);
              Hive.box("AddHorseDropDown").put("offline_horse_dropdowns", getHorses);
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
              Hive.box("AddHorseDropDown").put("offline_gender_dropdowns", genderlist);

              print(response);

              for(int i=0;i<genderlist.length;i++){
                gender.add(genderlist[i]['name']);
              }
              print(gender.length.toString());
            });
          });

        }else{
          setState(() {
            print("offline");
            genderlist = Hive.box("AddHorseDropDown").get("offline_gender_dropdowns");
            getHorses = Hive.box("AddHorseDropDown").get("offline_horse_dropdowns");
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
            for(int i=0;i<genderlist.length;i++) {
              gender.add(genderlist[i]['name']);
            }
            print("offline");
          });
        }
      });
    });


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
                        ),
                      ),

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

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: add_horse_button(fbKey: _fbKey,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,microchip: passport.text,dateofbirth: Select_date,colorid: select_color_id,breedid: select_breed_id,sireid: select_sire_id,damid: select_dam_id,barnid: select_barn_id,vetid: select_vet_id,breederid: select_breeder_id,genderlist: genderlist,getHorses:getHorses),
                      // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),
                    ),
                    MaterialButton(color: Colors.teal,onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => add_horseDetial(token, name.text,Select_date,genderlist[select_gender_id]['id'],number.text,chip.text,getHorses['colorDropDown'][select_color_id]['id'],getHorses['breedDropDown'][select_breed_id]['id'],getHorses['sireDropDown'][select_sire_id]['id'],getHorses['damDropDown'][select_dam_id]['id'],
                            getHorses['barnDropDown'][select_barn_id]['id'],getHorses['vetDropDown'][select_vet_id]['id'],getHorses['breederDropDown'][select_breeder_id]['id'])));
                      }, child: Row(children: <Widget>[
                      Text("Add More"),
                      Icon(Icons.arrow_forward),
                    ], ),)
                ]),

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
    this.microchip,
    this.dateofbirth,
    this.genderlist,
    this.getHorses,
    this.colorid,
    this.breedid,
    this.sireid,
    this.damid,
    this.barnid,
    this.vetid,
    this.breederid,
    //  this.gender_name,


  }) : _fbKey = fbKey, super();
  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final int select_gender_id;
  final TextEditingController name;
  final DateTime dateofbirth;
  final genderlist,getHorses;
  final String number,microchip;
  final int colorid,breedid,sireid,damid;
  final int vetid,breederid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        print(dateofbirth);
        print(select_gender_id);
        print(number);
        print(microchip);
        print(getHorses['breedDropDown'][breedid]['id']);
        print(getHorses['colorDropDown'][colorid]['id']);
        print(getHorses['damDropDown'][damid]['id']);

        print(getHorses['breedDropDown'][breedid]['id']);

//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
//          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((

          Add_horse_services.horsesaveReq(token, 0, name.text,genderlist[select_gender_id]['id'], true,number,microchip,dateofbirth,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['vetDropDown'][vetid]['id'],getHorses['breederDropDown'][breederid]['id']).then((
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
      child:Text("Add Horse",style: TextStyle(color: Colors.white,),),
    );
  }
}