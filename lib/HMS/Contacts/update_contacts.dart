import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Contacts/contactTypes.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class update_contacts extends StatefulWidget{
  String token;
  var contacts_data;
  update_contacts(this.token,this.contacts_data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_contacts_state(token,contacts_data);
  }

}
class  _update_contacts_state extends State<update_contacts>{
  String token;
  var contacts_data;
  _update_contacts_state(this.token,this.contacts_data);
  Uint8List picked_image;
  var _myActivities = [];
  List<Map> roles=[];
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
    if(contacts_data['website']!=null){
      website.text=contacts_data['website'];
    }
    if(contacts_data['facebook']!=null){
      facebook.text=contacts_data['facebook'];
    }
    if(contacts_data['instagram']!=null){
      instagram.text=contacts_data['instagram'];
    }
    if(contacts_data['twiter']!=null){
      twitter.text=contacts_data['twiter'];
    }
    if(contacts_data['email']!=null){
      email.text=contacts_data['email'];
    }
    if(contacts_data['cnic']!=null){
      cnic.text=contacts_data['cnic'];
    }
    if(contacts_data['name']!=null){
      name.text=contacts_data['name'];
    }
    if(contacts_data['address']!=null){
      address.text=contacts_data['address'];
    }
    if(contacts_data['phoneNo']!=null){
      phone.text=contacts_data['phoneNo'];
    }
    if(contacts_data['mobileNo']!=null){
      phone.text=contacts_data['mobileNo'];
    }


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Update Contact"),),
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
                        required: true,
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
              update_contact_button(fbKey: _fbKey, myActivities: _myActivities, roles: roles, token: token, name: name, website: website, facebook: facebook, instagram: instagram, twitter: twitter, email: email, address: address, mobile: mobile, phone: phone, cnic: cnic, picked_image: picked_image),
            ],
          ),
        ],
      ),
    );
  }

}

class update_contact_button extends StatelessWidget {
  const update_contact_button({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required List myActivities,
    @required this.roles,
    @required this.token,
    @required this.name,
    @required this.website,
    @required this.facebook,
    @required this.instagram,
    @required this.twitter,
    @required this.email,
    @required this.address,
    @required this.mobile,
    @required this.phone,
    @required this.cnic,
    @required this.picked_image,
  }) : _fbKey = fbKey, _myActivities = myActivities, super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;
  final List _myActivities;
  final List<Map> roles;
  final String token;
  final TextEditingController name;
  final TextEditingController website;
  final TextEditingController facebook;
  final TextEditingController instagram;
  final TextEditingController twitter;
  final TextEditingController email;
  final TextEditingController address;
  final TextEditingController mobile;
  final TextEditingController phone;
  final TextEditingController cnic;
  final Uint8List picked_image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: MaterialButton(
          onPressed: (){
            if(_fbKey.currentState.validate()){
              for(int i=0;i<_myActivities.length;i++){
                roles.add(contactTypes(int.parse(_myActivities[i])).toJson());
              }
              network_operations.add_contact(token, 0, name.text, website.text, facebook.text, instagram.text, twitter.text, email.text, address.text, mobile.text, phone.text, cnic.text, picked_image, roles).then((response){
                if(response!=null){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Contact Added Sucessfully"),
                    backgroundColor: Colors.green,
                  ));
                  Navigator.pop(context);
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Contact not Added"),
                    backgroundColor: Colors.red,
                  ));
                }
              });
            }
          },
          child: Text("Add Contact",style: TextStyle(color: Colors.white),),
          color: Colors.teal,
        ),
      ),
    );
  }
}
