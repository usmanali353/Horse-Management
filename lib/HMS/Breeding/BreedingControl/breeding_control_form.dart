import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class add_breeding_control extends StatefulWidget{
  String token;
  add_breeding_control(this.token);
  @override
  State<StatefulWidget> createState() {
    return _add_breeding_control_state(token);
  }

}
class _add_breeding_control_state extends State<add_breeding_control>{
  DateTime date,hour;
  var breeding_control_list;
  String token;
  _add_breeding_control_state(this.token);
  TextEditingController lo,ro,uterus,vagina,cervix,comments,amount;
  bool currency_loaded=false,account_category_loaded=false, horses_loaded=false,vets_loaded=false,related_services_loaded=false,empty=false,Pregnancy=false,Abortion=false,Reabsorption=false,Follicle=false,Ovule=false,Twins=false,Volvoplasty=false;
  String selected_contact,selected_costcenter,selected_account_category,selected_currency,selected_horse,selected_check_method,selected_vet,selected_related_services;
  int selected_contact_id,selected_costcenter_id,selected_account_category_id,selected_currency_id, selected_horse_id,selected_check_method_id,seleced_vet_id,selected_related_services_id;
  List<String> contacts=[],cost_center=[], currency=[],account_category=[],horses=[],check_method_list=['Palpation','Ultrasound','Visual Observation','Blood Test'],vet=[],related_services=[],yesnolist=['Yes','No'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lo=TextEditingController();
    ro=TextEditingController();
    uterus=TextEditingController();
    vagina=TextEditingController();
    cervix=TextEditingController();
    comments=TextEditingController();
    amount=TextEditingController();
    network_operations.get_breeding_control_dropdowns(token).then((response){
       if(response!=null){
         setState(() {
           breeding_control_list=json.decode(response);
           currency_loaded=true;
           account_category_loaded=true;
           horses_loaded=true;
           vets_loaded=true;
           related_services_loaded=true;
           for(int i=0;i<breeding_control_list['currencyDropDown'].length;i++){
             currency.add(breeding_control_list['currencyDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['costCenterDropDown'].length;i++){
             cost_center.add(breeding_control_list['costCenterDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['contactsDropDown'].length;i++){
             contacts.add(breeding_control_list['contactsDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['horseDropDown'].length;i++){
             horses.add(breeding_control_list['horseDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['categoryDropDown'].length;i++){
             account_category.add(breeding_control_list['categoryDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['relatedServiceDropDown'].length;i++){
             related_services.add(breeding_control_list['relatedServiceDropDown'][i]['name']);
           }
           for(int i=0;i<breeding_control_list['vetDropDown'].length;i++){
             vet.add(breeding_control_list['vetDropDown'][i]['name']);
           }

         });

       }else{

       }
    });
  }
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Breeding Control"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Visibility(
                       // visible: horses_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items:horses!=null?horses.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
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
                            setState(() {
                              this.selected_horse=value;
                              this.selected_horse_id=horses.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top:16),
                      child:FormBuilderDateTimePicker(
                        attribute: "Date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("MM-dd-yyyy"),
                        decoration: InputDecoration(labelText: "Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                        onChanged: (value){
                          setState(() {
                            this.date=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child:FormBuilderDateTimePicker(
                        attribute: "Hour",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.time,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("hh:mm:ss"),
                        decoration: InputDecoration(labelText: "Hour",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                        onChanged: (value){
                          setState(() {
                            this.hour=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Check Method",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Check Method"),
                        items: check_method_list.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                              this.selected_check_method=value;
                              this.selected_check_method_id=check_method_list.indexOf(value)+1;
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Check Method",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                      child: Visibility(
                        //visible: vets_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Vet",
                         validators: [FormBuilderValidators.required()],
                          hint: Text("Vet"),
                          items:vet!=null?vet.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
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
                              this.seleced_vet_id=vet.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
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
                    Padding(
                      padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                      child: FormBuilderTextField(
                        controller: comments,
                        attribute: "Comments",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Comments",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                      child: Visibility(
                        visible: related_services_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Related Services",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Related Services"),
                          items:related_services!=null?related_services.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Related Services",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_related_services=value;
                              this.selected_related_services_id=related_services.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Empty",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Empty"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              empty=true;
                            }else{
                              empty=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Empty",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Pregnancy",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Pregnancy"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Pregnancy=true;
                            }else{
                              Pregnancy=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Pregnancy",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Abortion",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Abortion"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Abortion=true;
                            }else{
                              Abortion=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Abortion",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Reabsorption",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Reabsorption"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Reabsorption=true;
                            }else{
                              Reabsorption=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Reabsorption",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Follicle",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Follicle"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Follicle=true;
                            }else{
                              Follicle=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Follicle",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Ovule",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Ovule"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Ovule=true;
                            }else{
                              Ovule=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Ovule",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Twins",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Twins"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Twins=true;
                            }else{
                              Twins=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Twins",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Volvoplasty",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Volvoplasty"),
                        items: yesnolist.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            if(value=="Yes"){
                              Volvoplasty=true;
                            }else{
                              Volvoplasty=false;
                            }
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Volvoplasty",
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
                        controller: amount,
                        attribute: "Amount",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: Visibility(
                       // visible: currency_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Currency",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Currency"),
                          items:currency!=null?currency.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Currency",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_currency=value;
                              this.selected_currency_id=currency.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: Visibility(
                       // visible: account_category_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Account Category",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Account Category"),
                          items:account_category!=null?account_category.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Account Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_account_category=value;
                              this.selected_account_category_id=account_category.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: Visibility(
                      //  visible: account_category_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Cost Center",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Cost Center"),
                          items:cost_center!=null?cost_center.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Cost Center",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_costcenter=value;
                              this.selected_costcenter_id=cost_center.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right:16),
                      child: Visibility(
                       // visible: account_category_loaded,
                        child: FormBuilderDropdown(
                          attribute: "Contact",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Contact"),
                          items:contacts!=null?contacts.map((horse)=>DropdownMenuItem(
                            child: Text(horse),
                            value: horse,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Contact",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_contact=value;
                              this.selected_contact_id=contacts.indexOf(value);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              add_breeding_control_button(breeding_control_list:breeding_control_list,volvoplasty:Volvoplasty,reabsorption: Reabsorption,twins: Twins,ovule: Ovule,follicle:Follicle,pregnancy:Pregnancy,empty:empty,abortion:Abortion,token: token,fbKey: _fbKey,selected_contact: selected_contact,selected_account_category: selected_account_category,seleced_vet_id: seleced_vet_id,selected_check_method_id: selected_check_method_id,selected_related_services_id: selected_related_services_id,selected_horse_id: selected_horse_id,selected_costcenter_id: selected_costcenter_id,selected_contact_id: selected_contact_id,selected_currency_id: selected_currency_id,selected_currency: selected_currency,selected_horse: selected_horse,selected_costcenter: selected_costcenter,selected_related_services: selected_related_services,selected_account_category_id: selected_account_category_id,selected_check_method: selected_check_method,selected_vet:selected_vet,comments: comments,uterus: uterus,date: date,hour:hour,vagina: vagina,cervix: cervix,amount: amount,lo: lo,ro: ro,)
            ],
          )
        ],
      ),
    );
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