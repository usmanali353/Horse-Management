import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/add_training_session.dart';
import 'package:horse_management/HMS/Training/update_sessions.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';


class training_session_list extends StatefulWidget{
  String token;
  var specslist;

  training_session_list(this.token,this.specslist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_session_list(token,specslist);
  }

}
class _training_session_list extends State< training_session_list>{
  String token;
  var specslist;
  _training_session_list(this.token,this.specslist);
  bool isVisible=false;
  var temp=['',''];
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var control_list, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  @override
  void initState() {
    _searchQuery = TextEditingController();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),


//        title: Text("Training Session"),
//        actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
 //             Navigator.push(context, MaterialPageRoute(builder: (context) => add_training_session(token,specslist)),);
//            },
//          )
////          IconButton(
////            icon: Icon(Icons.picture_as_pdf),
////           // onPressed: () => _generatePdfAndView(context),
////          ),
//        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Visibility(
        visible: isPagination,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.red,
                      child: Icon(Icons.arrow_back, color: Colors.teal, size: 30,),heroTag: "btn2", onPressed: () {
                    if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                      Utils.check_connectivity().then((result){
                        if(result) {
                          ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                          pd.show();
                          network_operations.sessions_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              control_list = load_list['response'];
                              print(control_list);
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
                  FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.red,
                      child: Icon(Icons.arrow_forward, color: Colors.teal, size: 30,),heroTag: "btn1", onPressed: () {
                    print(load_list['hasNext']);
                    if(load_list['hasNext'] == true && pagenum >= 1 ) {
                      Utils.check_connectivity().then((result){
                        if(result) {
                          ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                          pd.show();
                          network_operations.sessions_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list = json.decode(response);
                              control_list = load_list['response'];
                              print(control_list);
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.training_session_list(token,specslist['trainingId']).then((response){
                pd.dismiss();
                print(response);
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    control_list = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(load_list);
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
                    print(total_page);
                    isVisible=true;
                  });

                }else{
                  setState(() {
                    isVisible=false;
                  });
                }
              });
            }else{
              print("Networks");
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:control_list!=null?control_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training_session(token,control_list[index])));
                        },
                      ),
//                      IconSlideAction(
//                        icon: Icons.access_time,
//                        color: Colors.deepPurple,
//                        caption: 'Next Check',
//                        onTap: () async {
//                          print(control_list[index]);
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>next_breeding_check(token, control_list[index]['breedingControlId'])));
//                        },
//                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.redAccent,
                        caption: 'Hide',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.session_visibility(token, control_list[index]['id']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    control_list.removeAt(index);
                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Failed'),
                                  ));
                                }
                              });
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Network not Available"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          });
                        },
                      ),
                      IconSlideAction(
                        icon: Icons.delete_forever,
                        color: Colors.red,
                        caption: 'Delete',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.session_deletion(token, control_list[index]['id']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('session deleted'),
                                  ));
                                  setState(() {
                                    control_list.removeAt(index);
                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Failed'),
                                  ));
                                }
                              });
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Network not Available"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          });
                        },
                      ),

                    ],
                    child: FadeAnimation(2.0,
                      ListTile(
                        enabled: control_list[index]['isActive']!=null?control_list[index]['isActive']:true,

                      //title: Text("Anc"),
                        trailing:Text(control_list!=null?control_list[index]['date'].toString().substring(0,10):''),
                        title: Text(control_list[index]['trainerId']!=null?control_list[index]['trainerName']['contactName']['name']:''),
                        subtitle: Text(control_list[index]['comments']!=null?'Comments: '+control_list[index]['comments']:'empty'),
                        //leading: Icon(Icons.pets,size: 40,color: Colors.teal,),
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_control_details_page(control_list[index], get_check_method_by_id(control_list[index]['check_Method']))));
                        },
                      ),
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

  String get_check_method_by_id(int id){
    var check_method;
    if(control_list!=null&&id!=null){
      if(id==1){
        check_method="Palpation";
      }else if(id==2){
        check_method="Ultrasound";
      }else if(id==3){
        check_method="Visual Observation";
      }else{
        check_method="Blood Test";
      }
    }
    return check_method;
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
            const Text(''),
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
        network_operations.sessions_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(control_list!=null){
                control_list.clear();
              }
              load_list=json.decode(response);
              control_list = load_list['response'];
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_training_session(token,specslist)),)

        ),


      )
    ];
  }

}