
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/accountcategories_json.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class add_accountcategories extends StatefulWidget{
  String token;

  add_accountcategories(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_accountcategories(token);
  }
}



class _add_accountcategories extends State<add_accountcategories>{
  String token;
  _add_accountcategories(this.token);
  String ddvalue,selected_horse,selected_tank, selected_sire, selected_isIncome, selected_isActive;
  bool selected_isIncome_id, selected_isActive_id;

  // sqlite_helper local_db;
  List<String>  isIncome=['Yes','No'], isActive=['Yes','No'] ;
  var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController code,name,description;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.code=TextEditingController();
    this.name=TextEditingController();
    this.description=TextEditingController();
    // local_db=sqlite_helper();
//    Utils.check_connectivity().then((result){
//      if(result){
//        AccountCategoriesServices.get_embryo_stock_dropdowns(token).then((response){
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
//            });
//          }
//        });
//      }else{
//        print("Network Not Available");
//      }
//    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Account Categories"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: code,
                            attribute: "Code",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Code",
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
                            controller: name,
                            attribute: "Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Name",
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
                            controller: description,
                            attribute: "Description",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Description",
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
                            attribute: "Is Income",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Is Income"),
                            items: isIncome!=null?isIncome.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Is Income",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_isIncome_id = true;
                                else if(value == "No")
                                  selected_isIncome_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderDropdown(
                            attribute: "Is Active",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Is Active"),
                            items: isActive!=null?isActive.map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Is Income",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  selected_isActive_id = true;
                                else if(value == "No")
                                  selected_isActive_id = false;
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
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Save",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    AccountCategoriesServices.addAccountCategory(token, 0, code.text, name.text, description.text, null, selected_isIncome_id, selected_isActive_id)
                                        .then((respons){
                                      pd.dismiss();
                                      if(respons!=null){
//                                        Scaffold.of(context).showSnackBar(SnackBar(
//                                          content: Text("Saved "),
//                                          backgroundColor: Colors.green,
//                                        ));
                                      }else{
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Not Saved "),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    });
                                  }
                                });
                              }
                            },

                          )
                      )
                  )
                ],
              )
            ]
        )
    );
  }

}

