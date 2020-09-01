import 'dart:convert';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/my_horses/add_horse/add_horse_new.dart';
import 'package:horse_management/HMS/my_horses/add_horse/add_horse_req.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'horse_detail_page.dart';
import 'package:need_resume/need_resume.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class horse_list extends StatefulWidget{
  String token;

  horse_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }
}
 class _training_list_state extends ResumableState<horse_list>{
  String token;
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isVisible=false,isPagination=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var horse_list, load_list;
  int pagenum = 1;
  int total_page;
  var temp=[];
  TextEditingController searchController;
  _training_list_state (this.token);
//  @override
//  void onResume() {
//    print("Data "+resume.data.toString());
//    if(resume.data.toString()=='Refresh') {
//      WidgetsBinding.instance
//          .addPostFrameCallback((_) =>
//          _refreshIndicatorKey.currentState
//              .show());
//    }
//  }

   @override
   void onResume() {
     if(resume.data.toString()== "refresh"){
       print(resume.data.toString());
       WidgetsBinding.instance
           .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
     }
   }

  @override
  void initState() {
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _searchQuery =TextEditingController();

    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(
            context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        Add_horse_services.horselist(token).then((response){
          pd.dismiss();
          pd.hide();
          // print(response.length.toString());
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              horse_list = load_list['response'];
              total_page=load_list['totalPages'];
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
  }



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: _isSearching ? const BackButton() : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
//          title: Text("All Horses "),
//            actions:
//        <Widget>[
////          TextField(
////          controller: searchController,
////          autofocus: true,
////          decoration: const InputDecoration(
////            hintText: 'Search...',
////            border: InputBorder.none,
////            hintStyle: const TextStyle(color: Colors.white30),
////          ),
////          style: const TextStyle(color: Colors.white, fontSize: 16.0),
////          onSubmitted: (value) {
////            Add_horse_services.horselistWithSearch(token,"").then((response) {
////              setState(() {
////                print(response);
////                load_list= json.decode(response);
////                horse_list = load_list['response'];
////                print(horse_list);
////              });
////            });
////          },
////        ),
//          Center(child: Text("Add New",textScaleFactor: 1.5,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseNew(token)),);
//            },
//          )
//        ],
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
                            Add_horse_services.horselistbypage(token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              pd.hide();
                              print("has pre in if");
                              setState(() {
                                //print(response);
                                load_list= json.decode(response);
                                horse_list = load_list['response'];
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
                            Add_horse_services.horselistbypage(
                                token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                //print(response);
                                load_list = json.decode(response);
                                horse_list = load_list['response'];
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
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return Utils.check_connectivity().then((result){
              if(result){
                ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                pd.show();
                Add_horse_services.horselistbypage(token, pagenum,searchQuery).then((response) {
                  pd.dismiss();
                  pd.hide();
                  setState(() {
                    print(response);
                    load_list = json.decode(response);
                    horse_list = load_list['response'];
                    total_page=load_list['totalPages'];
                    if(total_page == 1 || total_page == -2147483648){
                      print("refresh page = 1");
                      setState(() {
                        isPagination = false;
                      });
                    }else{
                      print("ref multi page ");
                      setState(() {
                        isPagination = true;
                      });
                    }
                    print(horse_list);
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
          child: ListView.builder(itemCount:horse_list!=null?horse_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
//                TextField(
//                  decoration: InputDecoration(
//                    hintText: 'Search...',
//                    hintStyle:  TextStyle(color: Colors.white, fontSize: 16.0),
//
//                  ),
//                 controller: searchController,
//                  onTap: () => updateSearchQuery,
//                ),
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Add_horse_services.horsevisibilty(token, horse_list[index]['horseId']).then((response){
                          //replytile.removeWhere((item) => item.id == horse_list[index]['horseId']);
                          print(response);
                          if(response!=null){

                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor:Colors.green ,
                              content: Text('Visibility Changed'),
                            ));

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
                  child: ListTile(
                    enabled: horse_list[index]['isActive'],
                    leading:
                    //horse_list[index]['image']!=null?Container(width: 50,child: Image.memory(base64.decode(horse_list[index]['image']))):Text(''),

          horse_list[index]['image']!=null?Image.memory(base64.decode(horse_list[index]['image'])):Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                    //leading: Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                    title: Text(horse_list!=null?(horse_list[index]['name']):''),
                    //subtitle: Text(horse_list[index]['dateOfBirth']!=null?horse_list[index]['dateOfBirth'].toString().substring(0,10):''),
                   subtitle: Column(
                     children: <Widget>[
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Row(children: <Widget>[
                             FaIcon(FontAwesomeIcons.palette, color: Colors.red, size: 12,),
                             Padding(
                               padding: EdgeInsets.only(left: 3, right:3),
                             ),
                             Text(horse_list[index]['colorName']['name']!=null?horse_list[index]['colorName']['name'].toString():''),
                           ],
                           ),
                           Row(children: <Widget>[
                             FaIcon(FontAwesomeIcons.calendarAlt, color: Colors.lightBlue, size: 12,),
                             Padding(
                               padding: EdgeInsets.only(left: 3, right:3),
                             ),
                             Text(horse_list[index]['dateOfBirth']!=null?horse_list[index]['dateOfBirth'].toString().substring(0,10):''),
                           ],
                           ),
                           //Text(horse_list[index]['colorName']['name']!=null?horse_list[index]['colorName']['name'].toString():''),

                         ],
                       ),
                       Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                   Row(children: <Widget>[
                                     FaIcon(FontAwesomeIcons.horse, color: Colors.brown, size: 12,),
                                     Padding(
                                       padding: EdgeInsets.only(left: 3, right:3),
                                     ),
                                     Text(horse_list[index]['breedName']['name']!=null?horse_list[index]['breedName']['name'].toString():''),
                                   ],
                                   ),
                                   Row(children: <Widget>[
                                     FaIcon(FontAwesomeIcons.venusMars, color: Colors.pink.shade100, size: 12,),
                                     Padding(
                                       padding: EdgeInsets.only(left: 3, right:3),
                                     ),
                                     Text(horse_list!=null?get_check_method_by_id(horse_list[index]['genderId']):''),
                                   ],
                                   ),
                              ],
                             ),

                     ],
                   ),
                    //leading: Image.asset("Assets/horses_icon.png"),
                    onTap: (){
                      print((horse_list[index]));
                      push(context, MaterialPageRoute(builder: (context)=>horse_detail(horse_list[index])));
                    },
                  ),


                ),
                Divider(),
              ],

            );

          }),
        )

    );
  }

   String get_check_method_by_id(int id){
     var gender;
     if(horse_list!=null&&id!=null){
       if(id==1){
         gender="Male";
       }else if(id==2){
         gender="Female";
       }else if(id==3){
         gender="Geilding";
       }
     }
     return gender;
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
             const Text('All Horses'),
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
         Add_horse_services.horselistWithSearch(token,pagenum,searchQuery).then((response){
           pd.dismiss();
           if(response!=null){
             setState(() {
               if(load_list!=null){
                 load_list.clear();
               }
               if(horse_list!=null){
                 horse_list.clear();
               }
               load_list=json.decode(response);
               horse_list = load_list['response'];
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
           onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseNew(token)),)

         ),


       )
     ];
   }



}










//class horse_list extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _Profile_Page_State();
//  }
//}
//
//class _Profile_Page_State extends State<horse_list> {
//  String title, dateOfBirth;
//  var horselist;
//  List<String> horse = [];
//  var token;
//
//  @override
//  void initState() {
//    Add_horse_services.horselist(token).then((response) {
//      // print(response.length.toString());
//      setState(() {
//        //var parsedjson = jsonDecode(response);
//        horselist = jsonDecode(response);
//        print(horselist);
//        horse.add(horselist);
//
//        for (int i = 0; i < horselist.length; i++)
//          horse.add(horselist[i]['name']);
//        print(horse.length.toString());
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("My Horses"),
//        actions: <Widget>[
//          Center(
//              child: Text(
//            "Add New",
//            textScaleFactor: 1.5,
//          )),
//          IconButton(
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async {
//              SharedPreferences prefs = await SharedPreferences.getInstance();
//              token = await prefs.getString("token");
//
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => add_newHorse(token)),
//              );
//            },
//          )
//        ],
//      ),
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.all(20.0),
//            child: ListView(
//              shrinkWrap: true,
//              children: <Widget>[
//                ListTile(
//                  title: Text("mkk"),
//                  subtitle: Text("Horse Date of Birth"),
//                  trailing: Icon(Icons.arrow_right),
//                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
//                  onTap: (){
//                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
//                  },
//                ),
//                ListTile(
//                  title: Text("kj"),
//                  subtitle: Text("20/12/2018"),
//                  leading: Image.asset("Assets/horse_icon.png",width: 50,height: 50,),
//                  trailing: Icon(Icons.arrow_right),
//                  onTap: (){
//                    Navigator.push(context,MaterialPageRoute(builder: (context)=>horse_detail()));
//                  },
//                ),
//
//              ],
//            ),
//          ),
//        ],
//      )
//    );
//  }
//}
