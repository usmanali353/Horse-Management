import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils.dart';

class dietDetails extends StatefulWidget{
  String token,dietName,dietDescription;

  dietDetails(this.token, this.dietName, this.dietDescription);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dietDetailsState(token, dietName, dietDescription);
  }

}
class dietDetailsState extends State<dietDetails>{
  var cards = <Card>[];
  String token,dietName,dietDescription;
 var dietDropDowns;
  var quantityTECs = <TextEditingController>[];
  dietDetailsState(this.token, this.dietName, this.dietDescription);
  List<String> products=[],time=[];
 var selected_product=[],selected_time=[];
  @override
  void initState() {
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        DietServices.newDietDropDown(token).then((response){
          pd.hide();
          if(response!=null){
            setState(() {
              dietDropDowns=json.decode(response);
             if(dietDropDowns['dietDetail']['dietTimeDropDown']!=null&&dietDropDowns['dietDetail']['dietTimeDropDown']>0) {
               for (int i = 0; i <
                   dietDropDowns['dietDetail']['dietTimeDropDown']
                       .length; i++) {
                 time.add(
                     dietDropDowns['dietDetail']['dietTimeDropDown'][i]['name']);
               }
             }
             if(dietDropDowns['dietDetail']['productTypesDropDown']!=null&&dietDropDowns['dietDetail']['productTypesDropDown'].length>0) {
               for (int i = 0; i <
                   dietDropDowns['dietDetail']['productTypesDropDown']
                       .length; i++) {
                 products.add(
                     dietDropDowns['dietDetail']['productTypesDropDown'][i]['name']);
               }
             }
              cards.add(createCard());
            });
          }else{

          }
        });
      }else{

      }
    });


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Add Diet Details")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text('add new'),
              onPressed: () => setState(() => cards.add(createCard())),
            ),
          )
        ],
      ),
        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.done), onPressed:() async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              var quantity,producttypeId,time;
              List<Map> entries = [];

             for(int i=0;i<cards.length;i++){
               if(quantityTECs[i].text!=null) {
                  quantity = int.parse(quantityTECs[i].text);
               }
               if(selected_product!=null&&selected_product.length>0){
                producttypeId=dietDropDowns['dietDetail']['productTypesDropDown'][selected_product[i]]['id'];
               }
               if(selected_time!=null&&selected_time.length>0){
                 time=dietDropDowns['dietDetail']['dietTimeDropDown'][selected_time[i]]['id'];
               }
               entries.add(dietDetail(producttypeId, quantity,time,0).toJson());
             }
              DietServices.newDietSave('', token, 0, dietName, dietDescription,entries).then((response){
                pd.hide();
                if(response!=null){
                  print("Diet Added Sucessfully");
                }
              });
            }else{

            }
          });
        } ),
    );
  }

  Card createCard() {
    var quantityController = TextEditingController();
    quantityTECs.add(quantityController);
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Diets ${cards.length + 1}'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField(
                hint: Text("Select Product"),
                items: products!=null?products.map((trainer)=>DropdownMenuItem(
                  child: Text(trainer),
                  value: trainer,
                )).toList():[""].map((name) => DropdownMenuItem(
                    value: name, child: Text("$name")))
                    .toList(),
                decoration: InputDecoration(labelText: "Select Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    selected_product.insert(cards.length-1, products.indexOf(value));
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: TextField(
                controller: quantityController,
                  keyboardType: TextInputType.number,
//                attribute: "Quantity",
//                validators: [FormBuilderValidators.required()],
                decoration: InputDecoration(labelText: "Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16,right: 16,left: 16,bottom: 16),
              child: DropdownButtonFormField(
              //attribute: "Time",
//                validators: [FormBuilderValidators.required()],
                hint: Text("Select Time"),
                items: time!=null?time.map((time)=>DropdownMenuItem(
                  child: Text(time),
                  value: time,
                )).toList():[""].map((name) => DropdownMenuItem(
                    value: name, child: Text("$name")))
                    .toList(),
                decoration: InputDecoration(labelText: "Select Time",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      borderSide: BorderSide(color: Colors.teal, width: 1.0)
                  ),
                ),
                onChanged: (value){
                 setState(() {
                   selected_time.insert(cards.length-1, time.indexOf(value));
                 });
                },
              ),
            ),
          ]
      ),
    );
  }

}
class dietDetail{
 int productTypesId,quantity,dietTimeId,id;

 dietDetail(this.productTypesId, this.quantity, this.dietTimeId,
     this.id);
 Map<String, dynamic> toJson() {
   var map = new Map<String, dynamic>();
   map["productTypesId"] = productTypesId;
   map["quantity"]=quantity;
   map["dietTimeId"]=dietTimeId;
   map["id"]=id;
   return map;
 }
}