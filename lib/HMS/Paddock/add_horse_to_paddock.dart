import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';


class add_horse_to_paddock extends StatefulWidget{
  String token;
  int paddockId;
  add_horse_to_paddock(this.token,this.paddockId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_horse_to_paddock(token,paddockId);
  }
}



class _add_horse_to_paddock extends State<add_horse_to_paddock>{
  String token;
  int paddockId;

  _add_horse_to_paddock(this.token,this.paddockId);
  String selected_horse;
  int selected_horse_id=0;

  List<String> paddock_horse=[];
  var horse_response;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    Utils.check_connectivity().then((result){
      if(result){
        PaddockServices.get_add_horses_to_paddock_dropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              horse_response=json.decode(response);
              for(int i=0;i<horse_response['horsesDropDown'].length;i++)
                paddock_horse.add(horse_response['horsesDropDown'][i]['name']);
              // stocks_loaded=true;
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
        appBar: AppBar(title: Text("Add Horse To Paddock"),),
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
                              attribute: "Select Horse",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Select Horse"),
                              items:paddock_horse!=null?paddock_horse.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Select Horse",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_horse=value;
                                  this.selected_horse_id=paddock_horse.indexOf(value);
                                });
                              },
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
                              if (_fbKey.currentState.validate()) {
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    PaddockServices.save_horses_to_paddock_dropdowns(token, 0, paddockId, selected_horse_id, '')
                                        .then((respons){
                                      pd.dismiss();
                                      setState(() {
                                        var parsedjson  = jsonDecode(respons);
                                        if(parsedjson != null){
                                          if(parsedjson['isSuccess'] == true){
                                            print("Successfully data updated");
                                          }else
                                            print("not saved");
                                        }else
                                          print("json response null");
                                      });
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

