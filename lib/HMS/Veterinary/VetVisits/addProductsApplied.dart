import 'package:flutter/material.dart';

class addProductsApplied extends StatefulWidget{
  String token;
  DateTime date;
  int horse_id,vet_id,type_id;
  addProductsApplied(this.token, this.date, this.horse_id, this.vet_id,this.type_id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addProductsAppliedState(token,date,horse_id,vet_id,type_id);
  }

}
class addProductsAppliedState extends State<addProductsApplied>{
  String token;
  DateTime date;
  int horse_id,vet_id,type_id;
  List<String> products;
  var selected_product=[];
  var quantityTECs = <TextEditingController>[];
  var cards = <Card>[];
  addProductsAppliedState(this.token, this.date, this.horse_id, this.vet_id,this.type_id);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Products Applied"),),
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
          )
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
          ]
      ),
    );
  }


}