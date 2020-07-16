import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Breeding/BreedingSales/breeding_sales_details.dart';
import 'package:horse_management/HMS/Breeding/BreedingSales/breeding_sales_form.dart';
import 'package:horse_management/HMS/CareTakers/BreedingSales/BreedingSalesCaretaker.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'BreedingSalesLateReason.dart';


class breeding_sales_caretaker_list extends StatefulWidget{
  String token;
  breeding_sales_caretaker_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_sales_caretaker_list(token);
  }

}

class _breeding_sales_caretaker_list extends State<breeding_sales_caretaker_list>{
  String token;
  _breeding_sales_caretaker_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  int searchPageNum,totalSearchPages;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var sales_list, load_list, pagelist, pageloadlist;
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
        BreedingSalesCareTakerServices.breedingSales_caretaker_by_page(token, pagenum, searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              sales_list = load_list['response'];
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
                          BreedingSalesCareTakerServices.breedingSales_caretaker_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            print("has pre in if");
                            setState(() {
                              //print(response);
                              load_list= json.decode(response);
                              sales_list = load_list['response'];
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
                          BreedingSalesCareTakerServices.breedingSales_caretaker_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              //print(response);
                              load_list = json.decode(response);
                              sales_list= load_list['response'];
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
              BreedingSalesCareTakerServices.breedingSales_caretaker_by_page(
                  token, pagenum,searchQuery).then((response) {
                setState(() {
                  print(response);
                  load_list = json.decode(response);
                  sales_list = load_list['response'];
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
                  print(sales_list);
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
            child: ListView.builder(itemCount:sales_list!=null?sales_list.length:temp.length,itemBuilder: (context,int index){
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
//                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding_sales_caretaker_list_form(token,sales_list[index])));
//                        },
//                      ),
                      ],
                      actions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.visibility_off,
//                        color: Colors.red,
//                        caption: 'Hide',
//                        onTap: () async {
//                          BreedingSalesServices.change_breeding_sales_caretaker_list_visibility(token, sales_list[index]['id']).then((response){
//                            print(response);
//                            if(response!=null){
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.green ,
//                                content: Text('Visibility Changed'),
//                              ));
//                              setState(() {
//                                sales_list.removeAt(index);
//                              });
//
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.red ,
//                                content: Text('Failed'),
//                              ));
//                            }
//                          });
//                        },
//                      ),
                        IconSlideAction(
                          icon: Icons.timer,
                          color: Colors.deepOrange,
                          caption: 'Start',
                          onTap: () async {
                            Utils.check_connectivity().then((result){
                              if(result){
                                ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                pd.show();
                                BreedingSalesCareTakerServices.start_breeding_sales(token, sales_list[index]['id']).then((response){
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
                            print(sales_list[index]);
                            print(DateTime.parse(sales_list[index]['date']));
                            if(DateTime.now().isAfter(DateTime.parse(sales_list[index]['date'])) )
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_sales_late_reason(token, sales_list[index]['id'])));
                            else{
                              Utils.check_connectivity().then((result){
                                if(result){
                                  ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                                  pd.show();
                                  BreedingSalesCareTakerServices.complete_breeding_sales(token, sales_list[index]['id']).then((response){
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
//                              BreedingSalesCareTakerServices.complete_breeding_sales_caretaker_list(token, sales_list[index]['id']).then((response){
//                                pd.dismiss();
//                                if(response!=null){
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor:Colors.green ,
//                                    content: Text('Process Complete'),
//                                  ));
////                                  setState(() {
////                                    control_list.removeAt(index);
////                                  });
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
                           enabled: sales_list[index]['isActive'],
                           leading: FaIcon(FontAwesomeIcons.handHoldingUsd, color: Colors.green, size: 40,),
                           title: Text(sales_list!=null?sales_list[index]['horseName']['name']:''),
                           trailing:Text(sales_list!=null?"Status: "+(get_status_by_id(sales_list[index]['status'])).toString():'empty'),
                           //subtitle: Text(sales_list!=null?sales_list[index]['status'].toString():''),
                         // subtitle: Text(sales_list!=null?sales_list[index]['customerName']['contactName']['name']:''),
                          subtitle: Text(sales_list[index]['date']!=null?sales_list[index]['date'].toString().substring(0,10):''),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_sales_details_page(sales_list[index], get_delivery_status_by_id(sales_list[index]['status']))));

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

  String get_delivery_status_by_id(int id){
    var status_type;
    if(sales_list!=null&&id!=null){
      if(id==1){
        status_type="Sold";
      }else if(id==2){
        status_type="Shipped";
      }else if(id==3){
        status_type="Delivered";
      }else if(id==4){
        status_type="Pregnant";
      }else if(id==5){
        status_type="Empty";
      }else{
        status_type="Bleeding Report";
      }
    }
    return status_type;
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
            const Text('Breeding Sales Caretaker'),
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
        BreedingSalesCareTakerServices.breedingSales_caretaker_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(sales_list!=null){
                sales_list.clear();
              }
              load_list=json.decode(response);
              sales_list = load_list['response'];
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

