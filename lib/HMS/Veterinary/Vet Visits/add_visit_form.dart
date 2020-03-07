import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class add_visit_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_visit_form();
  }

}
class _add_visit_form extends State<add_visit_form>{
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  String _date = "Date";
  String _Name =  "";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Vet Visit Form"),),
      body:  Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top:5 ,bottom: 13),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Horse",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Horse'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Male', 'Female', 'Other']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:2 ,bottom: 2),
                      child:  FormBuilderDateTimePicker(
                        attribute: "date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("dd-MM-yyyy"),
                        decoration: InputDecoration(labelText: "Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:7 ,bottom: 7),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Type'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Routine','Monitoring','Emergency',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Vet",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Vet'),
                        validators: [FormBuilderValidators.required()],
                        items: ['',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Person In-Charge",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Reason",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Parameters", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: Container(
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
//                                onChanged: (String val) => setState(() => _Name = val ),
//                                validator: (value) {
//                                  if(value.isEmpty){
//                                    return 'Please fill empty space';
//                                  }
//                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Temperature (C)",
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: Container(
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
//                                onChanged: (String val) => setState(() => _Name = val ),
//                                validator: (value) {
//                                  if(value.isEmpty){
//                                    return 'Please fill empty space';
//                                  }
//                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Heart Rate (per min)",
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: Container(
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
//                                onChanged: (String val) => setState(() => _Name = val ),
//                                validator: (value) {
//                                  if(value.isEmpty){
//                                    return 'Please fill empty space';
//                                  }
//                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Breathing Frequency (per min)",
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: Container(
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
//                                onChanged: (String val) => setState(() => _Name = val ),
//                                validator: (value) {
//                                  if(value.isEmpty){
//                                    return 'Please fill empty space';
//                                  }
//                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Capilary Filling (seg)",
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: Container(
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
//                                onChanged: (String val) => setState(() => _Name = val ),
//                                validator: (value) {
//                                  if(value.isEmpty){
//                                    return 'Please fill empty space';
//                                  }
//                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Dehydration (%)",
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
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
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Mucous Memberanes",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Pink'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Pink','Pale','Icetrus','Cyanotics', 'Congested']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Comments",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Hooves", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Pulse",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Increased','Decreased',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Hoof (front left)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Cold','Hot']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Hoof (front right)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Cold','Hot']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Hoof (rear left)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Cold','Hot']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Hoof (rear right)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Cold','Hot']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Intestines", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Movements (Left)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Increased','Decreased',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Movements (Right)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Increased','Decreased',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Presence of Faeces",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Yes'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Yes','No',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Consistency of Faeces",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Firm'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Firm','Pasty','Liquid']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Comments",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Respiratory", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Effort",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Increased','Decreased',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Pulmonary Auscultation",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Normal'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Normal','Diminished','Wheezing','Rales',]
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Trachea Auscultation",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Air'),
                        validators: [FormBuilderValidators.required()],
                        items: ['Air','Liquid','Stridor']
                            .map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                          onChanged: (value) {
                            setState(() => _Name = value);
                            print(value);
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Diagnosis & Treatment", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Diagnosis",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Observations",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:8 ,bottom: 8),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Treatment",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 250),
                        child: Text("Products Applied", style: TextStyle(color: Colors.teal,fontSize: 25, fontWeight: FontWeight.bold),)
                    ),
                    Padding(padding: EdgeInsets.only(right: 350),
                      child: IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.teal,
                        onPressed: ()  {}
                      ),
                    ),
                    MaterialButton(
                      onPressed: (){
                        _fbKey.currentState.save();
                        if (_fbKey.currentState.validate()) {
                          print(_fbKey.currentState.value);
                        }
                      },
                      child: Text("Save",style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.teal,
                    ),
                  ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );

  }

}