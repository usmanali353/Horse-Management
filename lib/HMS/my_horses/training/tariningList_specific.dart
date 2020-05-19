import 'dart:convert';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Training/Add_training.dart';
import 'package:shared_preferences/shared_preferences.dart';




class specificTraining_list extends StatefulWidget{
  var list;
  String token;

  specificTraining_list (this.token,this.list);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _incomeExpense_list_state(token,list);
  }

}
class _incomeExpense_list_state extends State<specificTraining_list>{
  var list,trainingdropdown;
  SharedPreferences prefs;
  String token;

  _incomeExpense_list_state (this.token,this.list);

  var temp=['',''];


  @override
  void initState () {
    network_operations.get_training_dropdowns(token).then((response){
      setState((){
        trainingdropdown = json.decode(response);
      });
    });

//    Add_horse_services.horseDashBoard(token,horsedata['horseId']).then((response){
//      setState(() {
//        getinfo = jsonDecode(response);
//        print(getinfo['horseDetails']);
//        _isvisible =true;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("training "),
            //actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.5,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async{
//              prefs= await SharedPreferences.getInstance();
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_training('token')),);
//            },
//          )
//        ],
            ),
        body:ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                title: Text(list[index]['trainingType'] != null ? "Training Type: "+get_training_type_by_id(list[index]['trainingType']):'TrainerType Empty',textScaleFactor: 1.3,),
                subtitle: Text(list != null ?"Start Date: "+list[index]['startDate'].toString().substring(0,10):"date empty"),
                trailing: Text(list != null ? "Status: "+get_status_by_id(list[index]['status']):'status empty'),

                children: <Widget>[
//                  ListTile(
//                    title: Text((list[index]['id'].toString())),
//                    //leading: Image.asset("Assets/horses_icon.png"),
//                    onTap: (){
//                      print((list[index]['id']));
//                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
//                    },
//                  ),
                  Divider(),
//                  ListTile(
//                    title: Text("End Date"),
//                    trailing: Text(list[index]['endDate'].toString()),
//                  ),
////                  Divider(),
////                  ListTile(
////                    title: Text("Trainer Id"),
////                    trailing: Text(list[index]['trainerId'].toString()),
////                  ),
                  Divider(),
                  ListTile(
                    title: Text("Session"),
                    trailing: Text(list != null ? list[index]['sessions'].toString():"sesssion empty "),
                    onTap: (){
                      print(list[index]['trainerId']);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Trainer"),
                   trailing: Text(get_trainer_by_id(list[index]['trainerId']) != null ? get_trainer_by_id(list[index]['trainerId']):"trainer empty"),
                  ),

                ],


              ),
              Divider(),
            ],

          );

        })

    );
  }
  String get_training_type_by_id(int id){
    var training_type_name;
   
      if(id==1){
        training_type_name="Simple";
      }else if(id==2){
        training_type_name='Endurance';
      }else if(id==3){
        training_type_name="Customized";
      }else if(id==4){
        training_type_name="Speed";
      }
      else{
        training_type_name= "empty";
      }
    return training_type_name;
  }
  String get_status_by_id(int id){
    var training_type_name;

    if(id ==0){
      training_type_name= "Bad";
    }else if(id==1){
      training_type_name='Fair';
    }else if(id==2){
      training_type_name="Good";
    }
    else{
      training_type_name= "empty";
    }
    return training_type_name;
  }
  String get_trainer_by_id(int id){
    var responsible_name;
    if(list!=null&&trainingdropdown['trainerDropDown']!=null&&id!=null){
      for(int i=0;i<trainingdropdown['trainerDropDown'].length;i++){
        if(trainingdropdown['trainerDropDown'][i]['id']==id){
          responsible_name=trainingdropdown['trainerDropDown'][i]['name'];
        }
      }

      return responsible_name;
    }else
      return responsible_name = "empty";
  }

}