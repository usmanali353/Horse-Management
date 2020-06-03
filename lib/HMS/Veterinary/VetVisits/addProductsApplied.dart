import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/vetVisitsList.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class addProductsApplied extends StatefulWidget {
  String token;
  DateTime date;
  bool feces_presences;
  String reason, temperature, heart_rate, breathing_freq, capilary_filling, dehydration, overall_mood, observation,diagnosis, dt_observation, treatment;
  int horse_id, vet_id, type_id, responsible_id,  mucus_membrane,  pulse, hoof_FL, hoof_FR, hoof_RL, hoof_RR, movement_L, movement_R,
       feces_consistancy,  effort, pulmonary_Auscultation, trachea_Auscultation;
  var inventoryProductsDropDown;
  addProductsApplied(this.token, this.date, this.horse_id, this.vet_id,
      this.type_id, this.inventoryProductsDropDown, this.responsible_id,
      this.reason, this.temperature, this.heart_rate, this.breathing_freq, this.capilary_filling, this.dehydration, this.mucus_membrane, this.overall_mood,
      this.pulse, this.hoof_FL, this.hoof_FR, this.hoof_RL, this.hoof_RR, this.movement_L, this.movement_R, this.feces_presences, this.feces_consistancy, this.observation,
      this.effort, this.pulmonary_Auscultation, this.trachea_Auscultation, this.diagnosis, this.dt_observation, this.treatment);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addProductsAppliedState(token, date, horse_id, vet_id, type_id, inventoryProductsDropDown, responsible_id,
      reason, temperature, heart_rate, breathing_freq, capilary_filling, dehydration, mucus_membrane, overall_mood, pulse, hoof_FL, hoof_FR, hoof_RL, hoof_RR, movement_L, movement_R,
    feces_presences, feces_consistancy, observation, effort, pulmonary_Auscultation, trachea_Auscultation, diagnosis, observation, treatment );
  }
}

class addProductsAppliedState extends State<addProductsApplied> {
  String token;
  DateTime date;
  bool feces_presence;
  String reason, temperature, heart_rate, breathing_freq, capilary_filling, dehydration, overall_mood, observation, diagnosis, dt_observation, treatement;
  int horse_id, vet_id, type_id, responsible_id,  mucus_membrane,
  pulse, hoof_FL, hoof_FR, hoof_RL, hoof_RR, movement_L, movement_R,  feces_consistancy,
  effort, pulmonary_Auscultation, trachea_Auscultation;
  List<String> products = [];
  var selected_product = [];
  var quantityTECs = <TextEditingController>[];
  var cards = <Card>[];
  var inventoryProductsDropDown;
  addProductsAppliedState(this.token, this.date, this.horse_id, this.vet_id,
      this.type_id, this.inventoryProductsDropDown, this.responsible_id,
      this.reason, this.temperature, this.heart_rate, this.breathing_freq, this.capilary_filling, this.dehydration, this.mucus_membrane, this.overall_mood,
      this.pulse, this.hoof_FL, this.hoof_FR, this.hoof_RL, this.hoof_RR, this.movement_L, this.movement_R, this.feces_presence, this.feces_consistancy, this.observation,
      this.effort, this.pulmonary_Auscultation, this.trachea_Auscultation, this.diagnosis, this.dt_observation, this.treatement);
  @override
  void initState() {
    if (inventoryProductsDropDown != null &&
        inventoryProductsDropDown.length > 0) {
      for (int i = 0; i < inventoryProductsDropDown.length; i++) {
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
      appBar: AppBar(
        title: Text("Add Products Applied"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          setState(() => cards.add(createCard()));
        },
      ),
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
          Builder(
            builder: (BuildContext context){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: Text('Add Vet Visit'),
                    onPressed: () {
                      Utils.check_connectivity().then((result) {
                        if (result) {
                          List<Map> entries = [];
                          var quantity, product_id;
                          for (int i = 0; i < cards.length; i++) {
                            if (quantityTECs[i].text != null) {
                              quantity = int.parse(quantityTECs[i].text);
                            }
                            if (inventoryProductsDropDown != null &&
                                inventoryProductsDropDown[selected_product[i]]
                                ['id'] !=
                                    null) {
                              product_id =
                              inventoryProductsDropDown[selected_product[i]]
                              ['id'];
                            }
                            entries.add(productsApplied(
                                quantity, 0, product_id, 0, '', DateTime.now())
                                .toJson());
                          }
                          ProgressDialog pd = ProgressDialog(
                            context,
                            type: ProgressDialogType.Normal,
                            isDismissible: true,
                          );
                          pd.show();
                          vieterniaryServices
                              .addVetVisits(token, 0, horse_id, vet_id, date, type_id,
                              '', entries, responsible_id, reason, temperature, heart_rate, breathing_freq, capilary_filling,dehydration, mucus_membrane,
                              overall_mood, pulse, hoof_FL,hoof_FR, hoof_RL, hoof_RR, movement_L, movement_R, feces_presence,feces_consistancy, observation, effort,
                              pulmonary_Auscultation, trachea_Auscultation, diagnosis, dt_observation, treatement)
                              .then((response) {
                            pd.dismiss();
                            if (response != null) {
                              print("object");
//                        Scaffold.of(context).showSnackBar(SnackBar(
//                          backgroundColor: Colors.green,
//                          content: Text("Vet Visit Added Sucessfully"),
//                        ));
                              sleep(Duration(seconds: 3));
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                                return vetVisitList(token);     }));
                              // Navigator.pop(context);
                            }else{
                              print("don not save");

//                        Scaffold.of(context).showSnackBar(SnackBar(
//                          backgroundColor: Colors.red,
//                          content: Text("Vet Visit not Added"),
//                        ));
                            }
                          });
                        } else {

                        }
                      });
                    },
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }

  Card createCard() {
    var quantityController = TextEditingController();
    quantityTECs.add(quantityController);
    return Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text('Applied Products ${cards.length + 1}'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField(
            hint: Text("Select Product"),
            items: products != null
                ? products
                    .map((trainer) => DropdownMenuItem(
                          child: Text(trainer),
                          value: trainer,
                        ))
                    .toList()
                : [""]
                    .map((name) =>
                        DropdownMenuItem(value: name, child: Text("$name")))
                    .toList(),
            decoration: InputDecoration(
              labelText: "Select Product",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.0),
                  borderSide: BorderSide(color: Colors.teal, width: 1.0)),
            ),
            onChanged: (value) {
              setState(() {
                selected_product.insert(
                    cards.length - 1, products.indexOf(value));
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
//                attribute: "Quantity",
//                validators: [FormBuilderValidators.required()],
            decoration: InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.0),
                  borderSide: BorderSide(color: Colors.teal, width: 1.0)),
            ),
          ),
        ),
      ]),
    );
  }
}

class productsApplied {
  int quantity, vetVisitsId, inventoryProductId, vetVisitsProductsId;
  String createdBy;
  DateTime createdOn;

  productsApplied(this.quantity, this.vetVisitsId, this.inventoryProductId,
      this.vetVisitsProductsId, this.createdBy, this.createdOn);
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["quantity"] = quantity;
    map["vetVisitsId"] = vetVisitsId;
    map["inventoryProductId"] = inventoryProductId;
    map["vetVisitsProductsId"] = vetVisitsProductsId;
    map["createdBy"] = createdBy;
    map["createdOn"] = createdOn;
    return map;
  }
}
