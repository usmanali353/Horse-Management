import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class addProductsApplied extends StatefulWidget{
  String token;
  DateTime date;
  int horse_id,vet_id,type_id;
  var inventoryProductsDropDown;
  addProductsApplied(this.token, this.date, this.horse_id, this.vet_id,this.type_id,this.inventoryProductsDropDown);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addProductsAppliedState(token,date,horse_id,vet_id,type_id,inventoryProductsDropDown);
  }

}
class addProductsAppliedState extends State<addProductsApplied>{
  String token;
  DateTime date;
  int horse_id,vet_id,type_id;
  List<String> products=[];
  var selected_product=[];
  var quantityTECs = <TextEditingController>[];
  var cards = <Card>[];
  var inventoryProductsDropDown;
  addProductsAppliedState(this.token, this.date, this.horse_id, this.vet_id,this.type_id,this.inventoryProductsDropDown);
  @override
  void initState() {
    if(inventoryProductsDropDown!=null&&inventoryProductsDropDown.length>0){
      for(int i=0;i<inventoryProductsDropDown.length;i++){
        products.add(inventoryProductsDropDown[i]['name']);
      }
      cards.add(createCard());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Products Applied"),),
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
    if(inventoryProductsDropDown!=null&&inventoryProductsDropDown[selected_product[i]]['id']!=null) {
    product_id =
    inventoryProductsDropDown[selected_product[i]]['id'];
    }
    entries.add(productsApplied(quantity,0,product_id,0,'',DateTime.now()).toJson());
    }
//    if(vieterniaryServices.addVetVisits(token, 0, horse_id, vet_id, date, type_id, '', entries)!=null){
//
//    }else{
//
//    }
               ProgressDialog pd=ProgressDialog(context,type:ProgressDialogType.Normal,isDismissible: true,);
                 pd.show();
              vieterniaryServices.addVetVisits(token, 0, horse_id, vet_id, date, type_id, '', entries).then((response){
                 pd.hide();
                if(response!=null){
                  print("Vet Visit Inserted Sucessfully");
                }
              });
             }else{
               print("Vet Visit not Inserted");
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
              child: Text('add new'),
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
            Text('Applied Products ${cards.length + 1}'),
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
class productsApplied{
  int quantity,vetVisitsId,inventoryProductId,vetVisitsProductsId;
  String createdBy;
  DateTime createdOn;

  productsApplied(this.quantity, this.vetVisitsId, this.inventoryProductId,
      this.vetVisitsProductsId, this.createdBy, this.createdOn);
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["quantity"] = quantity;
    map["vetVisitsId"]=vetVisitsId;
    map["inventoryProductId"]=inventoryProductId;
    map["vetVisitsProductsId"]=vetVisitsProductsId;
    map["createdBy"]=createdBy;
    map["createdOn"]=createdOn;
    return map;
  }
}