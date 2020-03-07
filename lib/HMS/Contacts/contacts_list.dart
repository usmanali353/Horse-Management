import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:horse_management/Network_Operations.dart';

import '../../Utils.dart';
import 'add_contacts.dart';
import 'contact_detail.dart';

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
  var contacts_list=[];
  var temp=['',''];
  bool isvisible=false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("HMS.Contacts")),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_contacts(token)));
          },

        ),
        body: Column(
          children: <Widget>[
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    network_operations.get_all_contacts(token).then((response){
                      print(response);
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          contacts_list=json.decode(response);
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("HMS.Contacts List Not Found"),
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
                child: ListView.builder(itemCount:contacts_list!=null?contacts_list.length:temp.length,itemBuilder: (context,int index){
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
                            //  Navigator.push(context,MaterialPageRoute(builder: (context)=>update_contacts(token,contacts_list[index])));
                            },
                          ),
                        ],
                        actions: <Widget>[
                          IconSlideAction(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            caption: 'Hide',
                            onTap: () async {
                              network_operations.change_contact_visibility(token, contacts_list[index]['contactId']).then((response){
                                print(response);
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    contacts_list.removeAt(index);
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
                         title: Text(contacts_list!=null?contacts_list[index]['contactName']['name']:''),
                          leading: Icon(Icons.phone,size: 40,color: Colors.teal,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>contacts_details_page(contacts_list[index])));
                          },
                        ),


                      ),
                      Divider(),
                    ],

                  );

                }),
              ),
            ),
          ],
        )
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