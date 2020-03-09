import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/add_new_picture.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/update_picture.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
class pictures_list extends StatefulWidget{
  String token;

  pictures_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pictures_list_state(token);
  }

}
class _pictures_list_state extends State<pictures_list>{
  String token;
  var horse_list;
  var picture_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Pictures")),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_picture(token)));
          },

        ),
        body:
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    network_operations.get_all_pictures(token).then((response){
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          picture_list=json.decode(response);
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Pictures List Not Found"),
                        ));
                        setState(() {
                          isvisible=false;
                        });
                      }
                    });
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Network not Available"),
                    ));
                  }
                });
              },
              child: Visibility(
                visible: isvisible,
                child: ListView.builder(itemCount:picture_list!=null?picture_list.length:temp.length,itemBuilder: (context,int index){
                  return Column(
                    children: <Widget>[
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.20,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.blue,
                            caption: 'Update',
                            onTap: () async {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>update_picture(token,picture_list[index])));
                            },
                          ),
                        ],
                        actions: <Widget>[
                          IconSlideAction(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            caption: 'Hide',
                            onTap: () async {
                              network_operations.change_picture_visibility(token, picture_list[index]['pictureId']).then((response){
                                print(response);
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    picture_list.removeAt(index);
                                  });

                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Failed'),
                                  ));
                                }
                              });
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(picture_list!=null?picture_list[index]['horseName']['name']:''),
                          subtitle: Text(picture_list!=null?picture_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
                          leading: picture_list[index]['image']!=null?Image.memory(base64.decode(picture_list[index]['image'])):Text(''),
                        ),
                      ),
                      Divider(),
                    ],

                  );

                }),
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _pictures_list_state(this.token);
}