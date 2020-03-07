import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class add_tanks_form extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_tanks_form();
  }

}
class _add_tanks_form extends State<add_tanks_form>{
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
      appBar: AppBar(title: Text("Add Tanks Form"),),
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
                    Padding(padding: EdgeInsets.only(top:15 ,bottom: 10),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10 ,bottom: 10),
                      child:  FormBuilderDropdown(
                        attribute: "name",
                        style: Theme.of(context).textTheme.body1,
                        decoration: InputDecoration(labelText: "Location",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select Location'),
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
                    Padding(
                      padding: EdgeInsets.only(top:10 ,bottom: 10),
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
                                onChanged: (String val) => setState(() => _Name = val ),
                                validator: (value) {
                                  if(value.isEmpty){
                                    return 'Please fill empty space';
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: "Capacity",
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
                    Padding(padding: EdgeInsets.only(top:10 ,bottom: 10),
                      child:  FormBuilderDateTimePicker(
                        attribute: "date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("dd-MM-yyyy"),
                        decoration: InputDecoration(labelText: "Last Fill Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10 ,bottom: 10),
                      child:  FormBuilderDateTimePicker(
                        attribute: "date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("dd-MM-yyyy"),
                        decoration: InputDecoration(labelText: "Next Fill Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10 ,bottom: 10),
                      child: FormBuilderTextField(
                        attribute: 'text',
                        style: Theme.of(context).textTheme.body1,
                        //validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Insurrance Policy#",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top:10 ,bottom: 10),
                      child:  FormBuilderDateTimePicker(
                        attribute: "date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("dd-MM-yyyy"),
                        decoration: InputDecoration(labelText: "Insurance Policy Due Date",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),),
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