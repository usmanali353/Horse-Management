import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'breeding_sales_json.dart';

class breeding_sales_form extends StatefulWidget{
  final token;
  breeding_sales_form(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_sales_form(token);
  }

}
class _breeding_sales_form extends State<breeding_sales_form>{
  final token;
  _breeding_sales_form(this.token,);
  String ddvalue,selected_horse, selected_customer, selected_vet, selected_semen, selected_frozen, selected_cash_payment, selected_gift, selected_status, selected_currency, selected_category, selected_costcenter, selected_contact;
  DateTime select_date = DateTime.now();
  DateTime Payment_date = DateTime.now();
  int selected_horse_id=0,selected_customer_id=0,selected_vet_id=0, selected_status_id, selected_currency_id=0, selected_category_id=0, selected_costcenter_id=0,selected_contact_id=0;
  bool selected_semen_id;
  bool  selected_frozen_id;
  bool  selected_cashpaymemt_id;
  bool  selected_gift_id;

  List<String> horses=[],customer=[],vet=[],semen=['Yes','No'], frozen=['Yes','No'], cashpayment=['Yes','No'], gift=['Yes','No'], status=['Sold','Shipped','Delivered','Pregnant','Breeding Report',], currency=[], category=[], costcenter=[],contact=[];
  var sale_response, load_response;
  TextEditingController payment_reference,contract_no,report_no,comments,amount;


  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool _isvisible=false;
  bool sale_loaded=false;
  bool update_sales_visibility;


  @override
  void initState() {
    this.payment_reference=TextEditingController();
    this.contract_no=TextEditingController();
    this.report_no=TextEditingController();
    this.comments=TextEditingController();
    this.amount=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        BreedingSalesServices.get_breeding_sales_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              sale_response=json.decode(response);
              //sale_response = load_response['response'];
              for(int i=0;i<sale_response['horseDropDown'].length;i++)
                horses.add(sale_response['horseDropDown'][i]['name']);
              for(int i=0;i<sale_response['customerDropDown'].length;i++)
                customer.add(sale_response['customerDropDown'][i]['name']);
              for(int i=0;i<sale_response['assignedVetDropDown'].length;i++)
                vet.add(sale_response['assignedVetDropDown'][i]['name']);
              for(int i=0;i<sale_response['currencyDropDown'].length;i++)
                currency.add(sale_response['currencyDropDown'][i]['name']);
              for(int i=0;i<sale_response['categoryDropDown'].length;i++)
                category.add(sale_response['categoryDropDown'][i]['name']);
              for(int i=0;i<sale_response['costCenterDropDown'].length;i++)
                costcenter.add(sale_response['costCenterDropDown'][i]['name']);
              for(int i=0;i<sale_response['contactsDropDown'].length;i++)
                contact.add(sale_response['contactsDropDown'][i]['name']);
              sale_loaded=true;
              update_sales_visibility=true;
            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Breeding Sales"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                //autovalidate: true,
                child: Column(children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      //visible: sale_loaded,
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
                  Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child:  FormBuilderDateTimePicker(
                      onChanged: (value){
                        this.select_date=value;
                      },
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                    child: Visibility(
                      visible: sale_loaded,
                      child: FormBuilderDropdown(
                        attribute: "Customer",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Customer"),
                        items:customer!=null?customer.map((horse)=>DropdownMenuItem(
                          child: Text(horse),
                          value: horse,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Customer",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.selected_customer=value;
                            this.selected_customer_id=customer.indexOf(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Assigned Vet",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Assigned Vet"),
                      items: vet!=null?vet.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Assigned Vet",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          this.selected_vet=value;
                          this.selected_vet_id=vet.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:16,left: 16,right: 16),
                    child:FormBuilderDateTimePicker(
                      attribute: "Payment Date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("MM-dd-yyyy"),
                      decoration: InputDecoration(labelText: "Collection Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),),
                      onChanged: (value){
                        setState(() {
                          this.Payment_date=value;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      controller: payment_reference,
                      attribute: "Payment Reference",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Payment Reference",
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
                      attribute: "Semen",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Semen"),
                      items: semen!=null?semen.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Semen",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value == "Yes")
                            selected_semen_id = true;
                          else if(value == "No")
                            selected_semen_id = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Frozen",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Frozen"),
                      items: frozen!=null?frozen.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Frozen",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value == "Yes")
                            selected_frozen_id = true;
                          else if(value == "No")
                            selected_frozen_id = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Cash Payment",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Cash Paymment"),
                      items: cashpayment!=null?cashpayment.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Cash Payment",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value == "Yes")
                            selected_cashpaymemt_id = true;
                          else if(value == "No")
                            selected_cashpaymemt_id = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Gift",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Gift"),
                      items: gift!=null?gift.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Gift",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value == "Yes")
                            selected_gift_id = true;
                          else if(value == "No")
                            selected_gift_id = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Status",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Gender"),
                      items: status!=null?status.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Status",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),

                      onChanged: (value){
                        setState(() {
                          if(value == "Sold")
                            selected_status_id = 1;
                          else if(value == "Shipped")
                            selected_status_id = 2;
                          else if(value == "Delivered")
                            selected_status_id = 3;
                          else if(value == "Pregnant")
                            selected_status_id = 4;
                          else if(value == "Breeding Report")
                            selected_status_id = 5;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: contract_no,
                      attribute: "Contract No.",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Contract No.",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: report_no,
                      attribute: "Report No.",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(labelText: "Report No.",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      //keyboardType: TextInputType.number,
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
                    padding: EdgeInsets.only(left: 16,right: 16, top:16),
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      attribute: "Amount",
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
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Currency",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Currency"),
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
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Account Category",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Account Category"),
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
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Cost Center",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Cost Center"),
                      items: costcenter!=null?costcenter.map((trainer)=>DropdownMenuItem(
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
                          this.selected_costcenter=value;
                          this.selected_costcenter_id=costcenter.indexOf(value);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                    child: FormBuilderDropdown(
                      attribute: "Contact",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Contact"),
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
                    ),
                  ),

                  Builder(
                    builder: (BuildContext context){
                      return  MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                BreedingSalesServices.add_breeding_sales(null,token,0,sale_response['horseDropDown'][selected_horse_id]['id'],DateTime.now(), sale_response['customerDropDown'][selected_customer_id]['id'],sale_response['assignedVetDropDown'][selected_vet_id]['id'],Payment_date,payment_reference.text, selected_semen_id,selected_frozen_id,selected_cashpaymemt_id,selected_gift_id,selected_status_id, contract_no.text, report_no.text, comments.text,amount.text, sale_response['currencyDropDown'][selected_currency_id]['id'], sale_response['categoryDropDown'][selected_category_id]['id'], sale_response['costCenterDropDown'][selected_costcenter_id]['id'], sale_response['contactsDropDown'][selected_contact_id]['id'],  ).then((response){
                                  pd.dismiss();
                                  if(response!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Breeding Sales Added"),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pop(context);
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Breeding Sales not Added"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              }
                            });

                          }
                        },
                        child: Text("Save",style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.teal,
                      );
                    },

                  ),
            ],
          ),
        ),

        ],
      ),
    ),

        ),
    );

  }

}