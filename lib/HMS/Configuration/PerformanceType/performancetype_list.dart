import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Configuration/Locations/location_json.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/add_performancetype.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/performanceType_details.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/performancetype_json.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/update_performancetype.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';




class performancetype_list extends StatefulWidget{
  String token;
  performancetype_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _performancetype_list(token);
  }
}

class _performancetype_list extends State<performancetype_list>{
  String token;
  _performancetype_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  int searchPageNum,totalSearchPages;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var type_lists, load_list, pagelist, pageloadlist;
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
        PerformanceTypesServices.performanceType_by_page(token, pagenum, searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              type_lists = load_list['response'];
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
                          PerformanceTypesServices.performanceType_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            print("has pre in if");
                            setState(() {
                              //print(response);
                              load_list= json.decode(response);
                              type_lists = load_list['response'];
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
                          PerformanceTypesServices.performanceType_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              //print(response);
                              load_list = json.decode(response);
                              type_lists= load_list['response'];
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
              PerformanceTypesServices.performanceType_by_page(
                  token, pagenum,searchQuery).then((response) {
                setState(() {
                  print(response);
                  load_list = json.decode(response);
                  type_lists = load_list['response'];
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
                  print(type_lists);
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
            child: ListView.builder(itemCount:type_lists!=null?type_lists.length:temp.length,itemBuilder: (context,int index){
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
                            print(type_lists[index]);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>update_performancetype(token,type_lists[index])));
                          },
                        ),
                      ],
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.visibility_off,
                          color: Colors.red,
                          caption: 'Hide',
                          onTap: () async {
                            PerformanceTypesServices.changePerformanceTypeVisibility(token, type_lists[index]['performanceId']).then((response){
                              print(response);
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  type_lists.removeAt(index);
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
                           enabled: type_lists[index]['isActive'],
                           leading: FaIcon(FontAwesomeIcons.chartLine, color: Colors.teal.shade200, size: 40,),
                           title: Text(type_lists!=null?type_lists[index]['name']:''),
                          // subtitle: Text(costcenter_lists!=null?costcenter_lists[index]['description']:''),
                          //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>performanceType_details_page(type_lists[index])));
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
            const Text('Performance Type'),
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
        PerformanceTypesServices.performanceType_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(type_lists!=null){
               type_lists.clear();
              }
              load_list=json.decode(response);
              type_lists = load_list['response'];
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
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => add_performancetype(token)),)

        ),


      )
    ];
  }

}