import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/add_new_note.dart';
import 'package:horse_management/HMS/All_Horses_data/Horse_Notes/update_notes.dart';

import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class notes_list extends StatefulWidget{
  String token;

  notes_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _notes_list_state(token);
  }

}
class _notes_list_state extends State<notes_list>{
  String token;
  var horse_list;
  var notes_list=[], load_list;
  var temp=['',''];
  bool isvisible=false;
  int pagenum=1,total_page;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Notes"),actions: <Widget>[
        Center(child: Text("Add New",textScaleFactor: 1.3,)),
        IconButton(

          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_note(token)));
          },
        )
      ],),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                  if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        network_operations.get_all_notes(token,pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            notes_list = load_list['response'];
                            print(notes_list);
                          });
                        });
                      }else
                        print("network nahi hai");
                    });
                  }
                  else{
                    print("list empty");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum > 1){
                    pagenum = pagenum - 1;
                  }
                  print(pagenum);
                }),
                FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                  print(load_list['hasNext']);
                  if(load_list['hasNext'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        network_operations.get_all_notes(
                            token,pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            notes_list = load_list['response'];
                            print(notes_list);
                          });
                        });
                      }else
                        print("network nahi hai");
                    });
                  }
                  else{
                    print("list empty");
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                  }
                  if(pagenum < total_page) {
                    pagenum = pagenum + 1;
                  }
                  print(pagenum);

                })
              ]
          )
      ),

        body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                    pd.show();
                    network_operations.get_all_notes(token,1).then((response){
                      pd.dismiss();
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          load_list=json.decode(response);
                          notes_list = load_list['response'];
                          total_page=load_list['totalPages'];
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Notes List Not Found"),
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
                child: ListView.builder(itemCount:notes_list!=null?notes_list.length:temp.length,itemBuilder: (context,int index){
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
                              network_operations.change_notes_visibility(token, notes_list[index]['trainingId']).then((response){
                                print(response);
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    notes_list.removeAt(index);
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>update_notes(token,notes_list[index])));
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(notes_list!=null?notes_list[index]['horseName']['name']:''),
                          subtitle: Text(notes_list!=null?notes_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
                          //subtitle: Text(training_list!=null?get_training_type_by_id(training_list[index]['trainingType']):''),
                          leading: Icon(Icons.note,size: 40,color: Colors.teal,),
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(training_list[index],get_training_type_by_id(training_list[index]['trainingType']))));
                          },
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

  _notes_list_state(this.token);

}