import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Contacts/ContactDashboard.dart';
import 'package:horse_management/HMS/Contacts/add_contacts.dart';
import 'package:horse_management/HMS/Contacts/contact_detail.dart';
import 'package:horse_management/HMS/Contacts/update_contacts.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils.dart';
class contacts_list extends StatefulWidget{
  String token;

  contacts_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _contacts_list_state(token);
  }

}
class _contacts_list_state extends State<contacts_list>{
  String token;
  var horse_list;
  var contacts_list=[], load_list;
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>add_contacts(token)));
        },
       child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return  Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              network_operations.get_all_contacts(token).then((response){
                pd.dismiss();
                print(response);
                if(response!=null){

                  setState(() {
                    isvisible=true;
                    load_list=json.decode(response);
                    contacts_list = load_list['response'];
                  });

                }else{
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
            child: ListView.builder(itemCount:contacts_list!=null?contacts_list.length:temp.length,itemBuilder: (context,int index){
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
                              network_operations.change_contact_visibility(token, contacts_list[index]['contactId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_contacts(token,contacts_list[index])));
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(contacts_list!=null?contacts_list[index]['name']:''),
                     // trailing: Text(contacts_list!=null?contacts_list[index]['startDate']:''),
                    //  subtitle: Text(already_trained_list!=null?get_training_type_by_id(already_trained_list[index]['trainingType']):''),
                      leading: Icon(Icons.phone,size: 40,color: Colors.teal,),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactDashboard(token,contacts_list[index])));
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

  _contacts_list_state(this.token);

}