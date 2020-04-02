import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class next_breeding_check extends StatefulWidget{
  String token;
 // int nextchexkId;
  next_breeding_check(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _next_breeding_check(token);
  }

}
class _next_breeding_check extends State<next_breeding_check>{
  DateTime date;
  var breeding_control_list;
  String token;
  //int nextchexkId;
  _next_breeding_check(this.token);
  TextEditingController comments;
  String selected_reason;
  int selected_reason_id;
  List<String> reason_list=['Follicle Scan','Routine'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comments=TextEditingController();

//    network_operations.get_breeding_control_dropdowns(token).then((response){
//      if(response!=null){
//        setState(() {
//          breeding_control_list=json.decode(response);
//          currency_loaded=true;
//          account_category_loaded=true;
//          horses_loaded=true;
//          vets_loaded=true;
//          related_services_loaded=true;
//          for(int i=0;i<breeding_control_list['currencyDropDown'].length;i++){
//            currency.add(breeding_control_list['currencyDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['costCenterDropDown'].length;i++){
//            cost_center.add(breeding_control_list['costCenterDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['contactsDropDown'].length;i++){
//            contacts.add(breeding_control_list['contactsDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['horseDropDown'].length;i++){
//            horses.add(breeding_control_list['horseDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['categoryDropDown'].length;i++){
//            account_category.add(breeding_control_list['categoryDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['relatedServiceDropDown'].length;i++){
//            related_services.add(breeding_control_list['relatedServiceDropDown'][i]['name']);
//          }
//          for(int i=0;i<breeding_control_list['vetDropDown'].length;i++){
//            vet.add(breeding_control_list['vetDropDown'][i]['name']);
//          }
//
//        });
//
//      }else{
//
//      }
//    });
  }
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Next Breeding Check"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top:16),
                      child:FormBuilderDateTimePicker(
                        attribute: "Next Check",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("MM-dd-yyyy"),
                        decoration: InputDecoration(labelText: "Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                        onChanged: (value){
                          setState(() {
                            this.date=value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Reason",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Reason"),
                        items: reason_list.map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            this.selected_reason=value;
                            this.selected_reason_id=reason_list.indexOf(value)+1;
                          });
                        },
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Reason",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16,right: 16,left: 16),
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
              add_breeding_control_button(token: token,selected_reason_id: selected_reason_id,selected_reason: selected_reason,comments: comments,date: date,)
            ],
          )
        ],
      ),
    );
  }

}

class add_breeding_control_button extends StatelessWidget {
  const add_breeding_control_button({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.token,
    @required this.comments,
    @required this.selected_reason_id,
    @required this.selected_reason,
    @required this.date,
  }) : _fbKey = fbKey, super(key: key);
  final GlobalKey<FormBuilderState> _fbKey;
  final DateTime date;
  final String token,selected_reason;
  final int selected_reason_id;
  final TextEditingController comments;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: MaterialButton(
          color: Colors.teal,
          onPressed: (){
            if (_fbKey.currentState.validate()) {
              Utils.check_connectivity().then((result){
                if(result){
                  ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                  pd.show();
                  network_operations.save_next_breeding_check(token, 0, true, date, selected_reason_id, comments.text, null)
                      .then((response){
                    pd.dismiss();
                    if(response!=null){
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text("Breeding Control Added Sucessfully"),
//                        backgroundColor: Colors.green,
//                      ));
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Breeding Control not Added Sucessfully"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  });
                }
              });

            }
          },

          child: Text("Save",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}