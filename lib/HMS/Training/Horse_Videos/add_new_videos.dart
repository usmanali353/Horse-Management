import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';

class add_new_videos extends StatefulWidget{
  String token;

  add_new_videos(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _state_add_new_videos(token);
  }

}
class _state_add_new_videos extends State<add_new_videos>{
TextEditingController comment,link,title;
DateTime date;
String token;

_state_add_new_videos(this.token);

bool horses_loaded=false;
List<String> horses=[];
String selected_horse;
int selected_horse_id;
var dropdown_data;
final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

@override
void initState() {
  super.initState();
  comment=TextEditingController();
  title=TextEditingController();
  link=TextEditingController();
 Utils.check_connectivity().then((result){
    if(result){
      network_operations.get_video_dropdowns(token).then((response){
        if(response!=null){
          setState(() {
            dropdown_data=json.decode(response);
            for(int i=0;i<dropdown_data['horseDropDown'].length;i++){
              horses.add(dropdown_data['horseDropDown'][i]['name']);
            }
            horses_loaded=true;
          });
    }else{
          setState(() {
            horses_loaded=false;
          });
    }
 });
     }else{
       print("Network not Available");
     }
  });
}

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add new Video"),),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child:FormBuilderDateTimePicker(
                    attribute: "date",
                    style: Theme.of(context).textTheme.body1,
                    inputType: InputType.date,
                    validators: [FormBuilderValidators.required()],
                    format: DateFormat("MM-dd-yyyy"),
                    decoration: InputDecoration(labelText: "Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),),
                    onChanged: (value){
                      setState(() {
                         date=value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Visibility(
                    visible: horses_loaded,
                    child: FormBuilderDropdown(
                      attribute: "Horse",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Horse"),
                      items:horses!=null?horses.map((horse)=>DropdownMenuItem(
                        child: Text(horse),
                        value: horse,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Horse",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          this.selected_horse=value;
                          this.selected_horse_id=horses.indexOf(value);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderTextField(
                    attribute: "Video Link",
                    controller: link,
                    validators: [FormBuilderValidators.required()],
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Video Link",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderTextField(
                    attribute: "Title",
                    controller: title,
                    validators: [FormBuilderValidators.required()],
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderTextField(
                    attribute: "Comments",
                    controller: comment,
                    validators: [FormBuilderValidators.required()],
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Comments",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
          add_video_button(token: token, comment: comment, title: title, link: link, date: date, selected_horse: selected_horse, selected_horse_id: selected_horse_id,fbKey: _fbKey,)
        ],
      ),
    );
  }


}

class add_video_button extends StatelessWidget {
  const add_video_button({
    Key key,
    @required this.token,
    @required this.comment,
    @required this.title,
    @required this.link,
    @required this.date,
    @required this.selected_horse,
    @required this.selected_horse_id,
    @required GlobalKey<FormBuilderState> fbKey,
  }) : _fbKey = fbKey, super(key: key);
  final GlobalKey<FormBuilderState> _fbKey;
  final String token;
  final TextEditingController comment;
  final TextEditingController title;
  final TextEditingController link;
  final DateTime date;
  final String selected_horse;
  final int selected_horse_id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top:16),
        child: MaterialButton(
          color: Colors.teal,
          child: Text("Add Video",style: TextStyle(color: Colors.white),),
          onPressed: (){
            if(_fbKey.currentState.validate()){
              Utils.check_connectivity().then((result){
                if(result){
                  ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                  pd.show();
                  network_operations.add_video(token, 0, comment.text, title.text, link.text, date, selected_horse, selected_horse_id,'').then((response){
                    pd.dismiss();
                    if(response!=null){
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Video Added Sucessfully"),
                      ));
                    }else{
                      Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Video Not Added"),
                      ));
                    }
                  });
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Network Not Available"),
                  ));
                }
              });
            }
          },
        ),
      ),
    );
  }
}
