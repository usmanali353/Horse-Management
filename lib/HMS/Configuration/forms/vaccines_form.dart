import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class vaccines_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vaccines_form();
  }

}
class _vaccines_form extends State<vaccines_form>{
  TextEditingController barn_name_controller;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    barn_name_controller=new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccination Types Form"),
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
                labelText: "Vaccine Name",
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Show Reminders",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
              isDense: true,
              underline:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: <String>['Yes', 'No',].map((String value) {
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
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("Usage",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
              isDense: true,
              underline:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: <String>['Normal', 'Gestation','Both',].map((String value) {
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

          Padding(padding: const EdgeInsets.all(16),
          child: Text("NORMAL USAGE", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20,),)
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Primary Vaccination - Months", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Booster - Weeks", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Revaccination - Months", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16),
              child: Text("GASTINATION USAGE", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20,),)
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("1st dose - Month #", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("2nd dose - Month #", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("3rd dose - Month #", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold), ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(_controller.text);
                                  setState(() {
                                    currentValue++;
                                    _controller.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  print("Setting state");
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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