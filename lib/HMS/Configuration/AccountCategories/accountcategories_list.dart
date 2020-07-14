import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/accountcategories_json.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/add_accountcategories.dart';
import 'package:horse_management/HMS/Configuration/AccountCategories/update_accountcategories.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:io';

import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';



class accountcategories_list extends StatefulWidget{
  String token;
  accountcategories_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _accountcategories_list(token);
  }
}

class _accountcategories_list extends State<accountcategories_list> with SingleTickerProviderStateMixin{
  String token;
  _accountcategories_list(this.token);
  var temp=['','',''];
  var _isSearching=false, accountCategories;
   var searchQuery = "Search query";
  TextEditingController _searchQuery;
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var category_lists, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _searchQuery=TextEditingController();
    // TODO: implement initState
//    _animationController = AnimationController(vsync:this,duration: Duration(seconds: 2));
//    _animationController.repeat(reverse: true);
//    _animation =  Tween(begin: 2.0,end: 15.0).animate(_animationController)..addListener((){
//      setState(() {
//
//      });
//    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_accountcategories(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
//        leading: _isSearching ? const BackButton() : null,
//        title: _isSearching ? _buildSearchField() : _buildTitle(context),
//        actions: _buildActions(),

        title: Text("Account Categories"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_accountcategories(token)),);
            },
          )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
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
                          AccountCategoriesServices.account_catagories_by_page(token, pagenum,'').then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              category_lists = load_list['response'];
                              print(category_lists);
                            });
                          });
                        }else
                          print("Network Not Available");
                      });
                    }
                    else{
                      print("Empty List");
                      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                    }
                    if(pagenum > 1){
                      pagenum = pagenum - 1;
                    }
                    print(pagenum);
                  }),
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
                              token, pagenum,'').then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              isVisible=true;
                              load_list = json.decode(response);
                              category_lists = load_list['response'];
                              print(category_lists);
                            });
                          });
                        }else
                          print("Network Not Available");
                      });
                    }
                    else{
                      print("Empty List");
                      //Scaffold.of(context).showSnackBar(SnackBar(content: Text("List empty"),));
                    }
                    if(pagenum < total_page) {
                      pagenum = pagenum + 1;
                    }
                    print(pagenum);

                  }),
                //)
              ]
          )
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              AccountCategoriesServices.getAccountCategory(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    isVisible=true;
                    category_lists = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(total_page);

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
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>currency_lists(token,currency_lists[index])));
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

//  void _startSearch() {
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
//    setState(() {
//      _isSearching = false;
//      category_lists.addAll(accountCategories);
//    });
//  }
//
//  void _clearSearchQuery() {
//    setState(() {
//      _searchQuery.clear();
//      category_lists.clear();
//      category_lists.addAll(accountCategories);
//      updateSearchQuery("Search query");
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
//            const Text('Account Categories'),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildSearchField() {
//    return new TextField(
//      controller: _searchQuery,
//      autofocus: true,
//      decoration: const InputDecoration(
//        hintText: 'Search...',
//        border: InputBorder.none,
//        hintStyle: const TextStyle(color: Colors.white30),
//      ),
//      style: const TextStyle(color: Colors.white, fontSize: 16.0),
//      onChanged: updateSearchQuery,
//    );
//  }
//
//  void updateSearchQuery(String newQuery) {
//    setState(() {
//      category_lists.clear();
//      searchQuery = newQuery;
//      if(searchQuery.length>0){
//        for(int i=0;i<accountCategories.length;i++){
//          if(accountCategories[i]['id'].toLowerCase().contains(searchQuery)||accountCategories[i]['name'].toLowerCase().contains(searchQuery)){
//            category_lists.add(accountCategories[i]);
//          }
//        }
//      }else{
//        category_lists.addAll(accountCategories);
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
//    ];
//  }
}