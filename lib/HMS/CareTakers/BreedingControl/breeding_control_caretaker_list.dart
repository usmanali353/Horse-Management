import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/breeding_control_details.dart';
import 'package:horse_management/HMS/CareTakers/BreedingControl/BreedingControlCaretaker.dart';
import 'package:horse_management/HMS/CareTakers/BreedingControl/BreedingControlLateReason.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';


class breeding_control_caretaker_list extends StatefulWidget{
  String token;

  breeding_control_caretaker_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_control_caretaker_list(token);
  }

}
class _breeding_control_caretaker_list extends State<breeding_control_caretaker_list>{
  String token;
  _breeding_control_caretaker_list(this.token);
  bool isVisible=false;
  var temp=['','',''];
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  int searchPageNum,totalSearchPages;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var control_list, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _searchQuery =TextEditingController();

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        BreedingControlCareTakerServices.breedingControl_caretaker_by_page(token, pagenum, searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              control_list = load_list['response'];
              total_page=load_list['totalPages'];
              isVisible=true;
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
              print(total_page);
            });

          }else{
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("No List"),backgroundColor: Colors.red,));
          }
        });
      }else
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Network Error")
        ));
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
                          BreedingControlCareTakerServices.breedingControl_caretaker_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            print("has pre in if");
                            setState(() {
                              //print(response);
                              load_list= json.decode(response);
                              control_list = load_list['response'];
                              //print(horse_list);
                            });
                          });
                        }else
                          print("Network Not Available");
                      });
                    }
                    else{
                      print("previous else ");
                      print("Empty List");
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
                          BreedingControlCareTakerServices.breedingControl_caretaker_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              //print(response);
                              load_list = json.decode(response);
                              control_list= load_list['response'];
                              //print(horse_list);
                              print("abc");

                            });
                          });
                        }else
                          print("Network Not Available");
                      });
                    }
                    else{
                      print("next else ");
                      print(searchQuery);
                      print("Empty List");
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
              BreedingControlCareTakerServices.breedingControl_caretaker_by_page(
                  token, pagenum,searchQuery).then((response) {
                setState(() {
                  print(response);
                  load_list = json.decode(response);
                  control_list = load_list['response'];
                  total_page=load_list['totalPages'];
                  isVisible=true;
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
                  print(control_list);
                  print("Refresher sec");
                  print(pagenum);
                  print(searchQuery);
                });
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor:Colors.red ,
                content: Text('Network Error'),
              ));
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:control_list!=null?control_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      secondaryActions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.edit,
//                        color: Colors.blue,
//                        caption: 'Update',
//                        onTap: () async {
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding_control(token,control_list[index])));
//                        },
//                      ),
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
//                      IconSlideAction(
//                        icon: Icons.visibility_off,
//                        color: Colors.red,
//                        caption: 'Hide',
//                        onTap: () async {
//                          Utils.check_connectivity().then((result){
//                            if(result){
//                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                              pd.show();
//                              network_operations.change_breeding_control_visibility(token, control_list[index]['breedingControlId']).then((response){
//                                pd.dismiss();
//                                if(response!=null){
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.green ,
//                                    content: Text('Visibility Changed'),
//                                  ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
//                                }else{
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.red ,
//                                    content: Text('Failed'),
//                                  ));
//                                }
//                              });
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text("Network not Available"),
//                                backgroundColor: Colors.red,
//                              ));
//                            }
//                          });
//                        },
//                      ),
                     // if(control_list[index]['status']==0){
                        IconSlideAction(
                          icon: Icons.timer,
                          color: Colors.deepOrange,
                          caption: 'Start',
                          onTap: () async {
                            Utils.check_connectivity().then((result) {
                              if (result) {
                                ProgressDialog pd = ProgressDialog(
                                    context, type: ProgressDialogType.Normal,
                                    isDismissible: true);
                                pd.show();
                                BreedingControlCareTakerServices
                                    .start_breeding_Control(token,
                                    control_list[index]['breedingControlId'])
                                    .then((response) {
                                  pd.dismiss();
                                  if (response != null) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('Process Started'),
                                    ));
                                    setState(() {
                                      //  control_list.removeAt(index);
                                    });
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Process Failed'),
                                    ));
                                  }
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Network not Available"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            });
                          },
                        ),

                        IconSlideAction(
                          icon: Icons.done_all,
                          color: Colors.green,
                          caption: 'Complete',

                         onTap: () async {
                            print(control_list[index]);
                            print(DateTime.parse(control_list[index]['date']));
                            if(DateTime.now().isAfter(DateTime.parse(control_list[index]['date'])) )
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_control_late_reason(token, control_list[index]['breedingControlId'])));
                         else{
                              Utils.check_connectivity().then((result){
                                if(result){
                                  ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                  pd.show();
                                  BreedingControlCareTakerServices.complete_breeding_Control(token, control_list[index]['breedingControlId']).then((response){
                                    pd.dismiss();
                                    if(response!=null){
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor:Colors.green ,
                                        content: Text('Completed'),
                                      ));
                                      setState(() {
                                        //  control_list.removeAt(index);
                                      });
                                    }else{
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor:Colors.red ,
                                        content: Text('Process Failed'),
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
                            }
                          },
//                        onTap: () async {
//                          Utils.check_connectivity().then((result){
//                            if(result){
//                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//                              pd.show();
//                              BreedingControlCareTakerServices.complete_breeding_Control(token, control_list[index]['breedingControlId']).then((response){
//                                pd.dismiss();
//                                if(response!=null){
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.green ,
//                                    content: Text('Process Complete'),
//                                  ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
//                                }else{
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.red ,
//                                    content: Text('Process Failed'),
//                                  ));
//                                }
//                              });
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text("Network not Available"),
//                                backgroundColor: Colors.red,
//                              ));
//                            }
//                          });
//
//                        },
                        ),
                      ],
                      child: FadeAnimation(2.0,
                        ListTile(
                          enabled: control_list[index]['isActive'],
                          leading: FaIcon(FontAwesomeIcons.whmcs, color: Colors.grey.shade500, size: 40,),
                          trailing:Text(control_list!=null?"Status: "+(get_status_by_id(control_list[index]['status'])).toString():'empty'),
                          title: Text(control_list!=null?control_list[index]['horseName']['name']:''),
                          subtitle: Text(control_list!=null?control_list[index]['date'].toString().substring(0,10):''),
                          //leading: Icon(Icons.pets,size: 40,color: Colors.teal,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_control_details_page(control_list[index], get_check_method_by_id(control_list[index]['check_Method']))));
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
  String get_status_by_id(int id){
    var status;

    if(id ==0){
      status= "Not started";
    }else if(id==1){
      status='Started';
    }else if(id==2){
      status="Complete";
    }
    else if(id==3){
      status="Late Complete";
    }
    else{
      status= "empty";
    }
    return status;
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
            const Text('Breeding Control Caretaker'),
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
        BreedingControlCareTakerServices.breedingControl_caretaker_by_page(token,pagenum,searchQuery).then((response){
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
//      Padding(padding: EdgeInsets.all(8.0),
//        child: InkWell(child: Icon(Icons.add),
//            onTap: () =>
//                Navigator.push(context, MaterialPageRoute(
//                    builder: (context) =>semen_stock_form(token)),)
//
//        ),
//
//
//      )
    ];
  }


}