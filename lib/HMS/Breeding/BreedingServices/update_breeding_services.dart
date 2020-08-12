import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'utils/breeding_services_json.dart';


class update_breeding extends StatefulWidget{
  final token,specificservice;
  update_breeding (this.token, this.specificservice);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_breeding(token,specificservice);
  }
}



class _update_breeding extends State<update_breeding> {
  final token,specificservice;

  String semen_type, select_horse, select_sire, select_dam, select_contact,
      select_category, select_semen_type, select_cost_center,
      select_account_category, select_its_programmed, select_service_type,
      select_currency, select_donor, selected_currency, selected_category, selected_costcenter, selected_contact;
  DateTime select_date = DateTime.now();
  bool selected_flushed_id, its_programmed_service_id;
  TextEditingController amount, comments, embryo_age;
  bool services_loaded=false;
  bool update_services_visibility;
  _update_breeding(this.token,this.specificservice);

  List<String> semen_type_list = ["Fresh", "Frozen"],
      sire = [],
      dam = [],
      donor = [],
      currency=[], category=[], cost_center=[],contact=[],
      horse_name = [],
      service_type = [
        "Direct Service",
        "Assisted Service",
        "Artificial Insemination",
        "Embryo Transfer"
      ],
      its_programmed_services = ['Yes', 'No'],
      is_flushed = ['Yes', 'No'];
  var breeddropdown;
  var data;
  bool embryo_age_loaded = false,
      semen_type_loaded = false;
  int semen_type_id;
  DateTime selected_date = DateTime.now();
  int horse_id=0, dam_id=0, sire_id=0, service_type_id=0, donor_id=0, selected_currency_id=0, selected_category_id=0, selected_costcenter_id=0,selected_contact_id=0;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  String _Name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.comments=TextEditingController();
    this.amount=TextEditingController();
    this.embryo_age=TextEditingController();
    setState(() {
      if(specificservice['comments']!=null){
        comments.text=specificservice['comments'];
      }
      if(specificservice['amount']!=null){
        amount.text=specificservice['amount'].toString();
      }
      if(specificservice['embryoAge']!=null){
        embryo_age.text=specificservice['embryoAge'].toString();
      }
    });
    BreedingServicesJson.get_breeding_service_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          breeddropdown=json.decode(response);
              for(int i=0;i<breeddropdown['sireDropDown'].length;i++)
                sire.add(breeddropdown['sireDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['damDropDown'].length;i++)
                dam.add(breeddropdown['damDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['donorDropDown'].length;i++)
                donor.add(breeddropdown['donorDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['currencyDropDown'].length;i++)
                currency.add(breeddropdown['currencyDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['contactsDropDown'].length;i++)
                contact.add(breeddropdown['contactsDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['categoryDropDown'].length;i++)
                category.add(breeddropdown['categoryDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['costCenterDropDown'].length;i++)
                cost_center.add(breeddropdown['costCenterDropDown'][i]['name']);
              for(int i=0;i<breeddropdown['horseDropDown'].length;i++)
                horse_name.add(breeddropdown['horseDropDown'][i]['name']);
        });
      }
    });
  }
  String get_currency_by_id(int id){
    var currency_name;
    if(specificservice!=null&&breeddropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(breeddropdown['currencyDropDown'][i]['id']==id){
          currency_name=breeddropdown['currencyDropDown'][i]['name'];
        }
      }
      return currency_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var category_name;
    if(specificservice!=null&&breeddropdown['categoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(breeddropdown['categoryDropDown'][i]['id']==id){
          category_name=breeddropdown['categoryDropDown'][i]['name'];
        }
      }
      return category_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var costcenter_name;
    if(specificservice!=null&&breeddropdown['costCenterDropDown']!=null&&id!=null){
      for(int i=0;i<cost_center.length;i++){
        if(breeddropdown['costCenterDropDown'][i]['id']==id){
          costcenter_name=breeddropdown['costCenterDropDown'][i]['name'];
        }
      }
      return costcenter_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var contact_name;
    if(specificservice!=null&&breeddropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(breeddropdown['contactsDropDown'][i]['id']==id){
          contact_name=breeddropdown['contactsDropDown'][i]['name'];
        }
      }
      return contact_name;
    }else
      return null;
  }
  String get_dam_by_id(int id){
    var dam_name;
    if(specificservice!=null&&breeddropdown['damDropDown']!=null&&id!=null){
      for(int i=0;i<dam.length;i++){
        if(breeddropdown['damDropDown'][i]['id']==id){
          dam_name=breeddropdown['damDropDown'][i]['name'];
        }
      }
      return dam_name;
    }else
      return null;
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

//              services_loaded=true;
//              update_services_visibility=true;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Update Breeding Service"),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,

             // autovalidate: true,
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      //visible: sale_loaded,
                      child: FormBuilderDropdown(
                        initialValue: specificservice['horseName']['name'],
                        attribute: "Horse",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("- Select -"),
                        items:horse_name!=null?horse_name.map((horse)=>DropdownMenuItem(
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
                            this.select_horse=value;
                            this.horse_id=horse_name.indexOf(value);
                          });
                        },
                        onChanged: (value){
                          setState(() {
                            this.select_horse=value;
                            this.horse_id=horse_name.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      initialValue: specificservice['serviceDate']!=null?DateTime.parse(specificservice['serviceDate']):null,
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: "Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                      onSaved: (value){
                        setState(() {
                          this.select_date=value;
                        });
                      },
                      onChanged: (value){
                        setState(() {
                          this.select_date=value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      initialValue: get_yesno(specificservice['isProgrammedService']),
                      attribute: "It's programmed service",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: its_programmed_services != null ? its_programmed_services.map((trainer) =>
                          DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList()
                          : [""].map((name) =>
                          DropdownMenuItem(
                              value: name, child: Text("$name")))
                          .toList(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      decoration: InputDecoration(
                        labelText: "It's programmed service",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == "Yes")
                            its_programmed_service_id = true;
                          else if (value == "No")
                            its_programmed_service_id = false;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          if (value == "Yes")
                            its_programmed_service_id = true;
                          else if (value == "No")
                            its_programmed_service_id = false;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Is Flushed",
                      initialValue: get_yesno(specificservice['isFlushed']),
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: is_flushed != null ? is_flushed.map((trainer) =>
                          DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList() : [""].map((name) =>
                          DropdownMenuItem(
                              value: name, child: Text("$name")))
                          .toList(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      decoration: InputDecoration(labelText: "Is Flushed",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value == "Yes")
                            selected_flushed_id = true;
                          else if (value == "No")
                            selected_flushed_id = false;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          if (value == "Yes")
                            selected_flushed_id = true;
                          else if (value == "No")
                            selected_flushed_id = false;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "name",
                     initialValue: get_dam_by_id(specificservice['damId'])!= null ?get_dam_by_id(specificservice['damId']):null,
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      decoration: InputDecoration(labelText: "Dam",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                      // initialValue: 'Male',
                      hint: Text('- Select -'),
                      validators: [FormBuilderValidators.required()],
                      items: dam
                          .map((name) =>
                          DropdownMenuItem(
                              value: name, child: Text("$name")))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          this.select_dam = value;
                          dam_id = dam.indexOf(value);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          this.select_dam = value;
                          dam_id = dam.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      initialValue: specificservice['sireName']['name'],
                      attribute: "name",
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      decoration: InputDecoration(labelText: "Sire",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                      // initialValue: 'Male',
                      hint: Text('- Select -'),
                      validators: [FormBuilderValidators.required()],
                      items: sire
                          .map((name) =>
                          DropdownMenuItem(
                              value: name, child: Text("$name")))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          this.select_sire = value;
                          sire_id = sire.indexOf(value);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          this.select_sire = value;
                          sire_id = sire.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                       // initialValue: specificservice['serviceType']!=null?service_type[specificservice['serviceType']]:null,
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Service Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('- Select -'),
                        validators: [FormBuilderValidators.required()],
                        items: service_type
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == "Artificial Insemination") {
                              setState(() {
                                semen_type_loaded = true;
                              });
                            } else {
                              setState(() {
                                semen_type_loaded = false;
                              });
                            }
                            if (value == "Embryo Transfer") {
                              setState(() {
                                embryo_age_loaded = true;
                              });
                            } else {
                              setState(() {
                                embryo_age_loaded = false;
                              });
                            }
                            this.select_service_type = value;
                            this.service_type_id = service_type.indexOf(value);
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            if (value == "Artificial Insemination") {
                              setState(() {
                                semen_type_loaded = true;
                              });
                            } else {
                              setState(() {
                                semen_type_loaded = false;
                              });
                            }
                            if (value == "Embryo Transfer") {
                              setState(() {
                                embryo_age_loaded = true;
                              });
                            } else {
                              setState(() {
                                embryo_age_loaded = false;
                              });
                            }
                            this.select_service_type = value;
                            this.service_type_id = service_type.indexOf(value);
                          });
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Visibility(
                      visible: embryo_age_loaded,
                      child: FormBuilderTextField(
                        controller: embryo_age,
                        keyboardType: TextInputType.number,
                        attribute: 'Embryo Age',
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Embryo Age",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(
                                  color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Semen Type",
                        //initialValue: specificservice['semenType']!=null?semen_type[specificservice['semenType']]:null,
                        validators: [FormBuilderValidators.required()],
                        hint: Text("- Select -"),
                        items: semen_type_list.map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            this.semen_type = value;
                            this.semen_type_id =
                                semen_type_list.indexOf(value) + 1;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            this.semen_type = value;
                            this.semen_type_id =
                                semen_type_list.indexOf(value) + 1;
                          });
                        },
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Semen Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(
                                  color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                        initialValue: specificservice['donorName']['name'],
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Donor",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('- Select -'),
                        validators: [FormBuilderValidators.required()],
                        items: donor
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          this.select_donor = value;
                          setState(() {
                            this.donor_id = select_donor.indexOf(value);
                          });

                        },
                        onSaved: (value) {
                          this.select_donor = value;
                          setState(() {
                            this.donor_id = select_donor.indexOf(value);
                          });

                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderTextField(
                      controller: comments,
                      attribute: 'text',
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      //validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Comments",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      attribute: "Amount",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Amount",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:12,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Currency",
                      initialValue: get_currency_by_id(specificservice['currency'])!= null ?get_currency_by_id(specificservice['currency']):null,
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: currency!=null?currency.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
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
                      onSaved: (value){
                        setState(() {
                          this.selected_currency=value;
                          this.selected_currency_id=currency.indexOf(value);
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Account Category",
                    initialValue: get_category_by_id(specificservice['categoryId']),
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: category!=null?category.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
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
                          this.selected_category=value;
                          this.selected_category_id=category.indexOf(value);
                        });
                      },
                      onSaved: (value){
                        setState(() {
                          this.selected_category=value;
                          this.selected_category_id=category.indexOf(value);
                        });
                      },
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Cost Center",
                      initialValue: get_costcenter_by_id(specificservice['costCenterId']),
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: cost_center!=null?cost_center.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
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
                      onSaved: (value){
                        setState(() {
                          this.selected_costcenter=value;
                          this.selected_costcenter_id=cost_center.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Contact",
                     initialValue: get_contact_by_id(specificservice['contactId']),
                      validators: [FormBuilderValidators.required()],
                      hint: Text("- Select -"),
                      items: contact!=null?contact.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
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
                          this.selected_contact_id=contact.indexOf(value);
                        });
                      },
                      onSaved: (value){
                        setState(() {
                          this.selected_contact=value;
                          this.selected_contact_id=contact.indexOf(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),


            Builder(
              builder: (BuildContext context){
                return  MaterialButton(
                  onPressed: () {
                    if (_fbKey.currentState.validate()) {
                      _fbKey.currentState.save();
                      Utils.check_connectivity().then((result){
                        if(result){
                          ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                          pd.show();
                          BreedingServicesJson.update_and_add_breeding_service(
                              specificservice['createdBy'],
                              token,
                              specificservice['breedingServiceId'],
                              breeddropdown['horseDropDown'][horse_id]['id'],
                              selected_date,
                              its_programmed_service_id,
                              selected_flushed_id,
                              breeddropdown['damDropDown'][dam_id]['id'],
                              breeddropdown['sireDropDown'][sire_id]['id'],
                              service_type_id,
                              semen_type_id,
                              embryo_age.text,
                              breeddropdown['donorDropDown'][donor_id]['id'],
                              amount.text,
                              breeddropdown['currencyDropDown'][selected_currency_id]['id'],
                              breeddropdown['categoryDropDown'][selected_category_id]['id'],
                              breeddropdown['costCenterDropDown'][selected_costcenter_id]['id'],
                              breeddropdown['contactsDropDown'][selected_contact_id]['id'],
                              comments.text).then((response) {
                            //Navigator.of(context).pop();
                            if(response!=null){

                             //print('Hello');
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Breeding Service Updated"),
                                backgroundColor: Colors.green,
                              ));
                              //sleep(Duration(seconds: 3));
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                            }
                            else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Breeding Services not Updated"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          });
                        }
                      });

                    }

                  },
                  child: Text("Update", style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal,
                );
              },

            ),
          ],
        ),
      ),
    );
  }





}