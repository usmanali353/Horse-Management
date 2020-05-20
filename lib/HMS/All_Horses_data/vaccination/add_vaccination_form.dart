import 'dart:convert';
import 'package:horse_management/HMS/All_Horses_data/services/vaccination_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class add_vaccination extends StatefulWidget{
  String token;

  add_vaccination (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(token);
  }

}
class _state_add_farrier extends State<add_vaccination>{
  int selected_horse_id,selected_vaccinationtype_id,selected_vaccine_id,selected_vet_id,selected_costcenter_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> vaccinationtype=[];List<String> vaccine=[];List<String> vet=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_category,selected_costcenter,selected_currency,selected_contact,selected_account,selected_vaccinationtype,selected_vaccine,selected_vet;
  DateTime Start_date = DateTime.now();
  DateTime End_Date = DateTime.now();
  TextEditingController amount,dose;
  String token;
  var vaccinationdropdown;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  _state_add_farrier (this.token);

  @override
  void initState() {
    amount= TextEditingController();
    dose= TextEditingController();

    vaccination_services.vaccinationDropdown(token).then((response){
      setState(() {
        print(response);
        vaccinationdropdown=json.decode(response);
        for(int i=0;i<vaccinationdropdown['horseDropDown'].length;i++)
          horse.add(vaccinationdropdown['horseDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['vaccinationTypeDropDown'].length;i++)
          vaccinationtype.add(vaccinationdropdown['vaccinationTypeDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['vetDropDown'].length;i++)
          vet.add(vaccinationdropdown['vetDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['vaccineDropDown'].length;i++)
          vaccine.add(vaccinationdropdown['vaccineDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['currencyDropDown'].length;i++)
          currency.add(vaccinationdropdown['currencyDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['categoryDropDown'].length;i++)
          category.add(vaccinationdropdown['categoryDropDown'][i]['name']);
        for(int i=0;i<vaccinationdropdown['costCenterDropDown'].length;i++)
          costcenter.add(vaccinationdropdown['costCenterDropDown'][i]['name']);

        print(contact);

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
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Horse",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Horse"),
                          items: horse!=null?horse.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Horse",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_horse=value;
                              selected_horse_id = horse.indexOf(value);
                            });
                          },
                        ),
                      ),
                        Padding(
                          padding: EdgeInsets.only(left: 16,right: 16),
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
                              this.Start_date=value;
                            },
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
                            decoration: InputDecoration(labelText: "End Date",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              this.End_Date=value;
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "vaccination",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Vaccination"),
                          items: vaccinationtype!=null?vaccinationtype.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Vaccine Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              this.selected_vaccinationtype=value;
                              selected_vaccinationtype_id = vaccinationtype.indexOf(value);
                            });
                          },
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "vaccine",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Vaccine"),
                          items: vaccine!=null?vaccine.map((types)=>DropdownMenuItem(
                            child: Text(types),
                            value: types,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Vaccine",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState((){
                              this.selected_vaccine=value;
                              selected_vaccine_id = vaccine.indexOf(value);
                            });
                          },
                        ),

                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: dose,
                          attribute: "Dose",
                          decoration: InputDecoration(labelText: "No of Dose",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "vet",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Vet"),
                          items: vet!=null?vet.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Vet",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_vet=value;
                              selected_vet_id = vet.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_vet=value;
                              selected_vet_id = vet.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                        child: FormBuilderTextField(
                          controller: amount,
                          attribute: "amount",
                          decoration: InputDecoration(labelText: "Amount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Cost Center",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Center"),
                          items: costcenter!=null?costcenter.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Cost Center",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_costcenter=value;
                              selected_costcenter_id = costcenter.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_costcenter=value;
                              selected_costcenter_id = costcenter.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Account Category",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Category"),
                          items:  category!=null?category.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Account Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_category=value;
                              selected_category_id = category.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_category=value;
                              selected_category_id = category.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "currency",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Currency"),
                          items:  currency!=null?currency.map((plans)=>DropdownMenuItem(
                            child: Text(plans),
                            value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                          decoration: InputDecoration(labelText: "Currency",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(
                                    color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              this.selected_currency = value;
                              selected_currency_id = currency.indexOf(value);
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              this.selected_currency = value;
                              selected_currency_id = currency.indexOf(value);
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Center(
                    child:Padding(
                      padding: const EdgeInsets.all(16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            print(_fbKey.currentState.value);


                            print(token);print(vaccinationdropdown['horseDropDown'][selected_horse_id]['id']);print(selected_vaccine_id);
                            print(vaccinationdropdown['vaccinationTypeDropDown'][selected_vaccinationtype_id]['id']);
                            print("farrier show");
                            print(selected_contact_id);
                            print(amount.text);
                            print(vaccinationdropdown['costCenterDropDown'][selected_costcenter_id]['id']);

                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            vaccination_services.vaccinationSave(null,token,0, vaccinationdropdown['horseDropDown'][selected_horse_id]['id'],Start_date,End_Date, vaccinationdropdown['vaccinationTypeDropDown'][selected_vaccinationtype_id]['id'],vaccinationdropdown['vaccineDropDown'][selected_vaccine_id]['id'],vaccinationdropdown['vetDropDown'][selected_vet_id]['id'],dose.text,amount.text, vaccinationdropdown['currencyDropDown'][selected_currency_id]['id'], vaccinationdropdown['categoryDropDown'][selected_category_id]['id'], vaccinationdropdown['costCenterDropDown'][selected_costcenter_id]['id'],).then((response){
                              pd.dismiss();
                              if(response !=null) {
                                print("Successfully lab test added");
                              Navigator.of(context).pop();
                              }else{
                                print("data not added");}
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