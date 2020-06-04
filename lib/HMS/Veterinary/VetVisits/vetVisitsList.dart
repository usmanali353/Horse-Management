import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_management/HMS/Diet/add_Diet.dart';
import 'package:horse_management/HMS/Diet/diet_services.dart';
import 'package:horse_management/HMS/Training/training_plans.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/addVetVisits.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/vet_visit_details.dart';
import 'package:horse_management/HMS/Veterinary/VetVisits/veterniaryServices.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class vetVisitList extends StatefulWidget{
  String token;

  vetVisitList(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return vetVisitListState(token);
  }

}
class vetVisitListState extends State<vetVisitList>{
  String token;
  var vetvisits_list=[], load_list, pagelist, pageloadlist;
  int pagenum = 1;
  int total_page;
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vet Visits"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => addVetVisits(token)),);
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
                    //backgroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    splashColor: Colors.red,
                    child: Icon(Icons.arrow_back, color: Colors.teal, size: 30,),heroTag: "btn2", onPressed: () {
                  if(load_list['hasPrevious'] == true && pagenum >= 1 ) {
                    Utils.check_connectivity().then((result){
                      if(result) {
                        ProgressDialog pd = ProgressDialog(context, isDismissible: true, type: ProgressDialogType.Normal);
                        pd.show();
                        vieterniaryServices.vetvisit_by_page(token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list= json.decode(response);
                            vetvisits_list = load_list['response'];
                            print(vetvisits_list);
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
                        vieterniaryServices.vetvisit_by_page(
                            token, pagenum).then((response) {
                          pd.dismiss();
                          setState(() {
                            print(response);
                            load_list = json.decode(response);
                            vetvisits_list = load_list['response'];
                            print(vetvisits_list);
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
//      floatingActionButton: FloatingActionButton(
//        child: Icon(
//          Icons.add,
//          color: Colors.white,
//        ),
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>addVetVisits(token)));
//        },
//
//      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              vieterniaryServices.getVetVisits(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    vetvisits_list = load_list['response'];
                    total_page=load_list['totalPages'];
                    print(total_page);
                  });

                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Vet Visits List Not Found"),
                  ));
                  setState(() {
                    isvisible=false;
                  });
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network not Available"),
              ));
            }
          });
        },
        child: Visibility(
          visible: isvisible,
          child: Scrollbar(
            child: ListView.builder(itemCount:vetvisits_list!=null?vetvisits_list.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              vieterniaryServices.changeVetVisitsVisibility(token, vetvisits_list[index]['vetVisitId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    vetvisits_list.removeAt(index);
                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Failed'),
                                  ));
                                }
                              });
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Network not Available"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          });

                        },
                      ),
                      IconSlideAction(
                        icon: Icons.edit,
                        color: Colors.blue,
                        caption: 'Update',
                        onTap: () async {
                          // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_training(token,training_list[index])));
                        },
                      ),
                    ],
                    child: ListTile(
                      enabled: vetvisits_list[index]['isActive'],
                      leading: FaIcon(FontAwesomeIcons.userMd, color: Colors.blue.shade400, size: 35,),
                      trailing:Text(vetvisits_list[index]['visitDate']!=null?vetvisits_list[index]['visitDate'].toString().substring(0,10):''),
                      title: Text(vetvisits_list!=null?vetvisits_list[index]['horseName']['name']:''),
                      //leading: Icon(Icons.local_hospital,size: 40,color: Colors.teal,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => vet_visit_details_page(vetvisits_list[index])));

                      },
                    ),


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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  vetVisitListState(this.token);

}