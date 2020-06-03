import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/add_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/competetion/update_competetion.dart';
import 'package:horse_management/HMS/All_Horses_data/services/swabbing_services.dart';
import 'package:horse_management/HMS/All_Horses_data/swabbing/update_swabbing.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class swabbing_list extends StatefulWidget{
  String token;


  swabbing_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<swabbing_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  String token;
  var swabbinglist, load_list;
  var temp=[];
 int pagenum=1,total_page;

  @override
  void initState () {


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        swabbing_services.swabbing_list(token).then((response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            swabbinglist = load_list['response'];
            total_page=load_list['totalPages'];
          });
        });
      }else
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("network error"),
        ));
    });




  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Swabbing"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_competetion(token)),);
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
                          swabbing_services.swabbing_listbypage(token, pagenum).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              swabbinglist = load_list['response'];
                              print(swabbinglist);
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
                          swabbing_services.swabbing_listbypage(
                              token, pagenum).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list = json.decode(response);
                              swabbinglist = load_list['response'];
                              print(swabbinglist);
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
        body: ListView.builder(itemCount:swabbinglist!=null?swabbinglist.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                actions: <Widget>[
                  IconSlideAction(
                    icon: Icons.visibility_off,
                    color: Colors.red,
                    caption: 'Hide',
                    onTap: () async {
                      swabbing_services.swabbingVisibilty(token, swabbinglist[index]['id']).then((response){
                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                        print(response);
                        if(response!=null){

                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor:Colors.green ,
                            content: Text('Visibility Changed'),
                          ));

                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor:Colors.red ,
                            content: Text('Failed'),
                          ));
                        }
                      });
                    },
                  ),
                  IconSlideAction(onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_swabbing(swabbinglist[index],prefs.get('token'))));

                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                ],
                child: ListTile(
                  //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                  title: Text(swabbinglist!=null?(swabbinglist[index]['horseName']['name']):'Horse Name'),
                  subtitle: Text(swabbinglist!=null?'Date '+(swabbinglist[index]['swabbingDate'].toString().substring(0,10)):'empty'),
                  trailing: Text(swabbinglist!=null?'Antibiotic '+(swabbinglist[index]['antibiotic']):' epmty'),
                  onTap: ()async{
                    prefs = await SharedPreferences.getInstance();
                    print((swabbinglist[index]));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>update_labTest(lablist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));
                  },
                ),
                secondaryActions: <Widget>[

                ],

              ),
              Divider(),
            ],

          );

        })
    );
  }

}
