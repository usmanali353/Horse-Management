//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:sqflite/sqflite.dart';
//import 'dart:async';
//import 'package:horse_management/HMS/Paddock/utils/database_helper.dart';
//import 'package:horse_management/HMS/Paddock/models/paddock.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//
//import 'add_paddock_form.dart';
//
//
//class paddocks extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _paddocks_State();
//  }
//
//}
//
//class _paddocks_State extends State<paddocks>{
//  int count = 0;
//  DatabaseHelper dataBaseHelper = DatabaseHelper();
//  List<Paddocks> paddockList;
//
//  @override
//  Widget build(BuildContext context) {
//    if(paddockList == null){
//      paddockList = List<Paddocks>();
//      updateListView();
//    }
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(title: Text("Paddocks"),),
//      body: getPaddockListView(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          debugPrint("FAB Clicked");
//          navigateToDetail(Paddocks('','',1,'',2,3,'','','',''),'Add Group');
//          // Navigator.push(context,MaterialPageRoute(builder: (context)=>add_new_opertation_note()));
//        },
//        tooltip: 'Add Paddocks Form',
//        child: Icon(Icons.add),
//      ), // This trailing comma mak
//    );
//  }
//  void updateListView(){
//    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
//    dbFuture.then((database){
//      Future<List<Paddocks>> noteListFuture = dataBaseHelper.getPaddockList();
//      noteListFuture.then((noteList){
//        setState(() {
//          this.paddockList = noteList;
//          this.count = noteList.length;
//        });
//      });
//    }
//    );
//  }
//  ListView getPaddockListView(){
//    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
//    return ListView.builder(
//        shrinkWrap: true,
//        itemCount: count,
//        itemBuilder: (BuildContext context, int position) {
//          return Slidable(
//            actionPane: SlidableDrawerActionPane(),
//            actionExtentRatio: 0.20,
//            child: ListTile(
//              onTap: () {
//                debugPrint("ListTile Tapped");
//                navigateToDetail(this.paddockList[position], 'Edit Note');
//              }, leading: CircleAvatar(
//              radius: 30.0,
//              backgroundImage: NetworkImage(
//                  'https://cdn.pixabay.com/photo/2014/12/08/17/52/mare-561221_960_720.jpg'),
//            ),
//              title: Text(
//                this.paddockList[position].name,
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              subtitle: Text(this.paddockList[position].date),
//            ),
//
//            secondaryActions: <Widget>[
////                      IconSlideAction(
////                        icon: Icons.edit,
////                        color: Colors.blue,
////                        caption: 'Edit',
////                        onTap: (){
////                          debugPrint("Edit");
////                        },
////                      ),
//              IconSlideAction(
//                icon: Icons.delete,
//                color: Colors.red,
//                caption: 'Delete',
//                onTap: () {
//                  _delete(context, paddockList[position]);
//                },
//              ),
//            ],
////            trailing: GestureDetector(
////              child:Icon(Icons.delete, color: Colors.black,),
////              onTap: (){
////                _delete(context, noteList[position]);
////              },
////            ),
//
//          );
//        });
//  }
//  void _delete(BuildContext context, Paddocks note) async{
//    int result = await dataBaseHelper.deleteNote(note.id);
//    if (result != 0){
//      _showSnackBar(context, 'Deleted Successfully');
//      updateListView();
//    }
//  }
//  void navigateToDetail(Paddocks note, String title) async{
//    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
//      return  AddPaddock (note, title);
//    }));
//    if(result == true){
//      updateListView();
//    }
//  }
//
//  void _showSnackBar(BuildContext context, String message) {
//    final snackBar = SnackBar(content: Text(message));
//    Scaffold.of(context).showSnackBar(snackBar);
//  }
//}
//
