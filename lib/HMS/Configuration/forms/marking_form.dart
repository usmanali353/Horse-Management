import 'package:flutter/material.dart';

class marking_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _marking_form_state();
  }

}
class _marking_form_state extends State<marking_form>{
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
        title: Text("Marking Form"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Select marking type",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
              isDense: true,
              underline:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: <String>['Select marking type', 'Head', 'Body', 'Legs',].map((String value) {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
              obscureText: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)
                ),
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
              obscureText: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)
                ),
                labelText: "Abbreviation",
                labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
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