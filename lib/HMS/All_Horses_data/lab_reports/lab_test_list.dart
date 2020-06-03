import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/labTest_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'lab_test_form.dart';
import 'package:shared_preferences/shared_preferences.dart';


class lab_list extends StatefulWidget{
  String token;


  lab_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<lab_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String token;
  bool isVisible=false;
  var lablist, load_list;
  var temp=['',''];
  int pagenum=1,total_page;

  @override
  void initState () {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

//    labtest_services.labTestlist(token).then((response){
//      setState(() {
//        print(response);
//        lablist =json.decode(response);
//
//      });
//
//    });
    Utils.check_connectivity().then((result){
        if(result){
          ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
          pd.show();
          labtest_services.labTestlist(token).then((response) {
            pd.dismiss();
            isVisible = true;
            setState(() {
              print(response);
             load_list = json.decode(response);
             lablist = load_list['response'];
              total_page=load_list['totalPages'];
            });
          });
            }else{
          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Network Not Available"),
          ));
        }

          });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Lab Test"),actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => add_labTest(token)),);
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
                          labtest_services.labTestlistbypage(token, pagenum).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              lablist = load_list['response'];
                              print(lablist);
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
                          labtest_services.labTestlistbypage(
                              token, pagenum).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list = json.decode(response);
                              lablist = load_list['response'];
                              print(lablist);
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

        body: Visibility(
          visible: isVisible,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: (){
              return Utils.check_connectivity().then((result){
                if(result){
                  labtest_services.labTestlist(token).then((response){
                    // print(response.length.toString());
                    if(response!=null){
                      setState(() {
                        //var parsedjson = jsonDecode(response);
                        lablist  = jsonDecode(response);
                        print(lablist);
                        //print(horse_list['createdBy']);
                      });
                    }
                  });
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red ,
                    content: Text('Network Error'),
                  ));
                }
              });
            },
            child: ListView.builder(itemCount:lablist!=null?lablist.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
//                secondaryActions: <Widget>[
//
//                ],
                    actions: <Widget>[
                      IconSlideAction(onTap: ()async{
                        prefs = await SharedPreferences.getInstance();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>update_labTest(lablist[index],prefs.get('token'),prefs.get('createdBy'))));

                      },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          labtest_services.labTestvisibilty(token, lablist[index]['id']).then((response){
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
                    ],
                    child: ListTile(
                      enabled: lablist[index]['isActive']!=null? lablist[index]['isActive']:true,
                      leading: lablist[index]['labTestReportImage']!=null?Image.memory(base64.decode(lablist[index]['labTestReportImage'])):Text(''),
                      //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                      title: Text(lablist!=null?(lablist[index]['horseName']['name']):''),
                      subtitle: Text(lablist[index]['testTypes']!=null?(lablist[index]['testTypes']['name']):'testtype empty'),
                      trailing: Text(lablist[index]['responsibleName'] != null ? lablist[index]['responsibleName']['contactName']['name']:" name empty"),
                      //leading: Image.asset("Assets/horses_icon.png"),
                      onTap: ()async{
                        prefs = await SharedPreferences.getInstance();
                        print((lablist[index]));
                      },
                    ),


                  ),
                  Divider(),
                ],

              );

            }),
          ),
        )
    );
  }

}