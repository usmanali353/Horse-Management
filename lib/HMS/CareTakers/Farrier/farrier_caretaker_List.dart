import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
import 'package:horse_management/HMS/All_Horses_data/farrier/updateFarrier.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
import 'package:horse_management/HMS/CareTakers/Farrier/FarrierCaretaker.dart';
import 'package:horse_management/HMS/CareTakers/Farrier/FarrierLateReason.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class careTakerFarrierList extends StatefulWidget{
  String token;


  careTakerFarrierList (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends State<careTakerFarrierList>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  int searchPageNum,totalSearchPages;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  String token;
  var farrierlist, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var temp=[];
  bool isVisible=false;


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
        FarrierCareTakerServices.farrier_caretaker_by_page(token, pagenum, searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              farrierlist = load_list['response'];
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
                            FarrierCareTakerServices.farrier_caretaker_by_page(token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              print("has pre in if");
                              setState(() {
                                //print(response);
                                load_list= json.decode(response);
                                farrierlist = load_list['response'];
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
                            FarrierCareTakerServices.farrier_caretaker_by_page(
                                token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                //print(response);
                                load_list = json.decode(response);
                                farrierlist= load_list['response'];
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
                FarrierCareTakerServices.farrier_caretaker_by_page(
                    token, pagenum,searchQuery).then((response) {
                  setState(() {
                    print(response);
                    load_list = json.decode(response);
                    farrierlist = load_list['response'];
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
                    print(farrierlist);
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
              child: ListView.builder(itemCount:farrierlist!=null?farrierlist.length:temp.length,itemBuilder: (context,int index){
                return Column(
                  children: <Widget>[
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.20,
                      actions: <Widget>[
//                  IconSlideAction(onTap: ()async{
//                    prefs = await SharedPreferences.getInstance();
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_farrier(farrierlist[index],token)));
//
//                  },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
//                  IconSlideAction(
//                    icon: Icons.visibility_off,
//                    color: Colors.red,
//                    caption: 'Hide',
//                    onTap: () async {
//                      farrier_services.weight_hieghtvisibilty(token, farrierlist[index]['id']).then((response){
//                        //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
//                        print(response);
//                        if(response!=null){
//
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.green ,
//                            content: Text('Visibility Changed'),
//                          ));
//
//                        }else{
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            backgroundColor:Colors.red ,
//                            content: Text('Failed'),
//                          ));
//                        }
//                      });
//                    },
//                  ),
                        IconSlideAction(
                          icon: Icons.timer,
                          color: Colors.deepOrange,
                          caption: 'Start',
                          onTap: () async {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                pd.show();
                                FarrierCareTakerServices.start_farrier(token, farrierlist[index]['id']).then((response){
                                  pd.dismiss();
                                  if(response!=null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor:Colors.green ,
                                      content: Text('Process Started'),
                                    ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
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

                          },
                        ),
                        IconSlideAction(
                          icon: Icons.done_all,
                          color: Colors.green,
                          caption: 'Complete',
                          onTap: () async {
                            if(DateTime.now().isAfter(DateTime.parse(farrierlist[index]['date'])) )
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>farrier_late_reason(token, farrierlist[index]['id'])));

                            else {
                              Utils.check_connectivity().then((result) {
                                if (result) {
                                  ProgressDialog pd = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true);
                                  pd.show();
                                  FarrierCareTakerServices.complete_farrier(token, farrierlist[index]['id']).then((response) {
                                    pd.dismiss();
                                    if (response != null) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text('Process Complete'),
                                      ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
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
                            }
                          },
                        ),
                      ],
                      child: ExpansionTile(

                        title: Text(farrierlist!=null?(farrierlist[index]['horseName']['name']):''),
                        trailing: Text(farrierlist!=null?"Status: "+(get_status_by_id(farrierlist[index]['status'])).toString():'empty'),
                        children: <Widget>[
                        ListTile(
                            title: Text("Farrier "),
                           // trailing: Text("jn"),
                            trailing: Text(farrierlist!=null?"Farrier: "+(farrierlist[index]['farrierName']['contactName']['name']):'farrier name not showing'),
                            onTap: ()async{
                                  },
                            ),
                          Divider(),
                          ListTile(
                            title: Text("Amount"),
                            trailing: Text(farrierlist!=null?"Amount: "+(farrierlist[index]['amount']).toString():''),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Shoeing Type"),
                            trailing: Text(farrierlist!=null?"Amount: "+(get_ShoeingType_by_id(farrierlist[index]['shoeingType'])).toString():''),
                          ),


                        ],

                      ),
                      secondaryActions: <Widget>[

                      ],

                    ),
                    Divider(),
                  ],

                );

              }),
            ),
          ),
        )
    );
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
  String get_ShoeingType_by_id(int id){
    var status;

    if(id ==1){
      status= "Complete";
    }
    else if(id==2){
      status="Front Shoeing";
    }
    else if(id==3){
      status="Back Shoeing";
    }else if(id==4){
      status="Trimming";
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
            const Text('Farrier Caretaker'),
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
        FarrierCareTakerServices.farrier_caretaker_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(farrierlist!=null){
                farrierlist.clear();
              }
              load_list=json.decode(response);
              farrierlist = load_list['response'];
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














































//import 'dart:convert';
//
//import 'package:circular_profile_avatar/circular_profile_avatar.dart';
//import 'package:flutter/material.dart';
//import 'package:horse_management/HMS/All_Horses_data/farrier/add_farrier.dart';
//import 'package:horse_management/HMS/All_Horses_data/services/farrier_services.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:horse_management/HMS/Training/training_detail_page.dart';
//import 'package:horse_management/Network_Operations.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//class farrier_list extends StatefulWidget{
//  var list;
//  int horseId;
//  String token;
//
//
//  farrier_list ( this.token);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _incomeExpense_list_state(token);
//  }
//
//}
//class _incomeExpense_list_state extends State<farrier_list>{
//  var list,incomelist;
//  int horseId;String token;
//  var temp=['',''];
//  SharedPreferences prefs;
//
//  _incomeExpense_list_state (this.token);
//
//
//  @override
//  void initState () {
////    income_expense_services.horseIdincomeExpense(token,1).then((
////        response) {
////      setState(() {
////        print(response);
////        incomelist = json.decode(response);
////      });
////    });
////    Add_horse_services.labdropdown(token).then((response){
////      setState((){
////        labdropDown = json.decode(response);
////      });
////    });
//
//    farrier_services.farrierlist(token).then((
//        response) {
//      setState(() {
//        print(response);
//        list = json.decode(response);
//      });
//    });
//
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(title: Text("Income & Expense "),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async{
//              prefs= await SharedPreferences.getInstance();
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_farrier(prefs.get('token'))),);
//            },
//          )
//        ],),
//        body:ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
//          return Column(
//            children: <Widget>[
//              ExpansionTile(
//                //['categoryName']['name']
//                title: Text(list[index]['horseName']['name']),
//                trailing: Text(list[index]['date'].toString()),
//
//                children: <Widget>[
////
////                   ListTile(
////                    title: Text((list[index]['id'].toString())),
////                    //leading: Image.asset("Assets/horses_icon.png"),
////                    onTap: (){
////                      print((list[index]['id']));
////                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
////                    },
////                  ),
////                  Divider(),
//                  ListTile(
//                    title: Text("Date"),
//                    trailing: Text(list[index]['date'].toString()),
//                    onTap: ()async{
//                      //list[index]['categoryDropDown']['categoryId']['name'].toString()
////                  print(incomelist['horseDropdown'][list[0]['horseId']]==['id']);
////                  print(incomelist['horseDropdown']);
////                  print(list);
//                      print(list[index]['id']);
//                      prefs= await SharedPreferences.getInstance();
//                      //Navigator.push(context, MaterialPageRoute(builder: (context) => update_IncomeExpense(list[index]['id'],prefs.get('token'),prefs.get('createdBy'))),);
//
//                    },
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Cost Center"),
//                    trailing: Text(list[index]['costCenterId'].toString()),
//                  ),
//                  Divider(),
//                  ListTile(
//                    title: Text("Amount"),
//                    trailing: Text(list[index]['amount'].toString()),
//                  )
//
//                ],
//
//
//              ),
//              Divider(),
//            ],
//
//          );
//
//        })
//
//    );
//  }
//
//}
//
//
