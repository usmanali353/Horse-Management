import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/accountCategories_details.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/accountcategories_json.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/add_accountcategories.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/update_accountcategories.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';


class SearchList extends StatefulWidget{
  String token;
  SearchList(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchList_State(token);
  }

}

class _SearchList_State extends State<SearchList>{
  String token;
  _SearchList_State(this.token);
  var temp=['','',''];
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var category_lists, load_list, pagelist, pageloadlist,searchLoadList=null;
  int pagenum = 1;
  int total_page;
  int searchPageNum,totalSearchPages;
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _searchQuery =TextEditingController();

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        AccountCategoriesServices.account_catagories_by_page(token, pagenum, searchQuery).then((response){
          pd.dismiss();
          // print(response.length.toString());
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              category_lists = load_list['response'];
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
              //print(horse_list['createdBy']);
            });

          }else{
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("hoserlist empty"),backgroundColor: Colors.red,));
          }
        });
//        Add_horse_services.horselistWithSearch(token,pagenum,"hor").then((response) {
//          setState(() {
//            print("Teri mehrbani");
//            print(response);
//            load_list= json.decode(response);
//           // horse_list = load_list['response'];
//           // print(horse_list);
//          });
//        });
      }else
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Network Error")
        ));
    });

//    Utils.check_connectivity().then((result){
//      if(result){
//        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//        pd.show();
//        AccountCategoriesServices.account_catagories_by_page(token, pagenum, searchQuery).then((response){
//          pd.dismiss();
//          if(response!=null){
//            setState(() {
//              load_list=json.decode(response);
//              category_lists = load_list['response'];
//              total_page=load_list['totalPages'];
//              if(total_page == 1){
//                print("init state page =1");
//                setState(() {
//                  isPagination = false;
//                });
//              }else{
//                setState(() {
//                  isPagination = true;
//                });
//              }
//              print(total_page);
//              isVisible=true;
//            });
//
//          }else{
//            setState(() {
//              isVisible=false;
//            });
//            Scaffold.of(context).showSnackBar(SnackBar(
//              backgroundColor: Colors.red,
//              content: Text("List Not Available"),
//            ));
//          }
//        });
//      }else{
//        Scaffold.of(context).showSnackBar(SnackBar(
//          backgroundColor: Colors.red,
//          content: Text("Network Not Available"),
//        ));
//      }
//    });

 //   super.initState();

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
//                Container(
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: Color.fromARGB(255, 27, 28, 30),
//                      boxShadow: [BoxShadow(
//                        color: Colors.teal,
//                          //color: Color.fromARGB(130, 237, 125, 58),
//                          blurRadius: _animation.value,
//                          spreadRadius: _animation.value
//                      )]
//                  ),
//                  child:
                  FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      splashColor: Colors.red,
                      child: Icon(Icons.arrow_back, color: Colors.teal, size: 30,),heroTag: "btn2", onPressed: () {
                    if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                      Utils.check_connectivity().then((result){
                        if(result) {
                          ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                          pd.show();
                          AccountCategoriesServices.account_catagories_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            print("has pre in if");
                            setState(() {
                              //print(response);
                              load_list= json.decode(response);
                              category_lists = load_list['response'];
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
//                  FloatingActionButton(
//                      backgroundColor: Colors.transparent,
//                      splashColor: Colors.red,
//                      child: Icon(Icons.arrow_back, color: Colors.teal, size: 30,),heroTag: "btn2", onPressed: () {
//                    if(load_list['hasPrevious'] == true ) {
//                      Utils.check_connectivity().then((result){
//                        if(result) {
//                          ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
//                          pd.show();
//                          AccountCategoriesServices.account_catagories_by_page(token, pagenum,searchQuery).then((response) {
//                            pd.dismiss();
//                            setState(() {
//                              print(response);
//                              load_list= json.decode(response);
//                              category_lists = load_list['response'];
//
//                              print(category_lists);
//                            });
//                          });
//                        }else
//                          print("Network Not Available");
//                      });
//                    }
//                    else{
//                      print("Empty List");
//                      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
//                    }
//                    if(pagenum > 1){
//                      pagenum = pagenum - 1;
//                    }
//                    print(pagenum);
//                  }),
                  //  ),
//                Container(
//                  decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Color.fromARGB(255, 27, 28, 30),
//                      boxShadow: [BoxShadow(
//                          color: Colors.teal,
//                          //color: Color.fromARGB(130, 237, 125, 58),
//                          blurRadius: _animation.value,
//                          spreadRadius: _animation.value
//                      )]
//                  ),
//                  child:
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
                          AccountCategoriesServices.account_catagories_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              //print(response);
                              load_list = json.decode(response);
                              category_lists = load_list['response'];
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
//                  FloatingActionButton(
//
//                      backgroundColor: Colors.transparent,
//                      splashColor: Colors.red,
//                      child: Icon(Icons.arrow_forward, color: Colors.teal, size: 30,),heroTag: "btn1", onPressed: () {
//                        print(load_list['hasNext']);
//                          if (load_list['hasNext'] == true && pagenum >= 1) {
//                            Utils.check_connectivity().then((result) {
//                              if (result) {
//                                ProgressDialog pd = ProgressDialog(context,
//                                    isDismissible: true,
//                                    type: ProgressDialogType.Normal);
//                                pd.show();
//                                AccountCategoriesServices
//                                    .account_catagories_by_page(
//                                    token, pagenum, searchQuery).then((
//                                    response) {
//                                  pd.dismiss();
//                                  setState(() {
////                                  if (searchLoadList != null) {
////                                    searchLoadList.clear();
////                                  }
////                                  if (category_lists != null) {
////                                    category_lists.clear();
////                                  }
//                                    print(response);
////                                  load_list = json.decode(response);
////                                  category_lists = load_list['response'];
//                                    print('hello');
//                                    isVisible = true;
//                                    searchLoadList = json.decode(response);
//                                    category_lists = searchLoadList['response'];
//                                  });
//                                });
//                              } else
//                                print("Network Not Available");
//                            });
//                          }
//                          else{
//                            print('next else');
//                            print(searchQuery);
//                            print('Empty List');
//                          }
////                        else  if (load_list['hasNext'] == true && pagenum >= 1) {
////                          Utils.check_connectivity().then((result) {
////                            if (result) {
////                              ProgressDialog pd = ProgressDialog(context,
////                                  isDismissible: true,
////                                  type: ProgressDialogType.Normal);
////                              pd.show();
////                              AccountCategoriesServices
////                                  .account_catagories_by_page(
////                                  token, pagenum, '').then((response) {
////                                pd.dismiss();
////                                setState(() {
////                                  print(response);
////                                  category_lists = load_list['response'];
////                                  print(category_lists);
////                                });
////                              });
////                            } else
////                              print("Network Not Available");
////                          });
////                        }
//                          if (pagenum < total_page) {
//                            pagenum = pagenum + 1;
//                          }
//                          print(pagenum);
//                        }),
                  //)
                ]
            )
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              AccountCategoriesServices.account_catagories_by_page(
                  token, pagenum,searchQuery).then((response) {
                setState(() {
                  print(response);
                  load_list = json.decode(response);
                  category_lists = load_list['response'];
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
                  print(category_lists);
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

//          return Utils.check_connectivity().then((result){
//            if(result){
//              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//              pd.show();
//              AccountCategoriesServices.account_catagories_by_page(token, pagenum, searchQuery).then((response){
//                pd.dismiss();
//                if(response!=null){
//                  setState(() {
//                    load_list=json.decode(response);
//                    category_lists = load_list['response'];
//                    total_page=load_list['totalPages'];
//                    print("refresh page num");
//                    print(total_page);
//                    isVisible=true;
//                  });
//
//                }else{
//                  setState(() {
//                    isVisible=false;
//                  });
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                    backgroundColor: Colors.red,
//                    content: Text("List Not Available"),
//                  ));
//                }
//              });
//            }else{
//              Scaffold.of(context).showSnackBar(SnackBar(
//                backgroundColor: Colors.red,
//                content: Text("Network Not Available"),
//              ));
//            }
//          });
        },
        child: Visibility(
          visible: isVisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:category_lists!=null?category_lists.length:temp.length,itemBuilder: (context,int index){
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
                            print(category_lists[index]);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>update_accountcategories(token,category_lists[index])));
                          },
                        ),
                      ],
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.visibility_off,
                          color: Colors.red,
                          caption: 'Hide',
                          onTap: () async {
                            AccountCategoriesServices.changeAccountCategoryVisibility(token, category_lists[index]['id']).then((response){
                              print(response);
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  category_lists.removeAt(index);
                                });

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
                      child: FadeAnimation(2.0,
                        ListTile(
                          enabled: category_lists[index]['isActive'],
                          leading: FaIcon(FontAwesomeIcons.moneyCheck, color: Colors.teal.shade400, size: 40,),
                          title: Text(category_lists!=null?category_lists[index]['name']:''),
                          //subtitle: Text(category_lists!=null?category_lists[index]['description']:''),
                          //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>accountCategories_details_page(category_lists[index])));
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
            const Text('Account Categories'),
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
        AccountCategoriesServices.account_catagories_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(category_lists!=null){
                category_lists.clear();
              }
              load_list=json.decode(response);
              category_lists = load_list['response'];
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_accountcategories(token)),)

        ),


      )
    ];
  }





//  void _startSearch() {
//    print("open search box");
//    ModalRoute
//        .of(context)
//        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));
//
//    setState(() {
//      _isSearching = true;
//    });
//  }
//
//  void _stopSearching() {
//    _clearSearchQuery();
//
//    setState(() {
//      _isSearching = false;
//      searchLoadList=null;
//    });
//  }
//
//  void _clearSearchQuery() {
//    print("close search box");
//    setState(() {
//      _searchQuery.clear();
//      searchQuery=null;
//      updateSearchQuery("");
//      WidgetsBinding.instance
//          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    });
//  }
//
//  Widget _buildTitle(BuildContext context) {
//    var horizontalTitleAlignment =
//    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;
//
//    return new InkWell(
//      onTap: () => scaffoldKey.currentState.openDrawer(),
//      child: new Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 12.0),
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: horizontalTitleAlignment,
//          children: <Widget>[
//            const Text('Account Category'),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildSearchField() {
//    return new TextField(
//      controller: _searchQuery,
//      textInputAction: TextInputAction.search,
//      autofocus: true,
//      decoration: const InputDecoration(
//        hintText: 'Search...',
//        border: InputBorder.none,
//        hintStyle: const TextStyle(color: Colors.white30),
//      ),
//      style: const TextStyle(color: Colors.white, fontSize: 16.0),
//      onSubmitted: updateSearchQuery,
//    );
//  }
//
//  void updateSearchQuery(String newQuery) {
//
//    setState(() {
//      searchQuery = newQuery;
//      searchPageNum=1;
//    });
//    Utils.check_connectivity().then((result){
//      if(result){
//        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//        pd.show();
//        AccountCategoriesServices.account_catagories_by_page(token, pagenum,searchQuery).then((response){
//          pd.dismiss();
//          if(response!=null){
//            setState(() {
//              if(category_lists!=null){
//                category_lists.clear();
//              }
//              if(category_lists!=null){
//                category_lists.clear();
//              }
//              load_list=json.decode(response);
//              category_lists = load_list['response'];
//              total_page=load_list['totalPages'];
//              isVisible=true;
//            });
//
//          }else{
//            setState(() {
//              isVisible=false;
//            });
//            Scaffold.of(context).showSnackBar(SnackBar(
//              backgroundColor: Colors.red,
//              content: Text("List Not Available"),
//            ));
//          }
//        });
//      }else{
//        Scaffold.of(context).showSnackBar(SnackBar(
//          backgroundColor: Colors.red,
//          content: Text("Network Not Available"),
//        ));
//      }
//    });
//  }
//
//  List<Widget> _buildActions() {
//
//    if (_isSearching) {
//      return <Widget>[
//        new IconButton(
//          icon: const Icon(Icons.clear),
//          onPressed: () {
//            if (_searchQuery == null || _searchQuery.text.isEmpty) {
//              Navigator.pop(context);
//              return;
//            }
//            _clearSearchQuery();
//          },
//        ),
//      ];
//    }
//
//    return <Widget>[
//      new IconButton(
//        icon: const Icon(Icons.search),
//        onPressed: _startSearch,
//      ),
//      Padding(
//        padding: const EdgeInsets.all(16),
//        child: InkWell(
//          onTap: (){
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_accountcategories(token)));
//          },
//
//            child: Icon(Icons.add),
//
//        ),
//      ),
//    ];
//  }


}