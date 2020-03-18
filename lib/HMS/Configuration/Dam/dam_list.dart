import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Breeds/add_breed.dart';
import 'package:horse_management/HMS/Configuration/Breeds/breeds_json.dart';
import 'package:horse_management/HMS/Configuration/Breeds/update_breed.dart';
import 'package:horse_management/HMS/Configuration/Dam/add_dam.dart';
import 'package:horse_management/HMS/Configuration/Dam/dam_json.dart';
import 'package:horse_management/HMS/Configuration/Dam/update_dam.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';



class dam_list extends StatefulWidget{
  String token;
  dam_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dam_list(token);
  }
}

class _dam_list extends State<dam_list>{
  String token;
  _dam_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var dam_lists;

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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_dam(token)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Dam"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              DamServices.getDam(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    dam_lists=json.decode(response);
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
          child: ListView.builder(itemCount:dam_lists!=null?dam_lists.length:temp.length,itemBuilder: (context,int index){
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
                          print(dam_lists[index]);
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_dam(token,dam_lists[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          BreedsServices.changeBreedsVisibility(token, dam_lists[index]['horseId']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                dam_lists.removeAt(index);
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
                      title: Text(dam_lists!=null?dam_lists[index]['name']:''),
                      // subtitle: Text(costcenter_lists!=null?costcenter_lists[index]['description']:''),
                      //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>currency_lists(token,currency_lists[index])));
                      },
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