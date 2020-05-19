import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/my_horses/services/labtest_services.dart';


class competetion_list extends StatefulWidget{
  String token;
  var  specificvetvisit;

  competetion_list (this.token, this.specificvetvisit);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token,specificvetvisit);
  }

}
class _Profile_Page_State extends State<competetion_list>{
  int id;

  _Profile_Page_State (this.token,this.specificvetvisit);

  String token,title,dateOfBirth;
  var specificvetvisit,vetdropDown;
  var temp=['',''];


  @override
  void initState () {
//    healthServices.horseIdhealthRecord(token, id).then((response){
//      setState(() {
//        print(response);
//        specificHealthRecord =json.decode(response);
//
//      });
//
//    });
//    vet_services.labdropdown(token).then((response){
//      setState((){
//        vetdropDown = json.decode(response);
//      });
//    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Vet Visit"),
        ),
        body: ListView.builder(itemCount:specificvetvisit!=null?specificvetvisit.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                //['categoryName']['name']

                title: Text("Visit Date: "+specificvetvisit[index]['date'].toString().substring(0,10),textScaleFactor: 1.1,),
                //trailing: Text(specificlabtest[index]['isPositive'] == true ? "Yes" .toString():"No"),
                trailing: Text(specificvetvisit != null ? "Result: "+specificvetvisit[index]['result']:' empty'),
                children: <Widget>[
                  Divider(),
                  ListTile(
                    title: Text("Rider"),
                    trailing: Text(specificvetvisit[index]['rider']!=null?specificvetvisit[index]['rider'].toString():"empty"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Event"),
                    trailing: Text(specificvetvisit[index]['eventName']!=null?specificvetvisit[index]['eventName'].toString():"empty"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("City"),
                    trailing: Text(specificvetvisit[index]['city']!=null?specificvetvisit[index]['city'].toString():"empty"),
                  ),Divider(),
                  ListTile(
                    title: Text("Judges"),
                    trailing: Text(specificvetvisit[index]['judges']!=null?specificvetvisit[index]['judges'].toString():'empty'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Dignosis"),
                    trailing: Text(specificvetvisit[index]['diagnosis']!=null?specificvetvisit[index]['diagnosis'].toString():"empty"),
                  ),


                ],


              ),
            ],

          );

        })
    );
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
  String get_vet_by_id(int id){
    var responsible_name;
    if(specificvetvisit!=null&&vetdropDown['vetDropDown']!=null&&id!=null){
      for(int i=0;i<vetdropDown['vetDropDown'].length;i++){
        if(vetdropDown['vetDropDown'][i]['id']==id){
          responsible_name=vetdropDown['vetDropDown'][i]['name'];
        }
      }
      return responsible_name;
    }else
      return null;
  }
}
