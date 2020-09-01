import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';

class trainingPlanList extends StatefulWidget{
  String token;

  trainingPlanList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return trainingPlanListState(token);
  }

}
class trainingPlanListState extends State<trainingPlanList>{
  String token;
  var horse_list;
  var training_list=[], load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var temp=['',''];
  bool isvisible=false;

  trainingPlanListState(this.token);

  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _searchQuery = TextEditingController();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),

//        title: Text("Training Plans"),
//        actions: <Widget>[
//        Center(child: Text("Add New",textScaleFactor: 1.3,)),
//    IconButton(
//
//    icon: Icon(
//    Icons.add,
//    color: Colors.white,
//    ),
//    onPressed: () {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => training_plan()),);
//    },
//    )
////          IconButton(
////            icon: Icon(Icons.picture_as_pdf),
////           // onPressed: () => _generatePdfAndView(context),
////          ),
//    ],
      ),

//      floatingActionButton: FloatingActionButton(
////        child: Icon(
////          Icons.add,
////          color: Colors.white,
////        ),
////        onPressed: (){
////          Navigator.push(context, MaterialPageRoute(builder: (context)=>training_plan()));
////        },
////
////      ),
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
                          network_operations.trainingPlan_by_page(token, pagenum,searchQuery).then((response) {
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
                          network_operations.trainingPlan_by_page(
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
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.getTrainingPlans(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    training_list = load_list['response'];
                    total_page=load_list['totalPages'];
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

                    // print('Training list Length'+training_list.length.toString());
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Training Plans List Not Found"),
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
            child: ListView.builder(itemCount:training_list!=null?training_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              network_operations.changeTrainingPlanVisibility(token, training_list[index]['planId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    training_list.removeAt(index);
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
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          print(training_list[index]['planExercises']);
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
                        },
                      ),
                    ],
child: FadeAnimation(2.0,
  ListTile(
    enabled: training_list[index]['isActive'],
    leading: FaIcon(FontAwesomeIcons.dumbbell, color:Colors.teal.shade700, size: 40,),
    title: Text(training_list!=null?training_list[index]['name']:''),

    //trailing: Text(semen_stock_list[index]['enterDate']!=null?semen_stock_list[index]['enterDate'].toString().substring(0,10):''),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                FaIcon(FontAwesomeIcons.clipboard, color: Color(0XFFb8b7ba), size: 12,),
                Padding(
                  padding: EdgeInsets.only(left: 3, right:3),
                ),
                Text(training_list[index]['planExercises']!=null?training_list[index]['planExercises'][0]['name'].toString():''),
              //Text(training_list[index]['exercises']!=null?training_list[index]['exercises'].toString():''),
              ],
              ),
//              Row(children: <Widget>[
//                FaIcon(FontAwesomeIcons.clipboard, color: Color(0XFFb8b7ba), size: 12,),
//                Padding(
//                  padding: EdgeInsets.only(left: 3, right:3),
//                ),
//                Text(training_list[index]['planExercises']!=null?training_list[index]['planExercises'][0]['name'].toString():''),
//              ],
//              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 3, bottom: 3),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                FaIcon(FontAwesomeIcons.comment, color: Colors.amber, size: 12,),
                Padding(
                  padding: EdgeInsets.only(left: 3, right:3),
                ),
                Text(training_list[index]['planExercises'][0]!=null?training_list[index]['planExercises'][0]['description'].toString():''),
              ],
              ),
//              Row(children: <Widget>[
//                FaIcon(FontAwesomeIcons.comment, color: Colors.amber, size: 12,),
//                Padding(
//                  padding: EdgeInsets.only(left: 3, right:3),
//                ),
//              Text(training_list[index]['planExercises'][0]!=null?training_list[index]['planExercises'][0]['description'].toString():''),
//              ],
//              ),
            ],
          ),
        ],
      ),
    ),
    //Text(semen_stock_list!=null?semen_stock_list[index]['tankName']['name']:''),
    onTap: () {
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(training_list[index],get_training_type_by_id(training_list[index]['trainingType']))));    },
    }),
),
//                    child: ExpansionTile(
//                     // enabled: training_list[index]['isActive'],
//                      title: Text(training_list!=null?training_list[index]['name']:''),
//                      //trailing: Text(training_list!=null?training_list[index]['startDate'].toString().replaceAll("T00:00:00",''):''),
//                     // subtitle: Text(training_list!=null?get_training_type_by_id(training_list[index]['trainingType']):''),
//                      leading: Icon(Icons.fitness_center,size: 40,color: Colors.teal,),
////                      onTap: (){
////                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(training_list[index],get_training_type_by_id(training_list[index]['trainingType']))));
////                      },
//                    children: <Widget>[
//                      ListTile(
//                        title: Text("Execise"),
//                        trailing: Text(training_list[index]['exercises']!=null?training_list[index]['exercises'].toString():''),
//                      ),
//                      ListTile(
//                        title: Text("Plan Exercise Name"),
//                       trailing: Text(training_list[index]['planExercises']!=null?training_list[index]['planExercises'][0]['name'].toString():''),
//                      ),
//                      ListTile(
//                        title: Text("Plan Exercise Description"),
//                        trailing: Text(training_list[index]['planExercises'][0]!=null?training_list[index]['planExercises'][0]['description'].toString():''),
//                      ),
//                    ],
//                    ),


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
            const Text('Training Plans'),
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
        network_operations.trainingPlan_by_page(token,pagenum,searchQuery).then((response){
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
              isvisible=true;
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => training_plan()),)

        ),


      )
    ];
  }


}