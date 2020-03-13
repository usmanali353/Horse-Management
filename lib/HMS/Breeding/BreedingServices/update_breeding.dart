import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:horse_management/Network_Operations.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

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
      select_currency, select_donor;
  DateTime Select_date = DateTime.now();
  bool selected_flushed_id, its_programmed_service_id;
  TextEditingController amount, comments, embryo_age;
  bool services_loaded=false;
  bool update_services_visibility;
  _update_breeding(this.token,this.specificservice);

  List<String> semen_type_list = ["Fresh", "Frozen"],
      sire = [],
      dam = [],
      donor = [],
      currency = [],
      contact = [],
      category = [],
      cost_center = [],
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
  int horse_id, dam_id, sire_id, service_type_id, donor_id, currency_id,
      category_id, cost_center_id, contact_id;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  String _Name = "";


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
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
             // autovalidate: true,
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "name",
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      decoration: InputDecoration(labelText: "Horse",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),
                      ),
                      // initialValue: 'Male',
                      hint: Text('Select Horse'),
                      validators: [FormBuilderValidators.required()],
                      items: horse_name
                          .map((name) =>
                          DropdownMenuItem(
                              value: name, child: Text("$name")))
                          .toList(),
                      onChanged: (value) {
                        this.select_horse = value;
                        setState(() {
                          horse_id = horse_name.indexOf(value);
                          print(horse_id.toString());
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDateTimePicker(
                      onChanged: (value) {
                        this.selected_date = value;
                      },
                      attribute: "date",
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(labelText: " Service Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal,
                                width: 1.0)
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "It's programmed service",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("It's programmed service"),
                      items: its_programmed_services != null
                          ? its_programmed_services.map((trainer) =>
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
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Is Flushed",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Is Flushed"),
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
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                      attribute: "name",
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
                      hint: Text('Select Dam'),
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
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
                      hint: Text('Select Sire'),
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
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
                        hint: Text('Select Service'),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16),
                    child: Visibility(
                      visible: semen_type_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Semen Type",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Semen Type"),
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
                        hint: Text('Select Donor'),
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
//                            setState(() => select_donor = donor.indexOf(value));
//                            print(value);
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
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Currency",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Currency'),
                        validators: [FormBuilderValidators.required()],
                        items: currency
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          this.select_currency = value;
                          this.currency_id = select_currency.indexOf(value);
                          print(value);
                        }
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(
                          labelText: "Account Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Account Category'),
                        validators: [FormBuilderValidators.required()],
                        items: category
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          this.select_category = value;
                          this.category_id = select_category.indexOf(value);
                          print(category_id.toString());
                        }
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Cost Center",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Cost Center'),
                        validators: [FormBuilderValidators.required()],
                        items: cost_center
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          this.select_cost_center = value;
                          this.cost_center_id =
                              select_cost_center.indexOf(value);
                          print(value);
                        }
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: FormBuilderDropdown(
                        attribute: "name",
                        style: Theme
                            .of(context)
                            .textTheme
                            .body1,
                        decoration: InputDecoration(labelText: "Contact",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal,
                                  width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Contact'),
                        items: contact
                            .map((name) =>
                            DropdownMenuItem(
                                value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value) {
                          this.select_contact = value;
                          this.contact_id = select_contact.indexOf(value);
                          print(value);
                        }
                    ),
                  ),
                ],
              ),
            ),


            MaterialButton(
              onPressed: () {
                //_fbKey.currentState.save();
                if (_fbKey.currentState.validate()) {
                  print(_fbKey.currentState.value);
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
                      breeddropdown['currencyDropDown'][currency_id]['id'],
                      breeddropdown['categoryDropDown'][category_id]['id'],
                      breeddropdown['costCenterDropDown'][category_id]['id'],
                      breeddropdown['contactsDropDown'][category_id]['id'],
                      comments.text).then((response) {
                    setState(() {
                      var parsedjson = jsonDecode(response);
                      if (parsedjson != null) {
                        if (parsedjson['isSuccess'] == true) {
                          print("Successfully data saved");
                        } else
                          print("not saved");
                      } else
                        print("json response null");
                    });
                  });
                }
              },
              child: Text("Update", style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }



  @override
  void initState() {
    this.amount=TextEditingController();
    this.embryo_age=TextEditingController();
    this.comments=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        BreedingServicesJson.get_breeding_service_dropdowns(token).then((response){
          if(response!=null){
            print(response);
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
              services_loaded=true;
              update_services_visibility=true;
            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });

  }


}