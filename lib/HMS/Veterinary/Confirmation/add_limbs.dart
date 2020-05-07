import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class addlimbs_dataApplied extends StatefulWidget{
  String token;
  DateTime date;
  int horse_id,vet_id,opinion_id;
  var limbsDropdown;
  addlimbs_dataApplied(this.token, this.date, this.horse_id, this.vet_id,this.opinion_id,this.limbsDropdown);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addlimbs_dataAppliedState(token,date,horse_id,vet_id,opinion_id,limbsDropdown);
  }

}
class addlimbs_dataAppliedState extends State<addlimbs_dataApplied>{
  String token;
  DateTime date;
  int horse_id,vet_id,opinion_id;
  List<String> limbs_data=[];
  var selected_limb=[];
  var quantityTECs = <TextEditingController>[];
  var cards = <Card>[];
  var limbsDropdown;
  addlimbs_dataAppliedState(this.token, this.date, this.horse_id, this.vet_id,this.opinion_id,this.limbsDropdown);
  @override
  void initState() {
    if(limbsDropdown!=null&&limbsDropdown.length>0){
      for(int i=0;i<limbsDropdown.length;i++){
        limbs_data.add(limbsDropdown[i]['name']);
      }
      cards.add(createCard());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Horse Limbs Data"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: (){
          Utils.check_connectivity().then((result){
            if(result){
              List<Map> entries=[];
              var quantity,product_id;
              for(int i=0;i<cards.length;i++){
                if(quantityTECs[i].text!=null) {
                  quantity = int.parse(quantityTECs[i].text);
                }
                if(limbsDropdown!=null&&limbsDropdown[selected_limb[i]]['id']!=null) {
                  product_id =
                  limbsDropdown[selected_limb[i]]['id'];
                }
                entries.add(limbs_dataApplied(quantity,0,product_id,0,'',DateTime.now()).toJson());
              }
              ProgressDialog pd=ProgressDialog(context,type:ProgressDialogType.Normal,isDismissible: true,);
              pd.show();
//              vieterniaryServices.addVetVisits(token, 0, horse_id, vet_id, date, opinion_id, '', entries).then((response){
//                pd.hide();
//                if(response!=null){
//
//                }
//              });
            }else{

            }
          });
        },
      ),
      body:  Column(
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
              child: Text('Add New'),
              onPressed: () => setState(() => cards.add(createCard())),
            ),
          ),
        ],
      ),
    );
  }
  Card createCard() {
    var quantityController = TextEditingController();
    quantityTECs.add(quantityController);
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Applied limbs_data ${cards.length + 1}'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField(
                hint: Text("Select Product"),
                items: limbs_data!=null?limbs_data.map((trainer)=>DropdownMenuItem(
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
                    selected_limb.insert(cards.length-1, limbs_data.indexOf(value));
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
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
          ]
      ),
    );
  }


}
class limbs_dataApplied{
  int quantity,vetVisitsId,inventoryProductId,vetVisitslimbs_dataId;
  String createdBy;
  DateTime createdOn;

  limbs_dataApplied(this.quantity, this.vetVisitsId, this.inventoryProductId,
      this.vetVisitslimbs_dataId, this.createdBy, this.createdOn);
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["quantity"] = quantity;
    map["vetVisitsId"]=vetVisitsId;
    map["inventoryProductId"]=inventoryProductId;
    map["vetVisitslimbs_dataId"]=vetVisitslimbs_dataId;
    map["createdBy"]=createdBy;
    map["createdOn"]=createdOn;
    return map;
  }
}