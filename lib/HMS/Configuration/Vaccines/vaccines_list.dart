import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/add_vaccines.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/update_vaccines.dart';
import 'package:horse_management/HMS/Configuration/Vaccines/vaccines_json.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';



class vaccines_list extends StatefulWidget{
  String token;
  vaccines_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vaccines_list(token);
  }
}

class _vaccines_list extends State<vaccines_list>{
  String token;
  _vaccines_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var vaccine_lists;

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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_vaccines(token)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Vaccines"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              VaccinesServices.getVaccine(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    vaccine_lists=json.decode(response);
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
          child: ListView.builder(itemCount:vaccine_lists!=null?vaccine_lists.length:temp.length,itemBuilder: (context,int index){
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
                          print(vaccine_lists[index]);
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_vaccines(token,vaccine_lists[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          VaccinesServices.changeVaccinesVisibility(token, vaccine_lists[index]['id']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                vaccine_lists.removeAt(index);
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
                      title: Text(vaccine_lists!=null?vaccine_lists[index]['name']:''),
                      //subtitle: Text(category_lists!=null?category_lists[index]['description']:''),
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