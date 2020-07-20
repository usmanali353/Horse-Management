import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/IronBrand/ironbrand_json.dart';
import 'package:horse_management/Utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';



class update_ironbrand extends StatefulWidget{
  final token;
  var picture_data;
  update_ironbrand(this.token, this.picture_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_ironbrand(token,picture_data);
  }

}
class _update_ironbrand extends State<update_ironbrand>{

  final token;
  var picture_data;

  String select_image;
  DateTime Select_date = DateTime.now();
  TextEditingController title;
  _update_ironbrand(this.token, this.picture_data);
  int image_id;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  Uint8List picked_image;
  @override
  void initState() {
    title=TextEditingController();

   setState(() {
      if(picture_data['brandTitle']!=null){
        title.text=picture_data['brandTitle'];
      }
      if(picture_data['brandImage']!=null){
        Uint8List bytes = base64.decode(picture_data['brandImage']);
        picked_image=bytes;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Iron Brand"),),
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
                  add_picture_button(token: token,title: title,fbKey: _fbKey,picked_image: picked_image, picture_data: picture_data),
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
    @required this.picture_data,
  }) :_fbKey = fbKey, super(key: key);
  final String token;
  final Uint8List picked_image;
  final GlobalKey<FormBuilderState> _fbKey;
  final TextEditingController title;
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
                    IronBrandServices.addIronBrand(token,picture_data['brandId'],title.text,picture_data['createdBy'],picked_image).then((response){
                      pd.dismiss();
                      if(response!=null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Updated"),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pop(context);
                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Not Updated"),
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
            child:Text("Update",style: TextStyle(color: Colors.white),),
          ),
        )
    );
  }
}