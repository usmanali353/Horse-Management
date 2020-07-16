import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
class show_horses_in_paddock extends StatefulWidget{
  String token;
  var paddock_data;
  show_horses_in_paddock(this.token,this.paddock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _show_horses_in_paddock(token,paddock_data);
  }

}
class _show_horses_in_paddock extends State<show_horses_in_paddock>{
  _show_horses_in_paddock(this.token,this.paddock_data);
  String token;
  var paddock_data;
  var horse_list, load_list, pagelist, pageloadlist;
  var already_trained_list=[];
  var temp=['',''];
  bool isVisible=false;
  var _isSearching=false, isPagination=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  List<dynamic> filteredCategory=[], listRecord;
  int searchPageNum,totalSearchPages;
  static final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
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
        PaddockServices.getPaddockDetails(token, paddock_data['id'],pagenum, searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              //var parsedjson = jsonDecode(response);
              load_list  = jsonDecode(response);
              horse_list = load_list['response'];
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
                          PaddockServices.getPaddockDetails(token, paddock_data['id'],pagenum, searchQuery).then((response) {
                            pd.dismiss();
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
                          PaddockServices.getPaddockDetails(token, paddock_data['id'],pagenum, searchQuery).then((response) {
                            pd.dismiss();
                            setState(() {
                              //print(response);
                              load_list = json.decode(response);
                              horse_list= load_list['response'];
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
              PaddockServices.getPaddockDetails(token, paddock_data['id'],pagenum, searchQuery).then((response) {
                setState(() {
                  print(response);
                  load_list = json.decode(response);
                  horse_list = load_list['response'];
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
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:horse_list!=null?horse_list.length:temp.length,itemBuilder: (context,int index){
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
                            PaddockServices.delete_horses_from_paddock(token, horse_list[index]['paddockId']).then((response){
                              pd.dismiss();
                              if(response!=null){
//
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
                              }else{
//
                              }
                            });
                          }else{

                          }
                        });

                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(horse_list!=null?horse_list[index]['horseName']['name']:''),
//                    trailing: Text(already_trained_list!=null?already_trained_list[index]['startDate'].replaceAll("T00:00:00",''):''),
//                    subtitle: Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                    leading: Image.asset("assets/horse_icon.png"),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=>training_details_page(already_trained_list[index],'')));
//                    },
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
            const Text('Horse in Paddock'),
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
        PaddockServices.getPaddockDetails(token, paddock_data['id'],pagenum, searchQuery).then((response){
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
//        child: InkWell(child: Icon(Icons.add),
//            onTap: () =>
//                Navigator.push(context, MaterialPageRoute(
//                    builder: (context) =>add_paddock(token)),)
//
//        ),


      )
    ];
  }

//  String get_training_type_by_id(int id){
//    var training_type_name;
//    for (int i=0;i<already_trained_list.length;i++){
//      if(id==1){
//        training_type_name="Simple";
//      }else if(id==2){
//        training_type_name='Endurance';
//      }else if(id==3){
//        training_type_name="Customized";
//      }else if(id==4){
//        training_type_name="Speed";
//      }
//    }
//    return training_type_name;
//  }
}