import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class already_trained_horses_list extends StatefulWidget{
  String token;

  already_trained_horses_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _already_trained_horses_list_state(token);
  }

}
class _already_trained_horses_list_state extends State<already_trained_horses_list>{
  String token;
  var horse_list, load_list , pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var already_trained_list=[];
  var temp=['',''];
  bool isvisible=false;
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isVisible=false,isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                          network_operations.already_trainedHorses_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              already_trained_list = load_list['response'];
                              print(horse_list);
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
                          network_operations.already_trainedHorses_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list = json.decode(response);
                              already_trained_list = load_list['response'];
                              print(horse_list);
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
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.get_horses_already_trained(token).then((response){
                pd.dismiss();
                if(response!=null){
                  print(response);
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    already_trained_list = load_list['response'];
                    total_page=load_list['totalPages'];
                    if(total_page == 1){
                      print("init state page = 1");
                      isPagination = false;
                    }else{
                      print("init state multi page ");
                      setState(() {
                        isPagination = true;
                      });
                    }
                    print(total_page);
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Trained horses List Not Found"),
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
          child: Scrollbar(
            child: ListView.builder(itemCount:already_trained_list!=null?already_trained_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.delete,
                        color: Colors.red,
                        caption: 'Delete',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.delete_already_trained_horses(token, already_trained_list[index]['trainingId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Horse Deleted'),
                                  ));
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
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
                    child: ListTile(
                      enabled: already_trained_list[index]['isActive'],
                      title: Text(already_trained_list!=null?already_trained_list[index]['horseName']['name']:''),
                      //trailing: Text(already_trained_list!=null?already_trained_list[index]['startDate'].replaceAll("T00:00:00",''):''),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  FaIcon(FontAwesomeIcons.clipboard, color: Colors.brown, size: 12,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3, right:3),
                                  ),
                                  Text(already_trained_list!=null?already_trained_list[index]['trainingPlanName']['name'].toString():''),
                                ],
                                ),
                                Row(children: <Widget>[
                                  FaIcon(FontAwesomeIcons.calendarAlt, color: Colors.lightBlue, size: 12,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3, right:3),
                                  ),
                                  Text(already_trained_list!=null?already_trained_list[index]['startDate'].toString().substring(0,10):'') ,
                                ],
                                ),

                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  FaIcon(FontAwesomeIcons.dumbbell, color: Color(0XFFb8b7ba), size: 12,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3, right:3),
                                  ),
                                  Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                                ],
                                ),
//                                Row(children: <Widget>[
//                                  FaIcon(FontAwesomeIcons.dumbbell, color: Color(0XFFb8b7ba), size: 12,),
//                                  Padding(
//                                    padding: EdgeInsets.only(left: 3, right:3),
//                                  ),
//                                  Text(already_trained_list!=null?already_trained_list[index]['donorName']['name'].toString():''),
//
//                                ],
//                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                      leading: Image.asset("assets/horse_icon.png"),
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(already_trained_list[index],'')));
                      },
                    ),


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

  @override
  void initState() {
    _searchQuery =TextEditingController();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _already_trained_horses_list_state(this.token);
  String get_training_type_by_id(int id){
    var training_type_name;
    for (int i=0;i<already_trained_list.length;i++){
      if(id==1){
        training_type_name="Simple";
      }else if(id==2){
        training_type_name='Endurance';
      }else if(id==3){
        training_type_name="Customized";
      }else if(id==4){
        training_type_name="Speed";
      }
    }
    return training_type_name;
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
        network_operations.already_trainedHorses_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(already_trained_list!=null){
                already_trained_list.clear();
              }
              load_list=json.decode(response);
              already_trained_list = load_list['response'];
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
//            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_training(token)),)
//
//        ),
//
//
//      )
    ];
  }

}