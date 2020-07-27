import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
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
                      child: add_breeding_control_button(breeding_control_list:breeding_control_list,volvoplasty:Volvoplasty,reabsorption: Reabsorption,twins: Twins,ovule: Ovule,follicle:Follicle,pregnancy:Pregnancy,empty:empty,abortion:Abortion,token: token,fbKey: _fbKey, contactId: contact_id,selected_account_category: selected_account_category,seleced_vet_id: seleced_vet_id,selected_check_method_id: selected_check_method_id,selected_related_services_id: selected_related_services_id,selected_horse_id: selected_horse_id,selected_costcenter_id: selected_costcenter_id,selected_contact_id: selected_contact_id,selected_currency_id: selected_currency_id,selected_currency: selected_currency,selected_horse: selected_horse,selected_costcenter: selected_costcenter,selected_related_services: selected_related_services,selected_account_category_id: selected_account_category_id,selected_check_method: selected_check_method,selected_vet:selected_vet,comments: comments,uterus: uterus,date: date,hour:hour,vagina: vagina,cervix: cervix, amount: amounts.text,lo: lo,ro: ro,)
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

class add_breeding_control_button extends StatelessWidget {
  const add_breeding_control_button({
    Key key,
    @required this.selected_related_services_id,
    @required this.selected_related_services,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.comments,
    @required this.uterus,
    @required this.lo,
    @required this.ro,
    @required this.seleced_vet_id,
    @required this.selected_vet,
    @required this.cervix,
    @required this.selected_check_method_id,
    @required this.selected_check_method,
    @required this.selected_account_category_id,
    @required this.selected_account_category,
    @required this.amount,
    @required this.selected_contact_id,
    @required this.selected_contact,
    @required this.selected_costcenter_id,
    @required this.selected_costcenter,
    @required this.selected_currency_id,
    @required this.selected_currency,
    @required this.selected_horse_id,
    @required this.selected_horse,
    @required this.vagina,
    @required this.token,
    @required this.date,
    @required this.hour,
    @required this.empty,
    @required this.abortion,
    @required this.follicle,
    @required this.pregnancy,
    @required this.ovule,
    @required this.reabsorption,
    @required this.twins,
    @required this.volvoplasty,
    @required this.breeding_control_list,
  }) : _fbKey = fbKey, super(key: key);
  final GlobalKey<FormBuilderState> _fbKey;
  final DateTime date,hour;
  final breeding_control_list;
  final bool empty, pregnancy, abortion, reabsorption, follicle, ovule, twins, volvoplasty;
  final String token,selected_contact,selected_costcenter,selected_account_category,selected_currency,selected_horse,selected_check_method,selected_vet,selected_related_services;
  final int selected_contact_id,selected_costcenter_id,selected_account_category_id,selected_currency_id, selected_horse_id,selected_check_method_id,seleced_vet_id,selected_related_services_id;
  final TextEditingController lo,ro,uterus,vagina,cervix,comments,amount;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: MaterialButton(
          color: Colors.teal,
          onPressed: (){
            if (_fbKey.currentState.validate()) {
              Utils.check_connectivity().then((result){
                if(result){
                  ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                  pd.show();
                  network_operations.add_breeding_control(token, 0, breeding_control_list['horseDropDown'][selected_horse_id]['id'], date,hour, selected_check_method_id, breeding_control_list['relatedServiceDropDown'][selected_related_services_id]['id'], empty, pregnancy, abortion, reabsorption, follicle, ovule, twins, volvoplasty,double.parse(amount.text), breeding_control_list['currencyDropDown'][selected_currency_id]['id'], '', comments.text, lo.text, ro.text, uterus.text, vagina.text, cervix.text, breeding_control_list['categoryDropDown'][selected_account_category_id]['id'], breeding_control_list['costCenterDropDown'][selected_costcenter_id]['id'], breeding_control_list['contactsDropDown'][selected_contact_id]['id'],breeding_control_list['vetDropDown'][seleced_vet_id]['id'],true)
                      .then((response){
                    pd.dismiss();
                    if(response!=null){
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Breeding Control Added Sucessfully"),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pop(context);
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Breeding Control not Added Sucessfully"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  });
                }
              });

            }
          },

          child: Text("Save",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}



