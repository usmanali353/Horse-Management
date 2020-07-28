import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/session_list.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class training_list extends StatefulWidget{
  String token;

  training_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }

}
class _training_list_state extends State<training_list>{
  String token;
  var horse_list;
  var training_list=[],today_training_list=[], load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var temp=['',''];
  bool isvisible=false;
  var trainingListBox;

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
        //leading: _isSearching ? null : const BackButton(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),

//      appBar: AppBar(title: Text("Training List"),actions: <Widget>[
//        Center(child: Text("Add New",textScaleFactor: 1.3,)),
//        IconButton(
//
//          icon: Icon(
//            Icons.add,
//            color: Colors.white,
//          ),
//          onPressed: () {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => add_training(token)),);
//          },
//        )
//      ],),
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
                          network_operations.trainings_by_page(token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list= json.decode(response);
                              training_list = load_list['response'];
                              print(training_list);
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
                          network_operations.trainings_by_page(
                              token, pagenum,searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              print(response);
                              load_list = json.decode(response);
                              training_list = load_list['response'];
                              print(training_list);
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
              network_operations.get_training(token,pagenum).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    training_list = load_list['response'];
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

                    for(int i=0;i<training_list.length;i++){
                      if(DateTime.parse(training_list[i]['startDate'])==DateTime.now()){
                        today_training_list.add(training_list[i]);
                      }
                    }
                    // print('Training list Length'+training_list.length.toString());
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Training List Not Found"),
                  ));
                  setState(() {
                    isvisible=false;
                  });
                }
              });
            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: ListView.builder(itemCount:training_list!=null?training_list.length:temp.length,itemBuilder: (context,int index){
            return  Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      icon: Icons.list,
                      color: Colors.green,
                      caption: 'Sessions',
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => training_session_list(token, training_list[index])));
                      },
                    ),
                  ],
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Utils.check_connectivity().then((result) {
                          if (result) {
                            ProgressDialog pd = ProgressDialog(context,
                                type: ProgressDialogType.Normal,
                                isDismissible: true);
                            pd.show();
                            network_operations
                                .change_training_visibility(token,
                                training_list[index]['trainingId'])
                                .then((response) {
                              pd.dismiss();
                              if (response != null) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Visibility Changed'),
                                    ));
                                setState(() {
                                  training_list.removeAt(index);
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Failed'),
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
                      color: Colors.green,
                      caption: "End Training",
                      icon: FontAwesomeIcons.check,
                      onTap: () async {
                        Utils.check_connectivity().then((result) {
                          if (result) {
                            var pd = ProgressDialog(context,
                                type: ProgressDialogType.Normal,
                                isDismissible: true);
                            pd.show();
                            network_operations.end_training(token,
                                training_list[index]['trainingId'])
                                .then((response) {
                              pd.dismiss();
                              if (response != null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) =>
                                    _refreshIndicatorKey.currentState
                                        .show());
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Training Ended"),
                                      backgroundColor: Colors.green,
                                    ));
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Training not Ended"),
                                      backgroundColor: Colors.red,
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
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => update_training(
                                token, training_list[index])));
                      },
                    ),
                  ],
                  child: FadeAnimation(2.0,
                    ListTile(
                      enabled: training_list[index]['isActive'],

                      title: Text(training_list != null
                          ? training_list[index]['horseName']['name']
                          : ''),
                      trailing: Text(training_list != null
                          ? training_list[index]['startDate']
                          .toString()
                          .replaceAll("T00:00:00", '')
                          : ''),
                      subtitle: Text(training_list != null
                          ? get_training_type_by_id(
                          training_list[index]['trainingType'])
                          : ''),
                      leading: Icon(Icons.fitness_center, size: 40,
                        color: Colors.teal,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => training_details_page(training_list[index], get_training_type_by_id(training_list[index]['trainingType']))));
                      },
                    ),
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }

  _training_list_state(this.token);
  String get_training_type_by_id(int id){
    var training_type_name;
    for (int i=0;i<training_list.length;i++){
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
        network_operations.trainings_by_page(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(training_list!=null){
                training_list.clear();
              }
              load_list=json.decode(response);
              training_list = load_list['response'];
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