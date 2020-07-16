import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/add_horse/update_horse.dart';
import 'package:horse_management/HMS/All_Horses_data/services/add_horse_services.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_horseGroup.dart';
import 'add_horse_to_group.dart';
import 'horsegroup_services.dart';
import 'horses_list_in_group.dart';


class horseGroup_list extends StatefulWidget{
  String token;

  horseGroup_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_list_state(token);
  }

}
class _training_list_state extends State<horseGroup_list>{
  String token;
  _training_list_state (this.token);
  SharedPreferences prefs;
  var group_list, load_list;
  var temp=['',''];
  int pagenum=1,total_page;
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isVisible=false,isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    setState(() {
//      String createdBy = group_list['createdBy'];
//      print(group_list);
//    });



//    Utils.check_connectivity().then((result){
//      if(result) {
//        ProgressDialog pd = ProgressDialog(
//            context, isDismissible: true, type: ProgressDialogType.Normal);
//        pd.show();
//        Add_horsegroup_services.horsegrouplist(token).then((respons){
//          pd.dismiss();
//          // print(response.length.toString());
//          if(respons!=null){
//            setState(() {
//              //var parsedjson = jsonDecode(response);
//              print(respons);
//              print("object");
//              load_list  = jsonDecode(respons);
//              group_list = load_list['response'];
//              total_page=load_list['totalPages'];
//              print(group_list);
//              //print(group_list['createdBy']);
//            });
//
//          }else{
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text(" empty"),backgroundColor: Colors.red,));
//          }
//        });
//      }else
//        Scaffold.of(context).showSnackBar(SnackBar(
//            backgroundColor: Colors.red,
//            content: Text("Network Error")
//        ));
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
//          title: Text(" Horses Group"),
//          actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseGroup(token)),);
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
                            Add_horsegroup_services.horsegrouplistbypage(token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list= json.decode(response);
                                group_list = load_list['response'];
                                print(group_list);
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
                            Add_horsegroup_services.horsegrouplistbypage(
                                token, pagenum,searchQuery).then((response) {
                              pd.dismiss();
                              setState(() {
                                print(response);
                                load_list = json.decode(response);
                                group_list = load_list['response'];
                                print(group_list);
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
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return Utils.check_connectivity().then((result){
              if(result){
                Add_horsegroup_services.horsegrouplist(token).then((respons){
                  // print(response.length.toString());
                  if(respons!=null){
                    setState(() {
                      //var parsedjson = jsonDecode(response);
                      load_list  = jsonDecode(respons);
                      group_list = load_list['response'];
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
                      //print(group_list['createdBy']);
                    });
                  }
                });
              }else{
                print("network not available");
              }
            });
          },
          child: ListView.builder(itemCount:group_list!=null?group_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => update_horse(prefs.get('token'),group_list[index])));
                    },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        Add_horsegroup_services.horsegroupvisibilty(token, group_list[index]['id']).then((response){
                          //replytile.removeWhere((item) => item.id == group_list[index]['horseId']);
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
                    //title: Text("abc"),
                    //leading: Image.asset("assets/horse_icon.png", fit: BoxFit.cover),
                    title: Text(group_list!=null?group_list[index]['name']:'Empty'),
                    subtitle: Text(group_list!=null?"Comment: "+group_list[index]['comments'].toString():''),
                    //leading: Image.asset("Assets/horses_icon.png"),
                   trailing: Text(group_list[index]['isDynamic'] == true ?"Dynamic: "+"Yes":"No"),
                    onTap: (){
                      print(group_list[index]);
//                      print(group_list[index]['isActive']);
//                      print(group_list[index]['isDynamic']);
                      //prefs = await SharedPreferences.getInstance();
                      if(group_list[index]['isActive'] == true) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HorseListInGroup(token, group_list[index])));
                      }
                    },
                  ),

                  secondaryActions: <Widget>[

                  ],
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
            const Text('Horse Group'),
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
        Add_horsegroup_services.horsegrouplistbypage(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(group_list!=null){
                group_list.clear();
              }
              load_list=json.decode(response);
              group_list = load_list['response'];
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_HorseGroup(token)),)

        ),


      )
    ];
  }

}