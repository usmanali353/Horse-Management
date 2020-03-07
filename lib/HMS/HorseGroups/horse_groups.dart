import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:horse_management/HMS/HorseGroups/utils/database_helper.dart';
import 'package:horse_management/HMS/HorseGroups/models/group.dart';
import 'add_group_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class horse_groups extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return horse_groups_State();
  }

}
class horse_groups_State extends State<horse_groups>{
  int count = 0;
  DatabaseHelper dataBaseHelper = DatabaseHelper();
  List<Groups> noteList;

  @override
  Widget build(BuildContext context) {
    if(noteList == null){
      noteList = List<Groups>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Groups"),
      ),
      body: getHorseListView(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        debugPrint("FAB Clicked");
        navigateToDetail(Groups('',2, '','' ),'Add Group');
      },
        tooltip: 'Add Group',
        child: Icon(Icons.add),
      ),
    );
  }
  ListView getHorseListView(){
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          child: ListTile(
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position], 'Edit Note');
            }, leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2014/12/08/17/52/mare-561221_960_720.jpg'),
          ),
            title: Text(
              this.noteList[position].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(this.noteList[position].date),
          ),

          secondaryActions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.edit,
//                        color: Colors.blue,
//                        caption: 'Edit',
//                        onTap: (){
//                          debugPrint("Edit");
//                        },
//                      ),
            IconSlideAction(
              icon: Icons.delete,
              color: Colors.red,
              caption: 'Delete',
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
          ],
//            trailing: GestureDetector(
//              child:Icon(Icons.delete, color: Colors.black,),
//              onTap: (){
//                _delete(context, noteList[position]);
//              },
//            ),

        );
      });
  }

  //Returns the priority Color
  Color getPriorityColor(int dynamics){
    switch(dynamics){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }


  //Returns the priority Icon
  Icon getPriorityIcon(int dynamics){
    switch(dynamics){
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Groups note) async{
    int result = await dataBaseHelper.deleteNote(note.id);
    if (result != 0){
      _showSnackBar(context, 'Group Deleted Successfully');
      updateListView();
    }
  }

  void navigateToDetail(Groups note, String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return GroupDetail(note, title);
    }));
    if(result == true){
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView(){
    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Groups>> noteListFuture = dataBaseHelper.getHorseList();
      noteListFuture.then((noteList){
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    }
    );
  }
}

//class horse_groups extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _horse_groups_State();
//  }
//
//}
//
//class _horse_groups_State extends State<horse_groups>{
//  int count = 0;
//  DatabaseHelper dataBaseHelper = DatabaseHelper();
//  List<Groups> horseList;
//
//  @override
//  Widget build(BuildContext context) {
//    if(horseList == null){
//      horseList = List<Groups>();
//      updateListView();
//    }
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(title: Text("Horse Groups"),),
//      body: getHorseGroupListView(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          debugPrint("FAB Clicked");
//          navigateToDetail(Groups('',2,'',''),'Add Horse Groups');
//
//        },
//        tooltip: 'Add Group Form',
//        child: Icon(Icons.add),
//      ), // This trailing comma mak
//    );
//  }
//  ListView getHorseGroupListView(){
//    return ListView.builder(shrinkWrap: true,
//        itemCount: count,
//        itemBuilder: (BuildContext context, int position){
//         // final Horses = _Horses[index];
//          return Slidable(
//            actionPane: SlidableDrawerActionPane(),
//            actionExtentRatio: 0.20,
//            child: ListTile(
//              onTap: (){
//                debugPrint("ListTile Tapped");
//                navigateToDetail(this.horseList[position],'Edit Groups');
//              },
//              leading: CircleAvatar(
//                radius: 30.0,
//                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2014/12/08/17/52/mare-561221_960_720.jpg'),
//              ),
//              title: Text(
//                this.horseList[position].name,
//                style: TextStyle(fontWeight: FontWeight.bold),
//              ),
//              subtitle: Text(this.horseList[position].date),
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
//                onTap: (){
//                  _delete(context, horseList[position]);
//                },
//              ),
//            ],
//          );
//        });
//  }

//  void updateListView(){
//    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
//    dbFuture.then((database){
//      Future<List<Groups>> noteListFuture = dataBaseHelper.getHorseList();
//      noteListFuture.then((horseList){
//        setState(() {
//          this.horseList = horseList;
//          this.count = horseList.length;
//        });
//      });
//    }
//    );
//  }
//  void navigateToDetail(Groups groups, String name) async{
//    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
//      return AddGroups(groups, name);
//    }));
//    if(result == true){
//      updateListView();
//    }
//  }
//  void _delete(BuildContext context, Groups note) async{
//    int result = await dataBaseHelper.deleteNote(note.id);
//    if (result != 0){
//      _showSnackBar(context, 'Note Deleted Successfully');
//      updateListView();
//    }
//  }
//  void _showSnackBar(BuildContext context, String message) {
//    final snackBar = SnackBar(content: Text(message));
//    Scaffold.of(context).showSnackBar(snackBar);
//  }
//}

