import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';

class update_breeding_control extends StatefulWidget{
  String token;
  var breeding_control_data;
  update_breeding_control(this.token,this.breeding_control_data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_breeding_control_state(token,this.breeding_control_data);
  }

}
class _update_breeding_control_state extends State<update_breeding_control>{
  DateTime date,hour;
  var breeding_control_list;
  String token;
  var breeding_control_data;
  _update_breeding_control_state(this.token,this.breeding_control_data);
  TextEditingController lo,ro,uterus,vagina,cervix,comments,amount;
  bool currency_loaded=false,account_category_loaded=false, horses_loaded=false,vets_loaded=false,related_services_loaded=false,empty=false,Pregnancy=false,Abortion=false,Reabsorption=false,Follicle=false,Ovule=false,Twins=false,Volvoplasty=false;
  String selected_contact,selected_costcenter,selected_account_category,selected_currency,selected_horse,selected_check_method,selected_vet,selected_related_services;
  int selected_contact_id,selected_costcenter_id,selected_account_category_id,selected_currency_id, selected_horse_id,selected_check_method_id,seleced_vet_id,selected_related_services_id;
  List<String> contacts=[],cost_center=[], currency=[],account_category=[],horses=[],check_method_list=['Palpation','Ultrasound','Visual Observation','Blood Test'],vet=[],related_services=[],yesnolist=['Yes','No'];
  var vet_name,costcenter_name,contact_name,accountcategory_name;
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
    setState(() {
      if(breeding_control_data['lo']!=null){
        lo.text=breeding_control_data['lo'];
      }
      if(breeding_control_data['ro']!=null){
        ro.text=breeding_control_data['ro'];
      }
      if(breeding_control_data['uterus']!=null){
        uterus.text=breeding_control_data['uterus'];
      }
      if(breeding_control_data['vagina']!=null){
        vagina.text=breeding_control_data['vagina'];
      }
      if(breeding_control_data['cervix']!=null){
        cervix.text=breeding_control_data['cervix'];
      }
      if(breeding_control_data['comments']!=null){
        comments.text=breeding_control_data['comments'];
      }
      if(breeding_control_data['amount']!=null){
        amount.text=breeding_control_data['amount'].toString();
      }
    });
    network_operations.get_breeding_control_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          breeding_control_list=json.decode(response);
          //currency_loaded=true;
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
  String get_vet_name(int id){
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['vetDropDown'].length; i++) {
        if(breeding_control_list['vetDropDown'][i]['id']==id) {
          vet_name = breeding_control_list['vetDropDown'][i]['name'];
        }
      }
    }
    return vet_name;
  }
  String get_related_service_name(int id){
    var related_services;
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['relatedServiceDropDown'].length; i++) {
        if(breeding_control_list['relatedServiceDropDown'][i]['id']==id) {
          related_services = breeding_control_list['relatedServiceDropDown'][i]['name'];
        }
      }
    }
    return related_services;
  }
  String get_currency_name(int id){
    var currency_name;
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['currencyDropDown'].length; i++) {
        if(breeding_control_list['currencyDropDown'][i]['id']==id) {
          currency_name = breeding_control_list['currencyDropDown'][i]['name'];
        }
      }
    }
    return currency_name;
  }
  String get_costcenter_name(int id){
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['costCenterDropDown'].length; i++) {
        if(breeding_control_list['costCenterDropDown'][i]['id']==id) {
          costcenter_name = breeding_control_list['costCenterDropDown'][i]['name'];
        }
      }
    }
    return costcenter_name;
  }
  String get_contact_name(int id){
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['contactsDropDown'].length; i++) {
        if(breeding_control_list['contactsDropDown'][i]['id']==id) {
          contact_name = breeding_control_list['contactsDropDown'][i]['name'];
        }
      }
    }
    return contact_name;
  }
  String getAcCategoryName(int id){
    if(breeding_control_list!=null&&id!=null) {
      for (int i = 0; i < breeding_control_list['categoryDropDown'].length; i++) {
        if(breeding_control_list['categoryDropDown'][i]['id']==id) {
          accountcategory_name = breeding_control_list['categoryDropDown'][i]['name'];
        }
      }
    }
    return accountcategory_name;
  }
  String get_yesno(bool b){
    var yesno;
    if(b!=null){
      if(b){
        yesno="Yes";
      }else {
        yesno = "No";
      }
    }
    return yesno;
  }
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Update Breeding Control"),),
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
                        padding: const EdgeInsets.all(16),
                        child: Visibility(
                          visible: horses_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Horse",
                           initialValue: breeding_control_data!=null?breeding_control_data['horseName']['name']:null,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_horse=value;
                                this.selected_horse_id=horses.indexOf(value);
                              });
                            },
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
                        padding: EdgeInsets.only(left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "Date",
                          initialValue: breeding_control_data['date']!=null?DateTime.parse(breeding_control_data['date']):null,
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onSaved: (value){
                            setState(() {
                              this.date=value;
                            });
                          },
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
                         // initialValue: breeding_control_data['hour']!=null?DateTime.parse(breeding_control_data['hour']):null,
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.time,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("hh:mm"),
                          decoration: InputDecoration(labelText: "Hour",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onSaved: (value){
                            setState(() {
                              this.hour=value;
                              print(hour);
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              this.hour=value;
                              print(hour);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Check Method",
                          initialValue: breeding_control_data['check_Method']!=null?check_method_list[breeding_control_data['check_Method']]:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: check_method_list.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              this.selected_check_method=value;
                              this.selected_check_method_id=check_method_list.indexOf(value)+1;
                            });
                          },
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
                          visible: vets_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Vet",
                            initialValue: get_vet_name(breeding_control_data['vetId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_vet=value;
                                this.seleced_vet_id=vet.indexOf(value);
                              });
                            },
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
                            initialValue: get_related_service_name(breeding_control_data['relatedServiceId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_related_services=value;
                                this.selected_related_services_id=related_services.indexOf(value);
                              });
                            },
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
                          initialValue: get_yesno(breeding_control_data['empty']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                empty=true;
                              }else{
                                empty=false;
                              }
                            });
                          },
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
                          initialValue: get_yesno(breeding_control_data['pregnancy']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Pregnancy=true;
                              }else{
                                Pregnancy=false;
                              }
                            });
                          },
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
                         initialValue: get_yesno(breeding_control_data['abortion']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Abortion=true;
                              }else{
                                Abortion=false;
                              }
                            });
                          },
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
                          initialValue: get_yesno(breeding_control_data['reabsorption']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Reabsorption=true;
                              }else{
                                Reabsorption=false;
                              }
                            });
                          },
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
                         initialValue: get_yesno(breeding_control_data['follicle']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Follicle=true;
                              }else{
                                Follicle=false;
                              }
                            });
                          },
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
                          initialValue: get_yesno(breeding_control_data['ovule']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Ovule=true;
                              }else{
                                Ovule=false;
                              }
                            });
                          },
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
                          initialValue: get_yesno(breeding_control_data['twins']),
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Twins=true;
                              }else{
                                Twins=false;
                              }
                            });
                          },
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
                          initialValue: get_yesno(breeding_control_data['volvoplasty']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          items: yesnolist.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onSaved: (value){
                            setState(() {
                              if(value=="Yes"){
                                Volvoplasty=true;
                              }else{
                                Volvoplasty=false;
                              }
                            });
                          },
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
                          //visible: currency_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Currency",
                            initialValue: get_currency_name(breeding_control_data['currency']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_currency=value;
                                this.selected_currency_id=currency.indexOf(value);
                              });
                            },
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
                          visible: account_category_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Account Category",
                            initialValue: getAcCategoryName(breeding_control_data['categoryId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_account_category=value;
                                this.selected_account_category_id=account_category.indexOf(value);
                              });
                            },
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
                          visible: account_category_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Cost Center",
                            initialValue: get_costcenter_name(breeding_control_data['costCenterId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_costcenter=value;
                                this.selected_costcenter_id=cost_center.indexOf(value);
                              });
                            },
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
                          visible: account_category_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Contact",
                            initialValue: get_contact_name(breeding_control_data['contactId']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("- Select -"),
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
                            onSaved: (value){
                              setState(() {
                                this.selected_contact=value;
                                this.selected_contact_id=contacts.indexOf(value);
                              });
                            },
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
                update_breeding_control_button(breeding_control_data:breeding_control_data,breeding_control_list:breeding_control_list,volvoplasty:Volvoplasty,reabsorption: Reabsorption,twins: Twins,ovule: Ovule,follicle:Follicle,pregnancy:Pregnancy,empty:empty,abortion:Abortion,token: token,fbKey: _fbKey,selected_contact: selected_contact,selected_account_category: selected_account_category,seleced_vet_id: seleced_vet_id,selected_check_method_id: selected_check_method_id,selected_related_services_id: selected_related_services_id,selected_horse_id: selected_horse_id,selected_costcenter_id: selected_costcenter_id,selected_contact_id: selected_contact_id,selected_currency_id: selected_currency_id,selected_currency: selected_currency,selected_horse: selected_horse,selected_costcenter: selected_costcenter,selected_related_services: selected_related_services,selected_account_category_id: selected_account_category_id,selected_check_method: selected_check_method,selected_vet:selected_vet,comments: comments,uterus: uterus,date: date,hour:hour,vagina: vagina,cervix: cervix,amount: amount,lo: lo,ro: ro,)
              ],
            )
          ],
        ),
      ),
    );
  }

}

