import 'dart:convert';
import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/All_Horses_data/services/incomeExpense_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'income_and_expenses.dart';
import 'update_income_expense.dart';



class income_expense_list extends StatefulWidget{
  var list;
  int horseId;
  String token;


  income_expense_list ( this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _incomeExpense_list_state(token);
  }

}
class _incomeExpense_list_state extends State<income_expense_list>{
  var list,incomelist, load_list ,pagelist,pageloadlist;

  int horseId;String token;
  var temp=['',''];
  int pagenum = 1;
  int total_page;
  SharedPreferences prefs;
  var _isSearching=false;
  TextEditingController _searchQuery;
  String searchQuery = "";
  var isVisible=false,isPagination=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  _incomeExpense_list_state (this.token);


  @override
  void initState () {
    _searchQuery =TextEditingController();
//    WidgetsBinding.instance
//        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });


    Utils.check_connectivity().then((result){
      if(result) {
        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
        pd.show();
        income_expense_services.income_expenselist(token).then((
            response) {
          pd.dismiss();
          setState(() {
            print(response);
            load_list = json.decode(response);
            list = load_list['response'];
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
          });
        });
      }else
       Flushbar(message: "Networks error",duration: Duration(seconds: 3),backgroundColor: Colors.red,).show(context);
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
//          title: Text("Income & Expense "),
//
//          actions: <Widget>[
//
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () async{
//              prefs= await SharedPreferences.getInstance();
//              Navigator.push(context, MaterialPageRoute(builder: (context) => add_IncomeExpense(prefs.get('token'))),);
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
                    income_expense_services.income_expenselistbypage(token, pagenum,searchQuery).then((response) {
                          pd.dismiss();
                      setState(() {
                        print(response);
                        load_list= json.decode(response);
                        list = load_list['response'];
                        print(list);
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
                        income_expense_services.income_expenselistbypage(
                            token, pagenum,searchQuery).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            list = load_list['response'];
                            print(list);
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
                income_expense_services.income_expenselistbypage(
                    token, pagenum,searchQuery).then((response) {
                  setState(() {
                    print(response);
                    load_list = json.decode(response);
                    list = load_list['response'];
                    total_page=load_list['totalPages'];
                    if(total_page == 1 || total_page == -2147483648){
                      print("init state page = 1");
                        isPagination = false;
                    }else{
                      print("init state multi page ");
                        isPagination = true;
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
          child: ListView.builder(itemCount:list!=null?list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(onTap: ()async{
                      prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>update_IncomeExpense(list[index],prefs.get('token'),prefs.get('createdBy'))));

                    },color: Colors.blue,icon: Icons.border_color,caption: 'update',),
                    IconSlideAction(
                      icon: Icons.visibility_off,
                      color: Colors.red,
                      caption: 'Hide',
                      onTap: () async {
                        income_expense_services.incomevisibilty(token, list[index]['id']).then((response){
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
                  child: ExpansionTile(
            //['categoryName']['name']
                    title: Text(list != null ? list[index]['horseName']['name']:""),
                    subtitle: Text(list != null ? "Account: "+list[index]['categoryName']['name']:""),
                    trailing: Text(list != null ? "Date: "+list[index]['date'].toString().substring(0,10):""),
                  // leading: Text(list != null ? 'Amount '+list[index]['amount'].toString():""),
                    children: <Widget>[

                  Divider(),

                  ListTile(
                    title: Text("Amount"),
                    trailing: Text(list != null ? list[index]['amount'].toString():""),
                  ),

                    ],


                  ),
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
            const Text('Income & Expense'),
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
        income_expense_services.income_expenselistbypage(token,pagenum,searchQuery).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              if(load_list!=null){
                load_list.clear();
              }
              if(list!=null){
                list.clear();
              }
              load_list=json.decode(response);
              list = load_list['response'];
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
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => add_IncomeExpense(token)),)

        ),


      )
    ];
  }

}
