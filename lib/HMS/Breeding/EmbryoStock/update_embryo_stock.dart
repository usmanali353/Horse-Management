
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'embryo_stock_json.dart';

class update_embryo_stock extends StatefulWidget{
  final token;
  final stock_data;

  update_embryo_stock(this.token, this.stock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_embryo_stock(token, stock_data);
  }
}



class _update_embryo_stock extends State<update_embryo_stock>{
  String token;
  var stock_data;
  _update_embryo_stock(this.token, this.stock_data);
  String ddvalue,selected_horse,selected_tank, selected_sire, selected_gender, select_on_sale;
  DateTime Collection_date = DateTime.now();
  int selected_horse_id=0,selected_tank_id=0,selected_sire_id=0,selected_gender_id;
  bool selected_on_sale_id;
  // sqlite_helper local_db;

  List<String> horses=[],tanks=[],sire=[],gender=['Male', 'Female','Geilding'], on_sale=['Yes','No'];
  var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController price,grade,stage,status,comments;
  bool _isvisible=false;
  bool stocks_loaded=false;
  bool update_stock_visibility;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.price=TextEditingController();
    this.grade=TextEditingController();
    this.stage=TextEditingController();
    this.status=TextEditingController();
    this.comments=TextEditingController();
    setState(() {
      if(stock_data['price']!=null){
        price.text=stock_data['price'].toString();
      }
      if(stock_data['grade']!=null){
        grade.text=stock_data['grade'];
      }
      if(stock_data['stage']!=null){
        stage.text=stock_data['stage'];
      }
      if(stock_data['status']!=null){
        status.text=stock_data['status'];
      }
      if(stock_data['comments']!=null){
        comments.text=stock_data['comments'];
      }

    });
    EmbryoStockServices.get_embryo_stock_dropdowns(token).then((response){
      if(response!=null){
        setState(() {
          stock_response=json.decode(response);
              for(int i=0;i<stock_response['horseDropDown'].length;i++)
                horses.add(stock_response['horseDropDown'][i]['name']);
              for(int i=0;i<stock_response['tankDropDown'].length;i++)
                tanks.add(stock_response['tankDropDown'][i]['name']);
              for(int i=0;i<stock_response['sireDropDown'].length;i++)
                sire.add(stock_response['sireDropDown'][i]['name']);
        });
      }
    });
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

//  @override
//  void initState() {
//    this.price=TextEditingController();
//    this.grade=TextEditingController();
//    this.stage=TextEditingController();
//    this.status=TextEditingController();
//    this.comments=TextEditingController();
//    // local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        EmbryoStockServices.get_embryo_stock_dropdowns(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              stock_response=json.decode(response);
//              for(int i=0;i<stock_response['horseDropDown'].length;i++)
//                horses.add(stock_response['horseDropDown'][i]['name']);
//              for(int i=0;i<stock_response['tankDropDown'].length;i++)
//                tanks.add(stock_response['tankDropDown'][i]['name']);
//              for(int i=0;i<stock_response['sireDropDown'].length;i++)
//                sire.add(stock_response['sireDropDown'][i]['name']);
//              stocks_loaded=true;
//              update_stock_visibility=true;
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Embryo Stock"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: Visibility(
                           // visible: stocks_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Horse",
                              initialValue: stock_data['horseName']['name'],
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
                              onSaved: (value){
                                setState(() {
                                  this.selected_horse=value;
                                  this.selected_horse_id=horses.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Tanks",
                            initialValue: stock_data['tankName']['name'],
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Tanks"),
                            items: tanks!=null?tanks.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Tanks",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_tank=value;
                                this.selected_tank_id=tanks.indexOf(value);
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.selected_tank=value;
                                this.selected_tank_id=tanks.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Sire",
                            initialValue: stock_data['sireName']['name'],
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Sire"),
                            items: sire!=null?sire.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Sire",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_sire=value;
                                this.selected_sire_id=sire.indexOf(value);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Gender",
                            initialValue: stock_data['genderId']!=null?gender[stock_data['genderId']]:null,
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Gender"),
                            items: gender!=null?gender.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Gender",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Male")
                                  selected_gender_id = 1;
                                else if(value == "Female")
                                  selected_gender_id = 2;
                                else if(value == "Geilding")
                                  selected_gender_id = 3;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                if(value == "Male")
                                  selected_gender_id = 1;
                                else if(value == "Female")
                                  selected_gender_id = 2;
                                else if(value == "Geilding")
                                  selected_gender_id = 3;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child:FormBuilderDateTimePicker(
                            attribute: "Collection Date",
                            initialValue: stock_data['collectionDate']!=null?DateTime.parse(stock_data['collectionDate']):null,
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
                                this.Collection_date=value;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                this.Collection_date=value;
                              });
                            },
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "On Sale",
                            initialValue: get_yesno(stock_data['onScale']),
                            validators: [FormBuilderValidators.required()],
                            hint: Text("onScale"),
                            items: on_sale!=null?on_sale.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "On Sale",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_on_sale_id = true;
                                else if(value == "No")
                                  selected_on_sale_id = false;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_on_sale_id = true;
                                else if(value == "No")
                                  selected_on_sale_id = false;
                              });
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.number,
                            controller: price,
                            attribute: "Price",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Price",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: Text("Embryo"),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: grade,
                            attribute: "Grade",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Grade",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: stage,
                            attribute: "Stage",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Stage",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: status,
                            attribute: "Status",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Status",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
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
                      ],
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context){
                      return  Center(
                        child:Padding(
                          padding: const EdgeInsets.all(16),
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Update",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                _fbKey.currentState.save();
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    EmbryoStockServices.add_embryo_stock(stock_data['createdBy'],token, stock_data['embryoStockId'],stock_response['horseDropDown'][selected_horse_id]['id'], stock_response['tankDropDown'][selected_tank_id]['id'], stock_response['sireDropDown'][selected_sire_id]['id'], selected_gender_id, Collection_date,selected_on_sale_id, price.text, grade.text, stage.text, status.text, comments.text)
                                        .then((response){
                                      pd.dismiss();
                                      if(response!=null){
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Embryo Stock Updated"),
                                          backgroundColor: Colors.green,
                                        ));
                                        Navigator.pop(context);
                                      }else{
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Embryo Stock not Updated"),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    });
                                  }
                                });

                              }
                            },
                          ),
                        ),
                      );
                    }

                  ),
                ],
              )
            ]
        )
    );
  }

}

