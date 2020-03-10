import 'package:flutter/material.dart';

class performance_type_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _performance_type_form();
  }

}
class _performance_type_form extends State<performance_type_form>{
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
        title: Text("Performance Type Form"),
      ),
      body: ListView(
        children: <Widget>[
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
          MaterialButton(
            onPressed: (){

            },
            child: Text("Save",style: TextStyle(color: Colors.white),
           ),
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

}