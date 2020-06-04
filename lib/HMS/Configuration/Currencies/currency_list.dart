import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Configuration/Currencies/update_currency.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_currency.dart';
import 'currencies_json.dart';



class currency_list extends StatefulWidget{
  String token;
  currency_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _currency_list(token);
  }
}

class _currency_list extends State<currency_list>{
  String token;
  _currency_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var currency_lists, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var currency_response;
  List<String> currency=[];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());

    CurrenciesServices.getCurrencyDropdown(token).then((response){
      if(response!=null){
        setState(() {
          currency_response=json.decode(response);
          //currency_loaded=true;
          for(int i=0;i<currency_response['currencySymbolsDropDown'].length;i++)
            currency.add(currency_response['currencySymbolsDropDown'][i]['name']);
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_currency(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Currencies"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_currency(token)),);
            },
          )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Padding(
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
                        CurrenciesServices.currencies_by_page(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            currency_lists = load_list['response'];
                            print(currency_lists);
                          });
                        });
                      }else
                        print("Network Not Available");
                    });
                  }
                  else{
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
                        CurrenciesServices.currencies_by_page(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            currency_lists = load_list['response'];
                            print(currency_lists);
                          });
                        });
                      }else
                        print("Network Not Available");
                    });
                  }
                  else{
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              CurrenciesServices.getCurrency(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    currency_lists = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(total_page);
                    isVisible=true;
                  });

                }else{
                  setState(() {
                    isVisible=false;
                  });
//                  Scaffold.of(context).showSnackBar(SnackBar(
//                    backgroundColor: Colors.red,
//                    content: Text("List Not Available"),
//                  ));
                }
              });
            }else{
//              Scaffold.of(context).showSnackBar(SnackBar(
//                backgroundColor: Colors.red,
//                content: Text("Network Not Available"),
//              ));
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:currency_lists!=null?currency_lists.length:temp.length,itemBuilder: (context,int index){
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
                            print(currency_lists[index]);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>update_currency(token,currency_lists[index])));
                          },
                        ),
                      ],
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.visibility_off,
                          color: Colors.red,
                          caption: 'Hide',
                          onTap: () async {
                            CurrenciesServices.changeCurrencyVisibility(token, currency_lists[index]['id']).then((response){
                              print(response);
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  currency_lists.removeAt(index);
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
                          enabled: currency_lists[index]['isActive'],
                          leading: FaIcon(FontAwesomeIcons.coins, color: Color(0xFFd4af37), size: 40,),
                          title: Text(currency_lists!=null?currency_lists[index]['name'].toString():''),
                           subtitle: Text(currency_lists!=null?currency_lists[index]['symbol'].toString():''),
                          //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
//                      onTap: (){
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>currency_lists(token,currency_lists[index])));
//                      },
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


}