import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class add_contacts extends StatefulWidget{
  String token;
  add_contacts(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_contacts_state(token);
  }

}
class _add_contacts_state extends State<add_contacts>{
  String token;
  _add_contacts_state(this.token);
  Uint8List picked_image;
  var _myActivities = [];
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController name,cnic,address,mobile,phone,email,website,facebook,twitter,instagram;
  @override
  void initState() {
    name=TextEditingController();
    cnic=TextEditingController();
    address=TextEditingController();
    mobile=TextEditingController();
    phone=TextEditingController();
    email=TextEditingController();
    website=TextEditingController();
    facebook=TextEditingController();
    twitter=TextEditingController();
    instagram=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: FormBuilderTextField(
                        controller: name,
                        attribute: "Name",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: cnic,
                        attribute: "CNIC",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "CNIC",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: MultiSelectFormField(
                        hintText: "Select Contact Type",
                        errorText: "Select Atleast one Contact Type",
                        okButtonLabel: 'Ok',
                        cancelButtonLabel: 'Cancel',
                        textField: 'display',
                        valueField: 'value',
                        titleText: 'Contact Type',
                        value: _myActivities,
                        onSaved: (value) {
                          if (value == null) return;
                          setState(() {
                            _myActivities = value;
                          });
                        },
                        dataSource:[
                          {
                           "display":"Employee",
                            "value":"1"
                          },
                          {
                            "display":"Owner",
                            "value":"2"
                          },
                          {
                            "display":"Trainer",
                            "value":"3"
                          },
                          {
                            "display":"Customer",
                            "value":"4"
                          },
                          {
                            "display":"Farrier",
                            "value":"5"
                          },
                          {
                            "display":"Rider",
                            "value":"6"
                          },
                          {
                            "display":"Provider",
                            "value":"7"
                          },
                          {
                            "display":"Transportist",
                            "value":"8"
                          },
                          {
                            "display":"Vet",
                            "value":"9"
                          },
                          {
                            "display":"Breeder",
                            "value":"10"
                          },
                          {
                            "display":"Member",
                            "value":"11"
                          },
                          {
                            "display":"Prospect",
                            "value":"12"
                          },
                          {
                            "display":"Others",
                            "value":"13"
                          },

                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text("Address Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: address,
                        attribute: "Address",
                        decoration: InputDecoration(labelText: "Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: mobile,
                        attribute: "Mobile #",
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: "Mobile #",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: phone,
                        attribute: "Phone #",
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: "Phone #",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text("Email and Website",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: email,
                        attribute: "Email",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: website,
                        attribute: "Website",
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: "Website",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text("Social Media Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: facebook,
                        attribute: "Facebook",
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: "Facebook",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: instagram,
                        attribute: "Instagram",
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: "Instagram",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16,left: 16,right: 16),
                      child: FormBuilderTextField(
                        controller: twitter,
                        attribute: "Twitter",
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: "Twitter",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text("Picture",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: RaisedButton(
                          onPressed: (){
                            Utils.getImage().then((image_file){
                              if(image_file!=null){
                                 image_file.readAsBytes().then((imageInbytes){
                                   if(imageInbytes!=null){
                                      setState(() {
                                        this.picked_image=imageInbytes;
                                      });
                                   }else{

                                   }
                                 });
                              }else{

                              }
                            });
                          },
                          color: Colors.teal,
                          child: Text("Select Picture",style: TextStyle(color:Colors.white),),
                        )
                    ),
                  ],
                ),

              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: MaterialButton(
                    onPressed: (){
                      if(_fbKey.currentState.validate()){

                      }
                    },
                    child: Text("Add Contact",style: TextStyle(color: Colors.white),),
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
