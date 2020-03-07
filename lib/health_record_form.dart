import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Model/Health_Record.dart';
import 'package:horse_management/Model/sqlite_helper.dart';

class health_record_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _health_record_form();
  }

}
class _health_record_form extends State<health_record_form>{
  String selected_horse,selected_health_record_type,selected_responsible,selected_cost_center,selected_category,selected_contact,selected_currency;
  int selected_quantity,selected_amount;
  sqlite_helper local_db;
   TextEditingController product,comment;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    local_db=sqlite_helper();
    product=TextEditingController();
    comment=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Health Record"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormBuilderDropdown(
                        attribute: "Horse",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Horse"),
                        items: ["Select Horse","Horse 1","Horse 2","Horse 3"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Horse",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_horse=value;
                        },
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Record type",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Record Type"),
                        items: ["Select Record Type","Healing","Deworming","Treatment","Vaccination","Odontology"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Record Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_health_record_type=value;
                        },
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Responsible",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Responsible"),
                        items: ["Select Responsible"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Responsible",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_responsible=value;
                        },
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderTextField(
                        attribute: "Product",
                        controller: product,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Product",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                      child: FormBuilderTouchSpin(
                        attribute: "Quantity",
                        initialValue: 1,
                        step: 1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Quantity",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_quantity=value;
                        },

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderTextField(
                        attribute: "Comment",
                        controller: comment,
                        decoration: InputDecoration(labelText: "Comment",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                      child: FormBuilderTouchSpin(
                        attribute: "Amount",
                        initialValue: 1,
                        step: 1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_amount=value;
                        },

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Currency",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Currency"),
                        items: ["Select Currency"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Currency",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_currency=value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Category",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Category"),
                        items: ["Select Category"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Category",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_category=value;
                        },
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Cost Center",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Cost Center"),
                        items: ["Select Cost Center"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Cost Center",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_cost_center=value;
                        },
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                      child: FormBuilderDropdown(
                        attribute: "Contact",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Contact"),
                        items: ["Select Contact"].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Contact",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        onChanged: (value){
                          this.selected_contact=value;
                        },
                      ),

                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MaterialButton(
                    onPressed: (){
                      local_db.create_health_record(new Health_Record(selected_amount,selected_quantity,selected_horse,selected_health_record_type,selected_responsible,product.text,comment.text,selected_currency,selected_category,selected_cost_center,selected_contact)).then((value){
                        if(value>0){
                              print("health record inserted Sucessfully");
                        }else{
                              print("health record insertion Failed");
                        }
                      });
                    },
                    child: Text("Add Health Record",style: TextStyle(color: Colors.white),),
                    color: Colors.teal,
                  ),
                ),
              )
            ],
          )

     ]

    )
    );
  }


}
