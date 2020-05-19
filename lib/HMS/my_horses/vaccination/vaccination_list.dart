import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/my_horses/services/vaccination.dart';

class vaccinationList extends StatefulWidget{
  String token;
  var vaccinationlist;

  vaccinationList (this.token, this.vaccinationlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token,vaccinationlist);
  }

}
class _Profile_Page_State extends State<vaccinationList>{
  var vaccinationlist;

  _Profile_Page_State (this.token,this.vaccinationlist);

  String token,title,dateOfBirth;
  var specifichorsevaccination,vaccinationdropDown;
  var temp=['',''];
  var single_vaccination;

  @override
  void initState () {
//    vaccinationServices.vaccination_list(token).then((response){
//      setState(() {
//        print(response);
//        specifichorsevaccination =json.decode(response);
//         if(specifichorsevaccination!=null){
//           for(int i=0;i<specifichorsevaccination.length;i++){
//             if(specifichorsevaccination[i]['vaccinationId']==vaccinationlist['vaccinationId']){
//               setState(() {
//                 single_vaccination=specifichorsevaccination[i];
//               });
//             }
//           }
//           print(single_vaccination.toString());
//         }
//      });
//
//    });
    vaccinationServices.vaccinationDropdown(token).then((response){
      setState((){
        vaccinationdropDown = json.decode(response);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Vaccination"),
        ),
        body: ListView.builder(itemCount:vaccinationlist!=null?vaccinationlist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                //['categoryName']['name']
                title: Text(vaccinationlist != null ?"Type: "+get_vaccinetype_by_id(vaccinationlist[index]['vaccinationTypeId']):"Vaccination Type Empty",textScaleFactor: 1.3,),
                trailing: Text(specifichorsevaccination != null ? "Status: "+get_status_by_id(specifichorsevaccination[index]['status']):"status empty"),

                children: <Widget>[
                  ListTile(
                    title: Text("Start Date"),
                    trailing: Text(vaccinationlist[index]['startDate'].toString()),
                    onTap: ()async{
                      print(vaccinationlist[index]['vaccinationId']);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("End Date"),
                    trailing: Text(vaccinationlist[index]['endDate'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Vaccine"),
                    trailing: Text(vaccinationlist!=null?get_vaccine_by_id(vaccinationlist[index]['vaccineId']):"empty"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount"),
                    trailing: Text(vaccinationlist != null ? vaccinationlist[index]['amount'].toString():"empty"),
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
  String get_vaccine_by_id(int id){
    var responsible_name;
    if(vaccinationlist!=null&&vaccinationdropDown['vaccineDropDown']!=null&&id!=null){
      for(int i=0;i<vaccinationdropDown['vaccineDropDown'].length;i++){
        if(vaccinationdropDown['vaccineDropDown'][i]['id']==id){
          responsible_name=vaccinationdropDown['vaccineDropDown'][i]['name'];
        }
      }
      return responsible_name;
    }else
      return null;
  }

  String get_vaccinetype_by_id(int id){
    var responsible_name;
    if(vaccinationlist!=null&&vaccinationdropDown['vaccinationTypeDropDown']!=null&&id!=null){
      for(int i=0;i<vaccinationdropDown['vaccinationTypeDropDown'].length;i++){
        if(vaccinationdropDown['vaccinationTypeDropDown'][i]['id']==id){
          responsible_name=vaccinationdropDown['vaccinationTypeDropDown'][i]['name'];
        }
      }
      return responsible_name;
    }else
      return null;
  }
}