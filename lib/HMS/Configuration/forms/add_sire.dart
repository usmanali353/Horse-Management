import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class add_sire extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_sire_state();
  }
}

class _add_sire_state extends State<add_sire> {
  String _date = "Date";



  String dropdownValue = 'Select';
  TextEditingController barn_name_controller;

  @override
  void initState() {
    barn_name_controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Sire"),
      ),
      body: Column(
        children: <Widget>[

















          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              obscureText: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                labelText: "Barn Name",
                labelStyle:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              obscureText: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                labelText: "Number",
                labelStyle:
                TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              obscureText: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                labelText: "Micro Chip",
                labelStyle:
                TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),border: Border.all(color: Colors.grey)),
            height: 60,
            child: DropdownButton<String>(
            hint: Container(
              padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width*0.85, //You can set width here.
            child: new Text(
              "Select Breed",
            style: TextStyle(fontSize: 30.0),
            ),
            ),
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal,fontSize: 20),



              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            color: Colors.transparent,
            child: Column(
//              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.only(left: 10,right: 10),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 2.0,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                          print('confirm $date');
                          _date = '${date.year} - ${date.month} - ${date.day}';
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    " $_date",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Icon(
                            Icons.arrow_drop_down
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),

              ],
            ),
          ),

          MaterialButton(
            onPressed: () {},
            child: Text(
              "Add Barn",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.teal,
          )
        ],
      ),
    );
  }
}
