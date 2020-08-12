import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:horse_management/HMS/All_Horses_data/services/vaccination_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class update_vaccination extends StatefulWidget{
  String token,createdBy;
   var vaccinationlist;
  update_vaccination (this.vaccinationlist,this.token,this.createdBy);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_farrier(vaccinationlist,token,createdBy);
  }

}
class _state_add_farrier extends State<update_vaccination>{
  int selected_horse_id,selected_vaccinationtype_id,selected_vaccine_id,selected_vet_id,selected_costcenter_id,selected_category_id,selected_contact_id,selected_currency_id;
  List<String> horse=[];List<String> vaccinationtype=[];List<String> vaccine=[];List<String> vet=[];List<String> currency=[];List<String> category=[];List<String> costcenter=[];
  List<String> contact=[];
  String selected_horse,selected_category,selected_costcenter,selected_currency,selected_contact,selected_account,selected_vaccinationtype,selected_vaccine,selected_vet;
  DateTime Start_date = DateTime.now();
  DateTime End_Date = DateTime.now();
  TextEditingController amount,dose;
  String token,createdBy;
  var vaccinationlist;
  var vaccinationdropdown;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();


  _state_add_farrier (this.vaccinationlist,this.token,this.createdBy);

  @override
  void initState() {
    amount= TextEditingController();
    dose= TextEditingController();
    setState(() {
      amount.text = vaccinationlist['amount'].toString();
      dose.text = vaccinationlist['noOfDoses'].toString();
    });

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
        appBar: AppBar(title: Text("Update Vaccination"),),
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
                          hint: Text("- Select -"),
                          initialValue: vaccinationlist['horseName']['name'],
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
                          initialValue: DateTime.parse(vaccinationlist['startDate']!= null ? vaccinationlist['startDate']:DateTime.now()),
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
                          onSaved: (value){
                            this.Start_date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "date",
                          initialValue: DateTime.parse(vaccinationlist['endDate']!= null ? vaccinationlist['endDate']:DateTime.now()),
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
                          onSaved: (value){
                            this.End_Date=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "vaccination",
                          initialValue: vaccinationlist['vaccinationTypeId']!= null ? vaccinationlist['vaccinationTypeName']['vaccinationType']:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
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
                          onSaved: (value){
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
                          hint: Text("- Select -"),
                          initialValue: vaccinationlist['vaccineId']!= null ? vaccinationlist['vaccineName']['name']:null,
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
                          onSaved: (value){
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
                          keyboardType: TextInputType.number,
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
                          initialValue: vaccinationlist['vetId']!= null ? vaccinationlist['vetName']['contactName']['name']:null,
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
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
                        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Cost Center",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
                          initialValue: get_costcenter_by_id(vaccinationlist['costCenterId']),
                          items: costcenter!=null?costcenter.map((plans)=>DropdownMenuItem(
                            child: Text(plans), value: plans,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(), style: Theme.of(context).textTheme.body1,
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
                          initialValue: get_category_by_id(vaccinationlist['categoryId']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
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
                          initialValue: get_currency_by_id(vaccinationlist['currencyId']),
                          validators: [FormBuilderValidators.required()],
                          hint: Text("- Select -"),
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
                            _fbKey.currentState.save();

                            print(createdBy);
                            print(vaccinationlist['vaccinationId']);
                            print(token);print(vaccinationdropdown['horseDropDown'][selected_horse_id]['id']);print(selected_vaccine_id);
                            print(vaccinationdropdown['vaccinationTypeDropDown'][selected_vaccinationtype_id]['id']);
                            print("farrier show");
                            print(selected_contact_id);
                            print(amount.text);
                            print(vaccinationdropdown['costCenterDropDown'][selected_costcenter_id]['id']);

                            ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            vaccination_services.vaccinationSave(vaccinationlist['createdBy'],token,vaccinationlist['vaccinationId'], vaccinationdropdown['horseDropDown'][selected_horse_id]['id'],Start_date,End_Date, vaccinationdropdown['vaccinationTypeDropDown'][selected_vaccinationtype_id]['id'],vaccinationdropdown['vaccineDropDown'][selected_vaccine_id]['id'],vaccinationdropdown['vetDropDown'][selected_vet_id]['id'],dose.text,amount.text, vaccinationdropdown['currencyDropDown'][selected_currency_id]['id'], vaccinationdropdown['categoryDropDown'][selected_category_id]['id'], vaccinationdropdown['costCenterDropDown'][selected_costcenter_id]['id'],).then((response){
                              pd.dismiss();
                              if(response !=null) {
                                var decode= jsonDecode(response);
                                if(decode['isSuccess'] == true){
                                  Flushbar(message: "update Successfully",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,)
                                    ..show(context);}
                                else{
                                  Flushbar(message: "Not updated",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                              }else{
                                Flushbar(message: "Not updated",duration: Duration(seconds: 3),backgroundColor: Colors.red,)..show(context);}
                            });

                          }
                        },
                        child:Text("Update",style: TextStyle(color: Colors.white),),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }
  String get_currency_by_id(int id){
    var plan_name;
    if(vaccinationlist!=null&&vaccinationdropdown['currencyDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(vaccinationdropdown['currencyDropDown'][i]['id']==id){
          plan_name=vaccinationdropdown['currencyDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_category_by_id(int id){
    var plan_name;
    if(vaccinationlist!=null&&vaccinationdropdown['categoryDropDown']!=null&&id!=null){
      for(int i=0;i<category.length;i++){
        if(vaccinationdropdown['categoryDropDown'][i]['id']==id){
          plan_name=vaccinationdropdown['categoryDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_costcenter_by_id(int id){
    var plan_name;
    if(vaccinationlist!=null&&vaccinationdropdown['costCenterDropDown']!=null&&id!=null){
      for(int i=0;i<costcenter.length;i++){
        if(vaccinationdropdown['costCenterDropDown'][i]['id']==id){
          plan_name=vaccinationdropdown['costCenterDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
  String get_contact_by_id(int id){
    var plan_name;
    if(vaccinationlist!=null&&vaccinationdropdown['contactsDropDown']!=null&&id!=null){
      for(int i=0;i<contact.length;i++){
        if(vaccinationdropdown['contactsDropDown'][i]['id']==id){
          plan_name=vaccinationdropdown['contactsDropDown'][i]['name'];
        }
      }
      return plan_name;
    }else
      return null;
  }
}