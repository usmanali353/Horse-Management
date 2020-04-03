import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Breeding/EmbryoStock/embryo_stock_details.dart';
import 'package:horse_management/HMS/Breeding/EmbryoStock/update_embryo_stock.dart';

import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'add_embryo_stock.dart';
import 'embryo_stock_json.dart';


class embryo_stock_list extends StatefulWidget{
  String token;

  embryo_stock_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _embryo_stock_list(token);
  }

}
class _embryo_stock_list extends State< embryo_stock_list>{
  String token;
  _embryo_stock_list(this.token);
  bool isVisible=false;
  var temp=['','',''];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var embryo_list;

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
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_embryo_stock(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Embryo Stock"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_embryo_stock(token)),);
            },
          )
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//           // onPressed: () => _generatePdfAndView(context),
//          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              EmbryoStockServices.get_embryo_stock(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    embryo_list=json.decode(response);
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
          child: ListView.builder(itemCount:embryo_list!=null?embryo_list.length:temp.length,itemBuilder: (context,int index){
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_embryo_stock(token,embryo_list[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          EmbryoStockServices.change_embryo_stock_visibility(token, embryo_list[index]['embryoStockId']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                embryo_list.removeAt(index);
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
                        title: Text(embryo_list!=null?embryo_list[index]['horseName']['name']:''),
                        subtitle: Text(embryo_list!=null?embryo_list[index]['sireName']['name']:''),
                        //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => embryo_stock_details_page(embryo_list[index])));
                        },
                      ),
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