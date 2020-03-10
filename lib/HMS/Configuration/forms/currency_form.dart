import 'package:flutter/material.dart';
import 'package:horse_management/screens/tasks_Page.dart';


class currency_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _currency_form();
  }

}
class _currency_form extends State<currency_form>{
  TextEditingController barn_name_controller;

  @override
  void initState() {
    barn_name_controller=new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Form"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select Currency",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
              isDense: true,
              underline:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: <String>['United State Dollars', 'Euro',].map((String value) {
                return  DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String value) {
                print(value);
              },
            ),
          ),

          MaterialButton(
            onPressed: (){

            },
            child: Text("Save",style: TextStyle(color: Colors.white),),
            color: Colors.teal,
          )
        ],
      ),
    );
  }

}