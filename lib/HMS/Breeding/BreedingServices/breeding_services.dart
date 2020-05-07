import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Breeding/BreedingServices/breeding_services_details.dart';
import 'package:horse_management/HMS/Breeding/BreedingServices/update_breeding_services.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/Network_Operations.dart';
import '../../../Utils.dart';
import 'breeding_service_form.dart';
import 'utils/breeding_services_json.dart';


class breeding_services extends StatefulWidget{
  String token;
  breeding_services(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_services_State(token);
  }

}

class _breeding_services_State extends State<breeding_services>{
  String token;
  _breeding_services_State(this.token);
  bool isVisible=false;
  var temp=['','',];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var breeding_services_list, load_list;

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
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>breeding_service_form(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Breeding Services"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_service_form(token)),);
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
              BreedingServicesJson.get_breeding_services(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    load_list=json.decode(response);
                    breeding_services_list = load_list['response'];
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
          child: ListView.builder(itemCount:breeding_services_list!=null?breeding_services_list.length:temp.length,itemBuilder: (context,int index){
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding(token,breeding_services_list[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          BreedingServicesJson. change_breeding_services_visibility(token, breeding_services_list[index]['embryoStockId']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                breeding_services_list.removeAt(index);
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
                        title: Text(breeding_services_list!=null?breeding_services_list[index]['horseName']['name']:''),
                        subtitle: Text(breeding_services_list!=null?breeding_services_list[index]['sireName']['name'].toString():''),
                        trailing: Text(breeding_services_list!=null?breeding_services_list[index]['serviceDate'].toString().replaceAll("T00:00:00", ''):'') ,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_services_details_page(breeding_services_list[index], get_check_service_by_id(breeding_services_list[index]['serviceType']))));
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>update_breeding(token,breeding_services_list[index])));
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

  String get_check_service_by_id(int id){
    var service_type;
    if(breeding_services_list!=null&&id!=null){
      if(id==1){
        service_type="Direct Service";
      }else if(id==2){
        service_type="Assisted Service";
      }else if(id==3){
        service_type="Artificial Insemination";
      }else{
        service_type="Embryo Transfer";
      }
    }
    return service_type;
  }
}

