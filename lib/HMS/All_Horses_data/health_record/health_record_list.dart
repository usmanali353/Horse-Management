import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/health_record/update_health_record.dart';
import 'package:horse_management/HMS/All_Horses_data/services/health_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'health_record_form.dart';


class healthRecord_list extends StatefulWidget{
  String token;


  healthRecord_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends ResumableState<healthRecord_list>{
  int id;SharedPreferences prefs;

  _Profile_Page_State (this.token);
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String token;
  var specifichorsehealthRecord,healthlist, load_list;
  var temp=['',''];
  bool isVisible = false;
 // MainPageState _mainPageState;
int pagenum=1,total_page;

  @override
  void onResume() {
    if(resume.data.toString()== "refresh"){
      print(resume.data.toString());
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
  }

  @override
  void initState () {
    _searchQuery =TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        healthServices.healthRecordTestlist(token).then((response) {
          pd.dismiss();
          isVisible = true;
          setState(() {
            load_list = json.decode(response);
            healthlist = load_list['response'];
            total_page=load_list['totalPages'];
            if(total_page == 1){
              print("init state page = 1");
              setState(() {
                isPagination = false;
              });
            }else{
              print("init state multi page ");
              setState(() {
                isPagination = true;
              });
            }
            print(healthlist);
          });
        });
      }else
        print("network nahi hai");
    });
  }






  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: _isSearching ? const BackButton() : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),

//          title: Text("Health Record"),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),);
//            },
//          )
//        ],
        ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
        Visibility(
          visible: isPagination,
          child: Padding(
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
                            healthServices.healthRecordTestlistbypage(token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list= json.decode(response);
                                healthlist = load_list['response'];
                                print(healthlist);
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
                            healthServices.healthRecordTestlistbypage(
                                token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list = json.decode(response);
                                healthlist = load_list['response'];
                                print(healthlist);
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
        ),
        body: Visibility(
          visible: isVisible,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: (){
              return Utils.check_connectivity().then((result){
                if(result){
                  healthServices.healthRecordTestlist(token).then((response){
                    // print(response.length.toString());
                    if(response!=null){
                      setState(() {
                        //var parsedjson = jsonDecode(response);
                        load_list = json.decode(response);
                        healthlist = load_list['response'];
                        total_page = load_list['totalPages'];
                        if(total_page == 1 || total_page == -2147483648){
                          print("init state page = 1");
                          setState(() {
                            isPagination = false;
                          });
                        }else{
                          print("init state multi page ");
                          setState(() {
                            isPagination = true;
                          });
                        }
                       // healthlist  = jsonDecode(response);
                        print(healthlist);
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
            child: ListView.builder(itemCount:healthlist!=null?healthlist.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(

                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.15,
                     closeOnScroll: true,
                    secondaryActions: <Widget>[
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],0).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });
                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.red,),caption: 'Bad',),
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],1).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });

                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.yellow,),caption: 'Fair',),
                      IconSlideAction(onTap: ()async{
                        healthServices.healthstatus(token, healthlist[index]['id'],2).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Status Changed to good'),
                            ));

                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.red ,
                              content: Text('Failed'),
                            ));
                          }
                        });
                      },iconWidget: CircleAvatar(radius: 40.0,backgroundColor: Colors.green,),caption: 'Good',),
                    ],
                    actions: <Widget>[
                      IconSlideAction(onTap: ()async{
                          print(healthlist[index]['id']);
                        push(context, MaterialPageRoute(builder: (context) => update_health(healthlist[index],token)),);

                      },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          healthServices.healthvisibilty(token, healthlist[index]['id']).then((response){
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
                      //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                      title: Text(healthlist!=null?healthlist[index]['horseName']['name'].toString():'name not show'),
                      subtitle: Text(healthlist!=null? "Responsible: "+healthlist[index]['responsibleName']['contactName']['name'].toString():'responsible empty'),
                      trailing: Text(healthlist[index]['status'] != null ? "Status: "+get_status_by_id(healthlist[index]['status']):"empty"),
                      //trailing: healthlist != null ? CircleAvatar(backgroundColor: get_status_by_id(healthlist[index]['status'])):"empty",
                      //leading: Image.asset("Assets/horses_icon.png"),
                      onTap: ()async{
                        print(healthlist[index]['id']);
                        prefs= await SharedPreferences.getInstance();
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      backgroundColor: Colors.green,
//                      content: Text("Training Updated Sucessfully"),
//                    ));
//                    Utils.createSnackBar("qwerty",context);
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
  String get_status_by_id(int id){
    var status;
    if(healthlist!=null && id!=null){
      if(id == 2)
        status = "Good";
      else if(id == 1)
           status = "Fair";
      else if(id == 0)
        status = "Bad";
      return status;
    }else
      return null;
  }

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }


  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("");
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Health Records'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      textInputAction: TextInputAction.search,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {

    setState(() {
      searchQuery = newQuery;
    });
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        healthServices.healthRecordTestlistbypage(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(healthlist!=null){
                healthlist.clear();
              }
              load_list=json.decode(response);
              healthlist = load_list['response'];
              total_page=load_list['totalPages'];
              print(total_page);
              isVisible=true;
              if(total_page == 1){
                setState(() {
                  isPagination = false;

                });
              }else{
                isPagination = true;
              }

            });

          }else{
            setState(() {
              isVisible=false;
            });
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("List Not Available"),
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
  }

  List<Widget> _buildActions() {

    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      Padding(padding: EdgeInsets.all(8.0),
        child: InkWell(child: Icon(Icons.add),
            onTap: () =>  push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),)

        ),


      )
    ];
  }

}





