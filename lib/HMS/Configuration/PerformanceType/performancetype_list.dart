import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Locations/location_json.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/add_performancetype.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/performancetype_json.dart';
import 'package:horse_management/HMS/Configuration/PerformanceType/update_performancetype.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';




class performancetype_list extends StatefulWidget{
  String token;
  performancetype_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _performancetype_list(token);
  }
}

class _performancetype_list extends State<performancetype_list>{
  String token;
  _performancetype_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var type_lists, load_list;

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
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_performancetype(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Perfomance Types"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_performancetype(token)),);
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
              PerformanceTypesServices.getPerformanceType(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    type_lists = load_list['response'];
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
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network Not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:type_lists!=null?type_lists.length:temp.length,itemBuilder: (context,int index){
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
                            print(type_lists[index]);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>update_performancetype(token,type_lists[index])));
                          },
                        ),
                      ],
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.visibility_off,
                          color: Colors.red,
                          caption: 'Hide',
                          onTap: () async {
                            LocationServices.changeLocationVisibility(token, type_lists[index]['performanceId']).then((response){
                              print(response);
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor:Colors.green ,
                                  content: Text('Visibility Changed'),
                                ));
                                setState(() {
                                  type_lists.removeAt(index);
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
                          title: Text(type_lists!=null?type_lists[index]['name']:''),
                          // subtitle: Text(costcenter_lists!=null?costcenter_lists[index]['description']:''),
                          //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>currency_lists(token,currency_lists[index])));
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
      ),
    );
  }


}