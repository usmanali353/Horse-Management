import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/breeding_control_form.dart';
import 'package:horse_management/HMS/Breeding/BreedingControl/update_breeding_control.dart';
import 'package:horse_management/Network_Operations.dart';
import '../../../Utils.dart';
class breeding_control_list extends StatefulWidget{
  String token;
  breeding_control_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_control_list_state(token);
  }

}
class _breeding_control_list_state extends State<breeding_control_list>{
  String token;
  var horse_list;
  var b_c_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Breeding Controls")),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_breeding_control(token)));
          },

        ),
        body: Column(
          children: <Widget>[
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    network_operations.get_all_breeding_controls(token).then((response){
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          b_c_list=json.decode(response);
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("List Not Found"),
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
                child: ListView.builder(shrinkWrap:true,itemCount:b_c_list!=null?b_c_list.length:temp.length,itemBuilder: (context,int index){
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding_control(token,b_c_list[index])));
                            },
                          ),
                        ],
                        actions: <Widget>[
                          IconSlideAction(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            caption: 'Hide',
                            onTap: () async {
                              network_operations.change_breeding_control_visibility(token, b_c_list[index]['breedingControlId']).then((response){
                                print(response);
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    b_c_list.removeAt(index);
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
                          trailing:Text(b_c_list!=null?b_c_list[index]['date'].toString():''),
                          title: Text(b_c_list!=null?b_c_list[index]['horseName']['name']:''),
                          subtitle: Text(b_c_list!=null?get_check_method_by_id(b_c_list[index]['check_Method']):''),
                          leading: Icon(Icons.pets,size: 40,color: Colors.teal,),
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
String get_check_method_by_id(int id){
    var check_method;
    if(b_c_list!=null&&id!=null){
      if(id==1){
          check_method="Palpation";
      }else if(id==2){
          check_method="Ultrasound";
      }else if(id==3){
          check_method="Visual Observation";
      }else{
          check_method="Blood Test";
      }
    }
    return check_method;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  _breeding_control_list_state(this.token);

}