import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:intl/intl.dart';
import 'horsegroup_services.dart';


class add_HorseToGroup extends StatefulWidget{
  String token;
  int groupId;

  add_HorseToGroup (this.token,this.groupId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_state(token,groupId);
  }

}
class _add_horse_state extends State<add_HorseToGroup>{
  String token;
  int groupid;
  _add_horse_state (this.token,this.groupid);
String Select_horse;int select_horse_id;
  List<String> horse=[];
  var getHorses;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Future<void> initState()  {

    labtest_services.labdropdown(token).then((response){
      setState(() {
        print(response);
        getHorses=json.decode(response);
        for(int i=0;i<getHorses['horseDropDown'].length;i++)
          horse.add(getHorses['horseDropDown'][i]['name']);

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Horse in Group"),),
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
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
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
                            setState((){
                              this.Select_horse=value;
                              select_horse_id = horse.indexOf(value);
                            });

                          },
                        ),

                      ),

                    ],
                  ),
                ),
                Center(
                    child:
                    Padding(
                     // padding: const EdgeInsets.all(16),
//                      child: add_horse_button(fbKey: _fbKey,),
//                      // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),
//
////                      child: add_horse_button(fbKey: _fbKey,getHorses:getHorses,genderlist: genderlist,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,breedid: select_breed_id,categoryid: select_category_id,colorid: select_color_id,dateofbirth: Select_date,bodymarkid: select_bodymark_id,headmarkid: select_headmark_id,damid: select_dam_id,dietid: select_diet_id,barnid: select_barn_id,sireid: select_sire_id,dna: name.text,inchargeid: select_incharge_id,legmarkid: select_legmark_id,ironbrandid:select_associate_id,riderid: select_rider_id,),
//                    )
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                           print(groupid);
                           print( getHorses['horseDropDown'][select_horse_id]['id']);
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);
                            Add_horsegroup_services.addHorseToGroup(token, groupid, 40)
                                .then((response){
                              setState(() {
                                var parsedjson  = jsonDecode(response);
                                if(parsedjson != null){
                                    print("Successfully data save");

                                }else
                                  print("response null");
                              });
                            });


                          }
                        },
                        child:Text("Add Horse",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }

}





//class add_horse_button extends StatelessWidget {
//  const add_horse_button({
//    GlobalKey<FormBuilderState> fbKey,
//    // this.select_gender_id,
//    this.name,
//    this.token,
//    this.dynamic,
//    this.select_gender_id,
//    this.number,
//    this.birthfrom,
//    this.birthto,
//    this.createdfrom,
//    this.createdto,
//    this.genderlist,
//    this.getHorses,
//    this.colorid,
//    this.breedid,
//    this.categoryid,
//    this.sireid,
//    this.damid,
//    this.barnid,
//    this.locationid,
//    this.breederid,
//    this.ownerid,
//    this.riderid,
//    this.inchargeid,
//    this.associationid,
//    //  this.gender_name,
//
//
//  }) : _fbKey = fbKey, super();
//  final String token;
//  final GlobalKey<FormBuilderState> _fbKey;
//  final int select_gender_id;
//  final bool dynamic;
//  final TextEditingController name;
//  final DateTime birthfrom,birthto,createdfrom,createdto;
//  final genderlist,getHorses;
//  final String number;
//  final int colorid,breedid,categoryid,sireid,damid;
//  final int associationid,ownerid,riderid,inchargeid,locationid,breederid,barnid;
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialButton(
//      color: Colors.teal,
//      onPressed: (){
//        print(getHorses['breedDropDown'][breedid]['id']);
//        print(getHorses['colorDropDown'][colorid]['id']);
//        print(getHorses['damDropDown'][damid]['id']);
//        print(getHorses['inchargeDropDown'][inchargeid]['id']);
//        print(getHorses['barnDropDown'][barnid]['id']);
//        print(getHorses['breedDropDown'][breedid]['id']);
//        print(getHorses['horseCategoryDropDown'][categoryid]['id']);
//
////        //print(colorlist['colors']);
////        print(genderlist[select_gender_id]['id']);
//        if (_fbKey.currentState.validate()) {
////          Add_horse_services.horsesave(token, 0, name.text,genderlist[select_gender_id]['id'], true,dateofbirth,number,passport,getHorses['colorDropDown'][colorid]['id'],getHorses['breedDropDown'][breedid]['id'],getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['sireDropDown'][sireid]['id'],getHorses['damDropDown'][damid]['id'],getHorses['headMarkingsDropDown'][headmarkid]['id'],getHorses['bodyMarkDropDown'][bodymarkid]['id'],getHorses['legMarkDropDown'][legmarkid]['id'],getHorses['dietDropDown'][dietid]['id'],getHorses['barnDropDown'][barnid]['id'],getHorses['ironBrandDropDown'][ironbrandid]['id'],getHorses['riderDropDown'][riderid]['id'],getHorses['inchargeDropDown'][inchargeid]['id'],dna).then((
//          Add_horsegroup_services.horseGroupSave(false,token, null, 0, name.text, select_gender_id, getHorses['locationDropDown'][locationid]['id'], getHorses['colorDropDown'][colorid]['id'], getHorses['breedDropDown'][breedid]['id'], getHorses['damDropDown'][damid]['id'], getHorses['sireDropDown'][sireid]['id'], getHorses['breederDropDown'][breederid]['id'], getHorses['ownerDropDown'][ownerid]['id'], getHorses['horseCategoryDropDown'][categoryid]['id'],getHorses['riderDropDown'][riderid]['id'], birthfrom, birthto, createdfrom, createdto).then((response) {
//            if (response != null) {
//              Scaffold.of(context).showSnackBar(SnackBar(
//                backgroundColor: Colors.green,
//                content: Text("Added Sucessfully"),
//              ));
//            } else {
//              Scaffold.of(context).showSnackBar(SnackBar(
//                backgroundColor: Colors.red,
//                content: Text(" not Added"),
//              ));
//            }
//          });
//        }
//      },
//      child:Text("Add Horse",style: TextStyle(color: Colors.white),),
//    );
//  }
//}