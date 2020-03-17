import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';

import 'add_new_videos.dart';
import 'update_videos.dart';
import 'video_details.dart';

class horse_videos_list extends StatefulWidget{
  String token;

  horse_videos_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _horse_videos_list_page_state(token);
  }

}
class _horse_videos_list_page_state extends State<horse_videos_list>{
  String token;
  _horse_videos_list_page_state(this.token);
  bool isVisible=false;
  var temp=['','',''];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var videos_list;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_videos(token)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Videos"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
         return Utils.check_connectivity().then((result){
             if(result){
               network_operations.get_all_videos(token).then((response){
                 if(response!=null){
                   setState(() {
                     videos_list=json.decode(response);
                     isVisible=true;
                   });

                 }else{
                   setState(() {
                     isVisible=false;
                   });
                   Scaffold.of(context).showSnackBar(SnackBar(
                     backgroundColor: Colors.red,
                     content: Text("videos Not Available"),
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
        },
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:videos_list!=null?videos_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[

                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          network_operations.change_video_visibility(token, videos_list[index]['videoId']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                videos_list.removeAt(index);
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
                      IconSlideAction(
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_videos(token,videos_list[index])));
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(videos_list!=null?videos_list[index]['horseName']['name']:''),
                      subtitle: Text(videos_list!=null?videos_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
                      leading: Icon(
                        Icons.videocam,
                        size: 40,
                        color: Colors.teal,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>video_details(videos_list[index]['link'])));
                      },
                    )
                  ),
                   Divider(),
                ],
              );
          }),
        ),
      ),
    );
  }

}