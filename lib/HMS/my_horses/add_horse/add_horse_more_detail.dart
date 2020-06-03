import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:progress_dialog/progress_dialog.dart';



class add_horseDetial extends StatefulWidget{
  final token;
  DateTime dateOfBirth;
  String name,number,microchip;
  int genderId,colorId,breedId,sireId,damId,barnId,vetId,breederId;
  add_horseDetial (this.token,this.name,this.dateOfBirth,this.genderId,this.number,this.microchip,this.colorId,this.breedId,this.sireId,this.damId,this.barnId,this.vetId,this.breederId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(token,name,dateOfBirth,genderId,number,microchip,colorId,breedId,sireId,damId,barnId,vetId,breederId);
  }

}
class _add_horse_state extends State<add_horseDetial>{
  final token;

  _add_horse_state (this.token,this.name,this.dateOfBirth,this.genderId,this.number,this.microchip,this.colorId,this.breedId,this.sireId,this.damId,this.barnId,this.vetId,this.breederId);
  DateTime dateOfBirth;
  String name,number,microchip;
  int genderId,colorId,breedId,sireId,damId,barnId,vetId,breederId;
  int select_trainer_id,select_category_id,select_headmark_id;
  int select_legmark_id,select_bodymark_id,select_diet_id,select_incharge_id,select_associate_id,select_rider_id;
  int select_ironbrand_id,select_location_id;
  String selected_trainer,selected_category,selected_headMark,selected_legMark;
  String selected_diet,selected_ironbrand,selected_location,selected_incharge,selected_associate,selected_rider,selected_bodymark;

  TextEditingController chip,passport,dna;
//   var colorlist,genderlist,genderidlist,barnlist,sirelist,categorylist,damlist,breedlist,dietlist,headmarklist,bodymarklist,legmarklist,ironbrandlist,breederlist,vetlist;
//   var riderlist,inchargelist,locationlist,associationlist;
  List<String> category=[];
  List<String> diet=[];List<String> headmark=[];List<String> bodymark=[];List<String> legmark=[];List<String> ironbrand=[];
  List<String> rider=[];List<String> location=[];List<String> incharge=[];List<String> association=[];
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

              for(int i=0;i<getHorses['ironBrandDropDown'].length;i++)
                ironbrand.add(getHorses['ironBrandDropDown'][i]['name']);
              for(int i=0;i<getHorses['associationDropDown'].length;i++)
                association.add(getHorses['associationDropDown'][i]['name']);
              for(int i=0;i<getHorses['locationDropDown'].length;i++)
                location.add(getHorses['locationDropDown'][i]['name']);
              for(int i=0;i<getHorses['riderDropDown'].length;i++)
                rider.add(getHorses['riderDropDown'][i]['name']);
              for(int i=0;i<getHorses['inchargeDropDown'].length;i++)
                incharge.add(getHorses['inchargeDropDown'][i]['name']);
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



        }else{
          setState(() {
            print("offline");
            genderlist = Hive.box("AddHorseDropDown").get("offline_gender_dropdowns");
            getHorses = Hive.box("AddHorseDropDown").get("offline_horse_dropdowns");
            for(int i=0;i<getHorses['ironBrandDropDown'].length;i++)
              ironbrand.add(getHorses['ironBrandDropDown'][i]['name']);
            for(int i=0;i<getHorses['associationDropDown'].length;i++)
              association.add(getHorses['associationDropDown'][i]['name']);
            for(int i=0;i<getHorses['locationDropDown'].length;i++)
              location.add(getHorses['locationDropDown'][i]['name']);
            for(int i=0;i<getHorses['riderDropDown'].length;i++)
              rider.add(getHorses['riderDropDown'][i]['name']);
            for(int i=0;i<getHorses['inchargeDropDown'].length;i++)
              incharge.add(getHorses['inchargeDropDown'][i]['name']);
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
        appBar: AppBar(title: Text("More Details"),),
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
                      child: add_horse_button(fbKey: _fbKey,select_gender_id:genderId,name: name ,token: token,number: number,passport: passport.text,microchip: microchip,dateofbirth: dateOfBirth,colorid: colorId,breedid: breedId,categoryid: select_category_id,sireid: sireId,damid: damId,headmarkid: select_headmark_id,bodymarkid: select_bodymark_id,legmarkid: select_legmark_id,dietid: select_diet_id,barnid: barnId,vetid: vetId,breederid: breederId,locationid: select_location_id,riderid: select_rider_id,inchargeid: select_incharge_id,associationid:select_associate_id,dna: dna.text,genderlist: genderlist,getHorses:getHorses),
                      // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),

//                      child: add_horse_button(fbKey: _fbKey,getHorses:getHorses,genderlist: genderlist,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,breedid: select_breed_id,categoryid: select_category_id,colorid: select_color_id,dateofbirth: Select_date,bodymarkid: select_bodymark_id,headmarkid: select_headmark_id,damid: select_dam_id,dietid: select_diet_id,barnid: select_barn_id,sireid: select_sire_id,dna: name.text,inchargeid: select_incharge_id,legmarkid: select_legmark_id,ironbrandid:select_associate_id,riderid: select_rider_id,),
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

  final DateTime dateofbirth;
  final genderlist,getHorses;
  final String number,passport,microchip,dna,name;
  final int colorid,breedid,categoryid,sireid,damid;
  final int associationid,headmarkid,bodymarkid,legmarkid,dietid,riderid,inchargeid,locationid,vetid,breederid,barnid;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: (){
        print(dateofbirth);
        print(dna);
        print(select_gender_id);
        print(number);
        print(passport);
        print(microchip);
        print(breedid);
        print(damid);
        print(getHorses['inchargeDropDown'][inchargeid]['id']);
        print(barnid);
        print(getHorses['riderDropDown'][riderid]['id']);
        print(getHorses['dietDropDown'][dietid]['id']);
        print(breedid);
        print(getHorses['horseCategoryDropDown'][categoryid]['id']);
        print(colorid);
        print(vetid);
//        //print(colorlist['colors']);
//        print(genderlist[select_gender_id]['id']);
        if (_fbKey.currentState.validate()) {
//          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((

          Add_horse_services.horsesave(token, 0, name,select_gender_id, true,number,passport,microchip,dateofbirth,colorid,breedid,getHorses['horseCategoryDropDown'][categoryid]['id'],sireid,damid,getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkingsDropDown'][bodymarkid]['id'],getHorses['legMarkingsDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],barnid,vetid,breederid,getHorses['locationDropDown'][locationid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],getHorses['associationDropDown'][associationid]['id'],dna).then((
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