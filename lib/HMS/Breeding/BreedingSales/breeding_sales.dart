import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Breeding/BreedingSales/breeding_sales_details.dart';
import 'package:horse_management/HMS/Breeding/BreedingSales/breeding_sales_json.dart';
import 'package:horse_management/HMS/Breeding/BreedingSales/update_breeding_sales.dart';
import 'package:horse_management/HMS/Breeding/BreedingServices/breeding_service_form.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';
import 'breeding_sales_form.dart';


class breeding_sales extends StatefulWidget{
  String token;
  breeding_sales(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _breeding_sales(token);
  }

}

class _breeding_sales extends State<breeding_sales>{
  String token;
  _breeding_sales(this.token);
  var temp=['','',''];
  bool isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var sales_list;


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
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>breeding_sales_form(token)));
//        },
//        child: Icon(Icons.add),
//      ),
      appBar: AppBar(
        title: Text("Breeding Sales"),
        actions: <Widget>[
          Center(child: Text("Add New",textScaleFactor: 1.3,)),
          IconButton(

            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_sales_form(token)),);
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
              BreedingSalesServices.get_breeding_sales(token).then((response){
                pd.dismiss();
                if(response!=null){
                  setState(() {
                    sales_list=json.decode(response);
                    isVisible=true;
                  });

                }else{
                  setState(() {
                    isVisible=false;
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Sales Not Available"),
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
          child: ListView.builder(itemCount:sales_list!=null?sales_list.length:temp.length,itemBuilder: (context,int index){
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
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>update_breeding_sales_form(token,sales_list[index])));
                        },
                      ),
                    ],
                    actions: <Widget>[
                      IconSlideAction(
                        icon: Icons.visibility_off,
                        color: Colors.red,
                        caption: 'Hide',
                        onTap: () async {
                          BreedingSalesServices.change_breeding_sales_visibility(token, sales_list[index]['id']).then((response){
                            print(response);
                            if(response!=null){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor:Colors.green ,
                                content: Text('Visibility Changed'),
                              ));
                              setState(() {
                                sales_list.removeAt(index);
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
                        title: Text(sales_list!=null?sales_list[index]['horseName']['name']:''),
                        // subtitle: Text(flushes_list!=null?flushes_list[index]['vetName']['contactName']['name']:''),
                        //trailing: Text(embryo_list!=null?embryo_list[index]['status']:''),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => breeding_sales_details_page(sales_list[index], get_status_by_id(sales_list[index]['status']))));

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

  String get_status_by_id(int id){
    var status_type;
    if(sales_list!=null&&id!=null){
      if(id==1){
        status_type="Sold";
      }else if(id==2){
        status_type="Shipped";
      }else if(id==3){
        status_type="Delivered";
      }else if(id==4){
        status_type="Pregnant";
      }else if(id==5){
        status_type="Empty";
      }else{
        status_type="Bleeding Report";
      }
    }
    return status_type;
  }
}

