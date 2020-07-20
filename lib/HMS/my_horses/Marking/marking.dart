import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/add_new_picture.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/update_picture.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'add_marking.dart';
class marking extends StatefulWidget{


  var horseData;

  marking(this.horseData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _marking_state(horseData);
  }

}
class _marking_state extends ResumableState<marking> {
  String token;
  var horse_list,horseData;

  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  @override
  void onResume() {
    if(resume.data.toString()== "close"){
      Navigator.pop(context,"close");
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Marking")),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          print(horseData['horseId']);
          push(context, MaterialPageRoute(builder: (context)=>addMarking(horseData)));
        },

      ),
      body: Visibility(
        visible: true,
          child: ListView(
            children: <Widget>[
            ListTile(
                  title: Text(horseData!=null?horseData['name']:''),
                 // subtitle: Text(horseData!=null?horseData['date'].toString().replaceAll("T00:00:00",''):''),
                  leading: horseData['horseDetails']['markingPhoto']!=null?Image.memory(base64.decode(horseData['horseDetails']['markingPhoto'])):Image.asset("assets/horse_icon.png", fit: BoxFit.cover),

              onTap: (){
                if(horseData['horseDetails']['markingPhoto']!=null) {
                  return showDialog<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Preview',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.1
                            ),
                          ),
                          content: Image.memory(base64.decode(
                              horseData['horseDetails']['markingPhoto'])),
                        );
                      }
                  );
                }
                  },
                ),
            ],
          ),

//        child: ListView.builder(itemCount:horseData!=null?horseData.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
//              Slidable(
//                actionPane: SlidableDrawerActionPane(),
//                actionExtentRatio: 0.20,
//                secondaryActions: <Widget>[
//
//                ],
//                actions: <Widget>[
//                  IconSlideAction(
//                    icon: Icons.visibility_off,
//                    color: Colors.red,
//                    caption: 'Hide',
//                    onTap: () async {
//                      network_operations.change_picture_visibility(token, picture_list[index]['pictureId']).then((response){
//                        print(response);
//                        if(response!=null){
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.green ,
//                            content: Text('Visibility Changed'),
//                          ));
//                          setState(() {
//                            picture_list.removeAt(index);
//                          });
//
//                        }else{
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.red ,
//                            content: Text('Failed'),
//                          ));
//                        }
//                      });
//                    },
//                  ),
//                  IconSlideAction(
//                    icon: Icons.edit,
//                    color: Colors.blue,
//                    caption: 'Update',
//                    onTap: () async {
//                      Navigator.push(context,MaterialPageRoute(builder: (context)=>update_picture(token,picture_list[index])));
//                    },
//                  ),
//                ],
//                child: ListTile(
//                  title: Text(picture_list!=null?picture_list[index]['horseName']['name']:''),
//                  subtitle: Text(picture_list!=null?picture_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
//                  leading: picture_list[index]['image']!=null?Image.memory(base64.decode(picture_list[index]['image'])):Text(''),
//                  onTap: (){
//                    return showDialog<Null>(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return AlertDialog(
//                            title: Text(
//                              'Preview',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w300,
//                                  letterSpacing: 1.1
//                              ),
//                            ),
//                            content: Image.memory(base64.decode(picture_list[index]['image'])),
//                          );
//                        }
//                    );
//                  },
//                ),
//              ),
//              Divider(),
//            ],
//
//          );
//
//        }),
      ),
    );
  }

//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//  }

  _marking_state(this.horseData);
}