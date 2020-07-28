import 'dart:convert';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/add_new_picture.dart';
import 'package:horse_management/HMS/All_Horses_data/horse_picture/update_picture.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
class pictures_list extends StatefulWidget{
  String token;

  pictures_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pictures_list_state(token);
  }

}
class _pictures_list_state extends State<pictures_list>{
  String token;

  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var horse_list;
  var picture_list=[],load_list;
  var temp=['',''];
  int pagenum=1,total_page;
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            //title: Text("Pictures")
          leading: _isSearching ? const BackButton() : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
        ),
//        floatingActionButton: FloatingActionButton(
//          child: Icon(
//            Icons.add,
//            color: Colors.white,
//          ),
//          onPressed: (){
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_picture(token)));
//          },
//
//        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                          network_operations.get_all_notes(token,pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              isvisible=true;
                              load_list=json.decode(response);
                              picture_list = load_list['response'];
                            });
                          });
                        }else
                         Flushbar(message: "Network error",backgroundColor: Colors.red,duration: Duration(seconds: 3),)..show(context);
                      });
                    }
                    else{
                      Flushbar(message: "Empty List",backgroundColor: Colors.red,duration: Duration(seconds: 3),)..show(context);

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
                          network_operations.get_all_pictures_by_page(
                              token,pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              isvisible=true;
                              load_list=json.decode(response);
                              picture_list = load_list['response'];
                            });
                          });
                        }else
                          Flushbar(message: "Network error",backgroundColor: Colors.red,duration: Duration(seconds: 3),)..show(context);
                      });
                    }
                    else{
                      Flushbar(message: "List empty",backgroundColor: Colors.red,duration: Duration(seconds: 3),)..show(context);

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

        body:
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                    pd.show();
                    network_operations.get_all_pictures(token).then((response){
                      pd.dismiss();
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          load_list=json.decode(response);
                          picture_list = load_list['response'];
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
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Pictures List Not Found"),
                        ));
                        setState(() {
                          isvisible=false;
                        });
                      }
                    });
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Network not Available"),
                    ));
                  }
                });
              },
              child: Visibility(
                visible: isvisible,
                child: ListView.builder(itemCount:picture_list!=null?picture_list.length:temp.length,itemBuilder: (context,int index){
                  return Column(
                    children: <Widget>[
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.20,
                        secondaryActions: <Widget>[

                        ],
                        actions: <Widget>[
                          IconSlideAction(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            caption: 'Hide',
                            onTap: () async {
                              network_operations.change_picture_visibility(token, picture_list[index]['pictureId']).then((response){
                                print(response);
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    picture_list.removeAt(index);
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
                          IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.blue,
                            caption: 'Update',
                            onTap: () async {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>update_picture(token,picture_list[index])));
                            },
                          ),
                        ],
                        child: ListTile(
                          enabled: picture_list[index]['isActive'],
                          title: Text(picture_list!=null?picture_list[index]['horseName']['name']:''),
                          subtitle: Text(picture_list!=null?picture_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
                          leading: picture_list[index]['image']!=null?Container(width: 50,child: Image.memory(base64.decode(picture_list[index]['image']))):Text(''),
                          onTap: (){
                                return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Preview',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.1
              ),
            ),
            content: Image.memory(base64.decode(picture_list[index]['image'])),
          );
        }
    );
                          },
                        ),
                      ),
                      Divider(),
                    ],

                  );

                }),
              ),
            ),
    );
  }

  @override
  void initState() {
    _searchQuery =TextEditingController();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _pictures_list_state(this.token);


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
            const Text('Pictures'),
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
        network_operations.get_all_pictures_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(picture_list!=null){
                picture_list.clear();
              }
              load_list=json.decode(response);
              picture_list = load_list['response'];
              total_page=load_list['totalPages'];
              print(total_page);
              isvisible=true;
              if(total_page == 1 || total_page == -2147483648){
                setState(() {
                  isPagination = false;

                });
              }else{
                isPagination = true;
              }

            });

          }else{
            setState(() {
              isvisible=false;
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>add_new_picture(token))),

        ),


      )
    ];
  }




}