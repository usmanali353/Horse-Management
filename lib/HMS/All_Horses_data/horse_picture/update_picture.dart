import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
class update_picture extends StatefulWidget{
  String token;
  var picture_data;
  update_picture(this.token,this.picture_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_picture_state(token,picture_data);
  }

}
class _update_picture_state extends State<update_picture>{
  String token;
  var picture_data;

  _update_picture_state(this.token, this.picture_data);

  String select_horse, select_image;
  DateTime Select_date = DateTime.now();
  TextEditingController title,description;
  List<String> horse_name =[];
  var horsedropdown;
  var data;
  int horse_id, image_id;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  Uint8List picked_image;
  @override
  void initState() {
    title=TextEditingController();
    description=TextEditingController();
    setState(() {
      if(picture_data['title']!=null){
        title.text=picture_data['title'];
      }
      if(picture_data['description']!=null){
        description.text=picture_data['description'];
      }
      if(picture_data['image']!=null){
        Uint8List bytes = base64.decode(picture_data['image']);
        picked_image=bytes;
      }
    });
    network_operations.get_pictures_dropdown(token).then((response){
      setState(() {
        horsedropdown=json.decode(response);
        for(int i=0;i<horsedropdown['horseDropDown'].length;i++)
          horse_name.add(horsedropdown['horseDropDown'][i]['name']);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Horse Picture"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                      key: _fbKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top:16,left: 16,right: 16),
                            child:FormBuilderDateTimePicker(
                              attribute: "date",
                              style: Theme.of(context).textTheme.body1,
                              inputType: InputType.date,
                              initialValue: picture_data['date']!=null?DateTime.parse(picture_data['date']):null,
                              validators: [FormBuilderValidators.required()],
                              decoration: InputDecoration(labelText: "Date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),),
                              onSaved: (value){
                                setState(() {
                                  this.Select_date=value;
                                });
                              },
                              onChanged: (value){
                                setState(() {
                                  this.Select_date=value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                            child: FormBuilderDropdown(
                              attribute: "Horse",
                              validators: [FormBuilderValidators.required()],
                              initialValue: picture_data['horseName']['name'],
                              hint: Text("Horse"),
                              items: horse_name.map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Horse",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onSaved: (value){
                                setState(() {
                                  this.select_horse=value;
                                  horse_id= horse_name.indexOf(value);
                                });
                              },
                              onChanged: (value){
                                setState(() {
                                  horse_id= horse_name.indexOf(value);
                                  this.select_horse=value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: FormBuilderTextField(
                              controller: title,
                              attribute: "title",
                              decoration: InputDecoration(labelText: "Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: description,
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                  hintText: "Description",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0))
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MaterialButton(
                              color: Colors.teal,
                              onPressed: (){
                                Utils.getImage().then((image_file){
                                  if(image_file!=null){
                                    image_file.readAsBytes().then((image){
                                      if(image!=null){
                                        setState(() {
                                          this.picked_image=image;
                                        });
                                      }
                                    });
                                  }else{

                                  }
                                });
                              },
                              child: Text("Select Image",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      )
                  ),
                  add_picture_button(picture_data:picture_data,token: token,description: description,title: title,Select_date: Select_date,fbKey: _fbKey,horse_id: horse_id,horsedropdown: horsedropdown,picked_image: picked_image,),
                ],

              ),

            ]
        )
    );
  }
}

class add_picture_button extends StatelessWidget {
  const add_picture_button({
    Key key,
    @required this.Select_date,
    @required this.token,
    @required this.picked_image,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.horse_id,
    @required this.title,
    @required this.description,
    @required this.horsedropdown,
    @required this.picture_data,
  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final DateTime Select_date;
  final Uint8List picked_image;
  final GlobalKey<FormBuilderState> _fbKey;
  final int horse_id;
  final TextEditingController title;
  final TextEditingController description;
  final horsedropdown;
  final picture_data;
  @override
  Widget build(BuildContext context) {
    return Center(
        child:Padding(
          padding: EdgeInsets.all(16),
          child: MaterialButton(
            color: Colors.teal,
            onPressed: (){
              Utils.check_connectivity().then((result){
                if(result){
                  if (_fbKey.currentState.validate()) {
                    _fbKey.currentState.save();
                    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                    pd.show();
                    network_operations.add_pictures(picture_data['pictureId'],token,horsedropdown['horseDropDown'][horse_id]['id'],Select_date,title.text,description.text,picture_data['createdBy'],picked_image).then((response){
                      pd.dismiss();
                      if(response!=null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Picture Updated Sucessfully"),
                          backgroundColor: Colors.green,
                        ));
                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Picture not Updated"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    });
                  }
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Network not Available"),
                    backgroundColor: Colors.red,
                  ));
                }

              });

            },
            child:Text("Update Picture",style: TextStyle(color: Colors.white),),
          ),
        )
    );
  }
}