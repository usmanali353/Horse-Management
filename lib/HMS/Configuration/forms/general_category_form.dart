import 'package:flutter/material.dart';
import 'package:horse_management/screens/tasks_Page.dart';


class general_category_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _general_category_form();
  }

}
class _general_category_form extends State<general_category_form>{
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
        title: Text("General Category Form"),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              maxLines: null,
              minLines: 5,
              decoration: InputDecoration(
                  hintText: "Add Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))
              ),
              autofocus: true,
              keyboardType: TextInputType.multiline,
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