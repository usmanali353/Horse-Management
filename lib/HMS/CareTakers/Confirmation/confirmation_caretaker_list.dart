import 'package:flutter/material.dart';
import 'package:horse_management/HMS/CareTakers/Confirmation/ConfirmationCaretaker.dart';
import 'package:horse_management/HMS/Configuration/Sire/add_sire.dart';
import 'package:horse_management/HMS/Configuration/Sire/sire_json.dart';
import 'package:horse_management/HMS/Configuration/Sire/update_sire.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Paddock/add_paddock_form.dart';
import 'package:horse_management/HMS/Paddock/padocks_json.dart';
import 'package:horse_management/HMS/Paddock/show_horses_in_paddock_list.dart';
import 'package:horse_management/HMS/Paddock/update_paddock.dart';
import 'package:horse_management/HMS/Veterinary/Confirmation/add_confirmation_form.dart';
import 'package:horse_management/HMS/Veterinary/Confirmation/confirmation_json.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';



class confirmation_list extends StatefulWidget{
  String token;
  confirmation_list(this.token);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _confirmation_list(token);
  }
}

class _confirmation_list extends State<confirmation_list>{
  String token;
  _confirmation_list(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var confirmation_lists, load_list;

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
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_paddock(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Confirmation"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_confirmation(token)),);
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
              ConfirmationCareTakerServices.get_confirmation_caretaker(token).then((response){
                print(response);
                pd.dismiss();
                if(response!=null){
                  setState(() {
                   // print(confirmation_lists['horseName']['name'].toString());
                    load_list=json.decode(response);
                    confirmation_lists = load_list['response'];
                    print(confirmation_lists);
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
          child: ListView.builder(itemCount:confirmation_lists!=null?confirmation_lists.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.edit,
//                        color: Colors.blue,
//                        caption: 'Update',
//                        onTap: () async {
//                          print(confirmation_lists[index]);
//                         // Navigator.push(context,MaterialPageRoute(builder: (context)=>update_paddock(token,paddock_lists[index])));
//                        },
//                      ),
                    ],
                    actions: <Widget>[
//                      IconSlideAction(
//                        icon: Icons.visibility_off,
//                        color: Colors.red,
//                        caption: 'Hide',
//                        onTap: () async {
//                          ConfirmationServices.confirmationvisibilty(token, confirmation_lists[index]['conformationId']).then((response){
//                            print(response);
//                            if(response!=null){
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.green ,
//                                content: Text('Visibility Changed'),
//                              ));
//                              setState(() {
//                                confirmation_lists.removeAt(index);
//                              });
//
//                            }else{
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                backgroundColor:Colors.red ,
//                                content: Text('Failed'),
//                              ));
//                            }
//                          });
//                        },
//                      ),
                      IconSlideAction(
                        icon: Icons.timer,
                        color: Colors.deepOrange,
                        caption: 'Start',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              ConfirmationCareTakerServices.start_confirmation(token, confirmation_lists[index]['conformationId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Process Started'),
                                  ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Process Failed'),
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
                        icon: Icons.done_all,
                        color: Colors.green,
                        caption: 'Complete',
                        onTap: () async {
                          Utils.check_connectivity().then((result){
                            if(result){
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              ConfirmationCareTakerServices.complete_confirmation(token, confirmation_lists[index]['conformationId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Process Complete'),
                                  ));
//                                  setState(() {
//                                    control_list.removeAt(index);
//                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Process Failed'),
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
                    ],
                    child: FadeAnimation(2.0,
                      ListTile(
                        title: Text(confirmation_lists!=null?confirmation_lists[index]['horseName']['name']:''),
                        //title: Text("data"),
                        subtitle: Text(confirmation_lists!=null?confirmation_lists[index]['vetName']['contactName']['name'].toString():''),
                       trailing: Text(confirmation_lists!=null?confirmation_lists[index]['date'].toString().substring(0,10) :''),
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