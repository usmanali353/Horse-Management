import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/TestTypes/testtype_json.dart';



class add_paddock extends StatefulWidget{
  String token;

  add_paddock(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_paddock(token);
  }
}



class _add_paddock extends State<add_paddock>{
  String token;
  _add_paddock(this.token);
  String selected_location;
  bool selected_reminder_id;

  // sqlite_helper local_db;
  List<String>  reminder=['Yes','No'] ;
  // var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,validity,showReminders;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
    this.validity=TextEditingController();
    this.showReminders=TextEditingController();
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
        appBar: AppBar(title: Text("Add Test Types"),),
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
                            controller: name,
                            attribute: "Test Type Name",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Test Type Name",
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
                            controller: validity,
                            keyboardType: TextInputType.number,
                            attribute: "Validity",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Validity",
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
                            attribute: "Reminder",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Reminder"),
                            items: reminder!=null?reminder.map((trainer)=>DropdownMenuItem(
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
                                  selected_reminder_id = true;
                                else if(value == "No")
                                  selected_reminder_id = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: showReminders,
                            keyboardType: TextInputType.number,
                            attribute: "Show Reminders",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Show Reminders",
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
                      child:Padding(
                          padding: const EdgeInsets.all(16),
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Save",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              print(validity);
                              print(showReminders);
                              TestTypesServices.addTestTypes(token, 0, name.text, validity.text, selected_reminder_id, showReminders.text, null,);
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

