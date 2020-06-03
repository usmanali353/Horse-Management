import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Configuration/Sire/add_sire.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_json.dart';
import 'package:horse_management/HMS/Configuration/Sire/update_sire.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';


class sire_list extends StatefulWidget{
  String token;
  sire_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sire_list(token);
  }
}

class _sire_list extends State<sire_list>{
  String token;
  _sire_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var sire_lists, load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;

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
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_sire(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Sire"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddSire(token)),);
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
                FloatingActionButton(child: Icon(Icons.arrow_back),heroTag: "btn2", onPressed: () {

                  if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        SireServices.sire_by_page(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            sire_lists = load_list['response'];
                            print(sire_lists);
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
                FloatingActionButton(child: Icon(Icons.arrow_forward),heroTag: "btn1", onPressed: () {
                  print(load_list['hasNext']);
                  if(load_list['hasNext'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        SireServices.sire_by_page(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            sire_lists = load_list['response'];
                            print(sire_lists);
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
              SireServices.getSire(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    sire_lists = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(total_page);
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
          child: ListView.builder(itemCount:sire_lists!=null?sire_lists.length:temp.length,itemBuilder: (context,int index){
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
                          print(sire_lists[index]);
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateSire(token,sire_lists[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          SireServices.changeSireVisibility(token, sire_lists[index]['horseId']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                sire_lists.removeAt(index);
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
                        title: Text(sire_lists!=null?sire_lists[index]['name']:''),
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
    );
  }


}