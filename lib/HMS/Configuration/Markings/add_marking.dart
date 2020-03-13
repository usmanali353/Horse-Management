import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Configuration/Markings/marking_json.dart';



class add_marking extends StatefulWidget{
  final token;
  add_marking(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_marking(token);
  }
}



class _add_marking extends State<add_marking>{
  final token;
  _add_marking(this.token);
 String selected_marking;
  int selected_marking_id;

  List<String> marking_type=['Head','Body','Legs'];
  TextEditingController name,abbreviation;
  //var currency_response;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
    this.abbreviation=TextEditingController();
//    Utils.check_connectivity().then((result){
//      if(result){
//        CurrenciesServices.getCurrencyDropdown(token).then((response){
//          if(response!=null){
//            print(response);
//            setState(() {
//              currency_response=json.decode(response);
//              for(int i=0;i<currency_response.length;i++)
//                currency.add(currency_response[i]['name']);
//
//              // stocks_loaded=true;
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
        appBar: AppBar(title: Text("Add Markings"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //visible: stocks_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Marking Type",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Marking Type"),
                              items:marking_type!=null?marking_type.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Marking Type",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_marking=value;
                                  this.selected_marking_id=marking_type.indexOf(value);
                                });
                              },
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
                            controller: abbreviation,
                            attribute: "Abbreviation",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Abbreviation",
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
                             MarkingServices.addMarkings(token, 0,name.text,abbreviation.text, null,selected_marking_id).then((response){
                                setState(() {
                                  var parsedjson  = jsonDecode(response);
                                  if(parsedjson != null){
                                    if(parsedjson['isSuccess'] == true){
                                      print("Successfully data saved");
                                    }else
                                      print("not saved");
                                  }else
                                    print("json response null");
                                });
                              });
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
