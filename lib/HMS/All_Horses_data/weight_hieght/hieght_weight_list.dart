import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/All_Horses_data/lab_reports/update_lab_reports.dart';
import 'package:horse_management/HMS/All_Horses_data/services/weight_hieght_services.dart';
import 'package:horse_management/HMS/All_Horses_data/weight_hieght/add_weight_and_height.dart';
import 'package:horse_management/HMS/All_Horses_data/weight_hieght/update_hieght_weight.dart';
import 'package:horse_management/Utils.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class weight_hieght_list extends StatefulWidget{
  String token;


  weight_hieght_list (this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }

}
class _Profile_Page_State extends ResumableState<weight_hieght_list>{
  int id;
  SharedPreferences prefs;
  _Profile_Page_State (this.token);

  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isVisible=false,isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  String token;
  var weightlist, load_list;
  var temp=['',''];
  int pagenum=1,total_page;

  @override
  void onResume() {
    if(resume.data.toString()== "refresh"){
      print(resume.data.toString());
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
  }

  @override
  void initState () {
    _searchQuery =TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    labtest_services.horseIdLabtest(token, id).then((response){
//      setState(() {
//        print(response);
//        specifichorselab =json.decode(response);
//
//      });
//
//    });
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });

//    Utils.check_connectivity().then((result){
//      if(result) {
//        ProgressDialog pd = ProgressDialog(
//            context, isDismissible: true, type: ProgressDialogType.Normal);
//        pd.show();
//        weight_hieght_services.weight_hieght_list(token).then((response){
//          pd.dismiss();
//          setState(() {
//            print(response);
//            load_list =json.decode(response);
//            weightlist = load_list['response'];
//            total_page=load_list['totalPages'];
//            if(total_page == 1 || total_page == -2147483648){
//              print("init state page = 1");
//              setState(() {
//                isPagination = false;
//              });
//            }else{
//              print("init state multi page ");
//              setState(() {
//                isPagination = true;
//              });
//            }
//          });
//
//        });
//      }else
//        print("network nahi hai");
//    });



  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: _isSearching ? const BackButton() : null,
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
//          title: Text("Weight & Height"),actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_weight_and_height(token)),);
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
                    FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                      if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                        Utils.check_connectivity().then((result){
                          if(result) {
                            ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                            pd.show();
                            weight_hieght_services.weight_hieght_listbypage(token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list= json.decode(response);
                                weightlist = load_list['response'];
                                print(weightlist);
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
                    FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                      print(load_list['hasNext']);
                      if(load_list['hasNext'] == true && pagenum >= 1 ) {
                        Utils.check_connectivity().then((result){
                          if(result) {
                            ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                            pd.show();
                            weight_hieght_services.weight_hieght_listbypage(
                                token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list = json.decode(response);
                                weightlist = load_list['response'];
                                print(weightlist);
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
                  weight_hieght_services.weight_hieght_listbypage(
                      token, pagenum,searchQuery).then((response) {
                    setState(() {
                      print(response);
                      load_list = json.decode(response);
                      weightlist = load_list['response'];
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
          child: ListView.builder(itemCount:weightlist!=null?weightlist.length:temp.length,itemBuilder: (context,int index){
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
                        weight_hieght_services.weight_hieghtvisibilty(token, weightlist[index]['whid']).then((response){
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
                    IconSlideAction(onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>update_weight_and_height(weightlist[index],prefs.get('token'))));

                    },color: Colors.blue,icon: Icons.border_color,caption: 'update',)
                  ],
                  child: ListTile(
                    //specifichorselab!=null?(specifichorselab[index]['testTypesdropDown']['name']):''
                    title: Text(weightlist!=null?(weightlist[index]['horseName']['name']):''),
                    subtitle: Text(weightlist[index]['weight']!=null?"Weight: "+(weightlist[index]['weight']).toString():'weight empty'),
                    trailing: Text(weightlist[index]['height']!=null?"Height: "+(weightlist[index]['height']).toString():'hieght empty'),
                    //leading: Image.asset("Assets/horses_icon.png"),
                    onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      print((weightlist[index]));
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>update_weight_and_height(weightlist[index]['id'],prefs.get('token'),prefs.get('createdBy'))));
                    },
                  ),

//               secondaryActions: <Widget>[
//
//               ],
                ),
                Divider(),
              ],

            );

          }),
        )
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
            const Text('Weight & Hieght'),
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
        weight_hieght_services.weight_hieght_listbypage(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(weightlist!=null){
                weightlist.clear();
              }
              load_list=json.decode(response);
              weightlist = load_list['response'];
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_weight_and_height(token)),)

        ),


      )
    ];
  }

}