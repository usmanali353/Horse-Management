import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/VaccinationTypes/vaccinationtypes_json.dart';


class update_vaccinationtypes extends StatefulWidget{
  String token;
  var specifictype;

  update_vaccinationtypes(this.token, this.specifictype);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_vaccinationtypes(token,specifictype);
  }
}



class _update_vaccinationtypes extends State<update_vaccinationtypes>{
  String token;
  var specifictype;
  _update_vaccinationtypes(this.token,this.specifictype);
  String selected_canDelayed;
  bool selected_canDelayed_id;

  // sqlite_helper local_db;
  List<String>  canBeDelayed=['Yes','No'] ;
  //var stock_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
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
        appBar: AppBar(title: Text("Add Vaccination Type"),),
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
                            attribute: "Vaccination Type",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Vaccination Type",
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
                            attribute: "Can Be Delayed",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Can Be Delayed"),
                            items: canBeDelayed!=null?canBeDelayed.map((trainer)=>DropdownMenuItem(
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
                                  selected_canDelayed_id = true;
                                else if(value == "No")
                                  selected_canDelayed_id = false;
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
                            child: Text("Update",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              VaccinationTypesServices.addVaccinationType(token, specifictype['vaccinationTypeId'], name.text, selected_canDelayed_id,specifictype['createdBy'] );
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

