import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/IronBrand/ironbrand_json.dart';
import 'package:horse_management/Utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';



class add_ironbrand extends StatefulWidget{
  final token;
  add_ironbrand(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_ironbrand(token);
  }

}
class _add_ironbrand extends State<add_ironbrand>{
  final token;
  String select_image;
  DateTime Select_date = DateTime.now();
  TextEditingController title,description;
  _add_ironbrand (this.token);
  int image_id;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  Uint8List picked_image;
  @override
  void initState() {
    title=TextEditingController();
//    description=TextEditingController();
//    network_operations.get_pictures_dropdown(token).then((response){
//      setState(() {
//        horsedropdown=json.decode(response);
//        for(int i=0;i<horsedropdown['horseDropDown'].length;i++)
//          horse_name.add(horsedropdown['horseDropDown'][i]['name']);
//      });
//    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Horse Picture"),),
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
                              controller: title,
                              attribute: "Title",
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
                  add_picture_button(token: token,title: title,fbKey: _fbKey,picked_image: picked_image,),
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
    @required this.token,
    @required this.picked_image,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.title,
  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final Uint8List picked_image;
  final GlobalKey<FormBuilderState> _fbKey;
  final TextEditingController title;
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
                    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                    pd.show();
                    IronBrandServices.addIronBrand(token,0,title.text,null,picked_image).then((response){
                      pd.dismiss();
                      if(response!=null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Data Added Sucessfully"),
                          backgroundColor: Colors.green,
                        ));
                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Data not Added"),
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
            child:Text("Save",style: TextStyle(color: Colors.white),),
          ),
        )
    );
  }
}