class update_breeding_control_button extends StatelessWidget {
  const update_breeding_control_button({
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
    @required this.breeding_control_data,
  }) : _fbKey = fbKey, super(key: key);
  final GlobalKey<FormBuilderState> _fbKey;
  final DateTime date,hour;
  final breeding_control_data;
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
            print(breeding_control_data);
            if(_fbKey.currentState.validate()){
              _fbKey.currentState.save();

             // network_operations.add_breeding_control(token, breeding_control_data['breedingControlId'], breeding_control_list['horseDropDown'][selected_horse_id]['id'], date,hour, selected_check_method_id, breeding_control_list['relatedServiceDropDown'][selected_related_services_id]['id'], empty, pregnancy, abortion, reabsorption, follicle, ovule, twins, volvoplasty,double.parse(amount.text), breeding_control_list['currencyDropDown'][selected_currency_id]['id'],breeding_control_data['createdBy'], comments.text, lo.text, ro.text, uterus.text, vagina.text, cervix.text, breeding_control_list['categoryDropDown'][selected_account_category_id]['id'], breeding_control_list['costCenterDropDown'][selected_costcenter_id]['id'], breeding_control_list['contactsDropDown'][selected_contact_id]['id'],breeding_control_list['vetDropDown'][seleced_vet_id]['id'], true)
              network_operations.add_breeding_control(token, breeding_control_data['breedingControlId'], breeding_control_list['horseDropDown'][selected_horse_id]['id'], date,hour, selected_check_method_id, breeding_control_list['relatedServiceDropDown'][selected_related_services_id]['id'], empty, pregnancy, abortion, reabsorption, follicle, ovule, twins, volvoplasty,double.parse(amount.text), breeding_control_list['currencyDropDown'][selected_currency_id]['id'], breeding_control_data['createdBy'], comments.text, lo.text, ro.text, uterus.text, vagina.text, cervix.text, breeding_control_list['categoryDropDown'][selected_account_category_id]['id'], breeding_control_list['costCenterDropDown'][selected_costcenter_id]['id'], breeding_control_list['contactsDropDown'][selected_contact_id]['id'],breeding_control_list['vetDropDown'][seleced_vet_id]['id'],true)
                  .then((response){
                if(response!=null){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Breeding Control Updated Sucessfully"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Breeding Control not Updated"),
                    backgroundColor: Colors.red,
                  ));
                }
              });
            }
          },
          child: Text("Update",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}