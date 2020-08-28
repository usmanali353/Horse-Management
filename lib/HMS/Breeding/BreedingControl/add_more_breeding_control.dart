import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/Network_Operations.dart';



class add_BreedingControl_Details extends StatefulWidget{
  final token;
  DateTime date,hour;
  String comments, amounts;
  int contact_id, costcenter_id, account_category_id,
      currency_id, horse_id, check_method_id,
      vet_id, related_services_id;

  add_BreedingControl_Details (this.token,this.date,this.hour, this.comments,this.amounts,this.contact_id,this.costcenter_id,
      this.account_category_id,this.currency_id,this.horse_id,this.check_method_id,this.vet_id,this.related_services_id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_BreedingControl_Details_state(token,date,hour, comments,this.amounts,contact_id,this.costcenter_id,
        this.account_category_id,this.currency_id,this.horse_id,this.check_method_id,this.vet_id,this.related_services_id);
  }

}
class _add_BreedingControl_Details_state extends State<add_BreedingControl_Details>{
  final token;
  var breeding_control_list;
  bool empty=false,Pregnancy=false,Abortion=false,Reabsorption=false,Follicle=false,Ovule=false,Twins=false,Volvoplasty=false;

  _add_BreedingControl_Details_state (this.token,this.date,this.hour, this.comments,this.amounts,this.contact_id,this.costcenter_id,
      this.account_category_id,this.currency_id,this.horse_id,this.check_method_id,this.vet_id,this.related_services_id);
  DateTime date,hour;
  String comments, amounts;
  int contact_id, costcenter_id, account_category_id,
      currency_id, horse_id, check_method_id,
      vet_id, related_services_id;

  TextEditingController lo,ro,uterus,vagina,cervix;
  List<String> yesnolist=['Yes','No'];


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
  void initState() {
    // TODO: implement initState
    super.initState();
    lo=TextEditingController();
    ro=TextEditingController();
    uterus=TextEditingController();
    vagina=TextEditingController();
    cervix=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("More Breeding Control Details"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: lo,
                          attribute: "LO",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "LO",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: ro,
                          attribute: "RO",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "RO",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: uterus,
                          attribute: "Uterus",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Uterus",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: vagina,
                          attribute: "Vagina",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Vagina",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: cervix,
                          attribute: "Cervix",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Cervix",
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
                      child: Builder(
                        builder: (BuildContext context){
                          return MaterialButton(
                            child: Text("Add Breeding Control"),
                            color: Colors.teal,
                            onPressed: (){
                              if(_fbKey.currentState.validate()){
                                network_operations.add_breeding_control(token: token,id: 0,horseId: horse_id,date: DateTime.now(),check_method_id: check_method_id,serviceid: related_services_id,empty: empty,pregnancy: Pregnancy,abortion: Abortion,reabsorption: Reabsorption,follicle: Follicle,ovule: Ovule,twins: Twins,volvoplasty: Volvoplasty,amount: double.parse(amounts),currencyid: currency_id,Createdby: "",comments: comments,lo: lo.text,ro: ro.text,uterus: uterus.text,vagina: vagina.text,cervix: cervix.text,accountcategory: account_category_id,costcenterid: costcenter_id,contactid: contact_id,vetId: vet_id,nextcheck: true,hour: null).then((response){
                                  if(response!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Breeding Control Added Sucessfully"),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pop(context);
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Breeding Control not Added"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              }

                            },
                          );
                        },
                      )
                      // child: add_horse_button(fbKey: _fbKey,name: name ,token: token,select_gender_id:select_gender_id,getHorses: getHorses,number: number.text,passport: passport.text,microchip: chip.text,dateofbirth: Select_date,genderlist: genderlist,colorid: select_color_id,breedid: select_breed_id,categoryid: select_category_id,sireid: select_sire_id,damid: select_dam_id),

//                      child: add_horse_button(fbKey: _fbKey,getHorses:getHorses,genderlist: genderlist,select_gender_id:select_gender_id,name: name ,token: token,number: number.text,passport: passport.text,microchip: passport.text,breedid: select_breed_id,categoryid: select_category_id,colorid: select_color_id,dateofbirth: Select_date,bodymarkid: select_bodymark_id,headmarkid: select_headmark_id,damid: select_dam_id,dietid: select_diet_id,barnid: select_barn_id,sireid: select_sire_id,dna: name.text,inchargeid: select_incharge_id,legmarkid: select_legmark_id,ironbrandid:select_associate_id,riderid: select_rider_id,),
                    ),
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







