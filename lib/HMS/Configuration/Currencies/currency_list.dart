import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Currencies/update_currency.dart';
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
  var currency_lists;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_currency(token)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Currencies"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              CurrenciesServices.getCurrency(token).then((response){
                if(response!=null){
                  setState(() {
                    currency_lists=json.decode(response);
                    isVisible=true;
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
        },
        child: Visibility(
          visible: isVisible,
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
                    child: ListTile(
                      title: Text(currency_lists!=null?currency_lists[index]['name']:''),
                      // subtitle: Text(flushes_list!=null?flushes_list[index]['vetName']['contactName']['name']:''),
                      //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
//                      onTap: (){
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>currency_lists(token,currency_lists[index])));
//                      },
                    )
                ),
                Divider(),
              ],
            );
          }),
        ),
      ),
    );
  }


}