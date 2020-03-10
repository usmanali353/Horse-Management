import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/HMS/Inventory/services_inventory.dart';
import 'package:horse_management/Model/sqlite_helper.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class addInventory extends StatefulWidget{
  String token;

  addInventory(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_training_state(token);
  }
}



class _add_training_state extends State<addInventory>{
  String token;
  _add_training_state(this.token);
  String selected_itemtype,selected_stock,selected_status ;
  DateTime enter_date = DateTime.now();
  DateTime dueDate =DateTime.now();
  String _excerciseplan;
  int selected_itemtype_id=0,selected_stock_id=0,selected_status_type=0,toberepaire,outofranch;
  sqlite_helper local_db;

  List<String> itemtype=[],stock=[],status=[];
  var itemtyperes,stockRes,statusRes;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
  TextEditingController name,code,serial,batch,location,quantity,comment;
  bool _isvisible=false;
  bool othersvisibility = true;
  //bool horses_loaded=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    this.name=TextEditingController();
    this.code=TextEditingController();
    this.serial=TextEditingController();
    this.batch=TextEditingController();
    this.location=TextEditingController();
    this.quantity=TextEditingController();
    this.comment=TextEditingController();
    local_db=sqlite_helper();

    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        inventoryServices.itemTypedropdown(token).then((response){
          pd.dismiss();
          if(response!=null){
            print(response);
            setState(() {
              itemtyperes=json.decode(response);
              print(itemtyperes);
              for(int i=0;i<itemtyperes.length;i++)
                itemtype.add(itemtyperes[i]['name']);
              print(itemtype);

            });
          }
        });
        inventoryServices.stockdropdown(token).then((response){
          pd.dismiss();
          if(response!=null){
            print(response);
            setState(() {
              stockRes=json.decode(response);
              for(int i=0;i<stockRes.length;i++)
                stock.add(stockRes[i]['name']);

            });
          }
        });
        inventoryServices.itemStatusropdown(token).then((response){
          pd.dismiss();
          if(response!=null){
            print(response);
            setState(() {
              statusRes=json.decode(response);
              for(int i=0;i<statusRes.length;i++)
                status.add(statusRes[i]['name']);

            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Add Trainings"),),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: name,
                          attribute: "name",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: code,
                          attribute: "Training Center",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Training Center",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FormBuilderDropdown(
                          attribute: "Training Type",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Select Training"),
                          items: itemtype.map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          onChanged: (value){
                            setState(() {
                              this.selected_itemtype_id=itemtype.indexOf(value)+1;
                              this.selected_itemtype=value;
                              if(value=="Tools" || value =="Laboratory"){
                                setState(() {
                                  _isvisible=true;
                                  othersvisibility = false;
                                });
                              }else{
                                setState(() {
                                  _isvisible=false;
                                  othersvisibility = true;
                                });
                              }
                            });
                          },
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Item Type",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FormBuilderTextField(
                          controller: location,
                          attribute: "location",
                          decoration: InputDecoration(labelText: "Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child:FormBuilderDateTimePicker(
                          attribute: "enter Date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          format: DateFormat("MM-dd-yyyy"),
                          decoration: InputDecoration(labelText: "Enter Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                          onChanged: (value){
                            setState(() {
                              this.enter_date=value;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: othersvisibility,
                        child: Padding(
                          padding: EdgeInsets.only(top:16,left: 16,right: 16),
                          child:FormBuilderDateTimePicker(
                            attribute: "due Date",
                            style: Theme.of(context).textTheme.body1,
                            inputType: InputType.date,
                            validators: [FormBuilderValidators.required()],
                            format: DateFormat("MM-dd-yyyy"),
                            decoration: InputDecoration(labelText: "Due Date",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),),
                            onChanged: (value){
                              setState(() {
                                this.dueDate=value;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right:16,bottom: 16),
                        child: Visibility(
                          visible: _isvisible,
                          child:FormBuilderDropdown(
                            attribute: "status",
                            hint: Text("select Status"),
                            items: status!=null?status.map((plans)=>DropdownMenuItem(
                              child: Text(plans),
                              value: plans,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),

                            onChanged: (value){
                              setState(() {
                                this.selected_status=value;
                                this.selected_status_type=status.indexOf(value);
                              });
                            },
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Status",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          visible: _isvisible,
                          child: FormBuilderDropdown(
                            attribute: "repaire",
                            hint: Text("Select"),
                            items: ["Yes","No"].map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList().map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "To Be Repaired",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  toberepaire = 1;
                                else if(value == "No")
                                  toberepaire = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          visible: _isvisible,
                          child: FormBuilderDropdown(

                            attribute: "outofranch",
                            hint: Text("Select"),
                            items: ["Yes","No"].map((trainer)=>DropdownMenuItem(
                              child: Text(trainer),
                              value: trainer,
                            )).toList().map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Out Of Ranch",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                if(value == "Yes")
                                  outofranch = 1;
                                else if(value == "No")
                                  outofranch = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      Visibility(
                       visible: _isvisible,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: FormBuilderTextField(
                            controller: quantity,
                            attribute: "quantity",

                            decoration: InputDecoration(labelText: "Quantity",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Visibility(
                          visible: othersvisibility,
                          child: FormBuilderDropdown(
                            attribute: "stock",
                            hint: Text("stock"),
                            items:stock!=null?stock.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Stock",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_stock=value;
                                this.selected_stock_id=stock.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                      
                      Visibility(
                        visible: othersvisibility,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: FormBuilderTextField(
                            controller: serial,
                            attribute: "serial",
                            decoration: InputDecoration(labelText: "Serial",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                      ),
                      Visibility(
                        visible: othersvisibility,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16,right: 16),
                          child: FormBuilderTextField(
                            controller: batch,
                            attribute: "batch",
                            decoration: InputDecoration(labelText: "Batch",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16,right: 16),
                        child: FormBuilderTextField(
                          controller: comment,
                          attribute: "comment",
                          minLines: 5,
                          decoration: InputDecoration(labelText: "Comment",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                    child:Padding(
                      padding: const EdgeInsets.all(16),
                      child: add_training_button(fbKey: _fbKey, local_db: local_db, token: token, name: name,code: code,itemtypeid: selected_itemtype_id,location: location,
                        enterDate: enter_date, dueDate: dueDate,itemstatusid: selected_status_type,toberepaire: toberepaire,outofRanch: outofranch,stockid: selected_stock_id,serialNo: serial,batchNo: batch,quantity: quantity,),
                    )
                )
              ],
            )
          ],
        )
    );
  }

}

class add_training_button extends StatelessWidget {
  const add_training_button({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.local_db,
    this.token,
    this.name,
    this.code,
    this.itemtypeid,
    this.location,
    this.enterDate,
    this.dueDate,
    this.itemstatusid,
    this.toberepaire,
    this.outofRanch,
    this.stockid,
    this.serialNo,
    this.batchNo,this.quantity,
    this.comment,
  }) : _fbKey = fbKey, super(key: key);
  final int itemtypeid,stockid,itemstatusid,toberepaire,outofRanch;

  final String token;
  final GlobalKey<FormBuilderState> _fbKey;
  final sqlite_helper local_db;
  final DateTime enterDate;
  final DateTime dueDate;
  final TextEditingController name,code,location,serialNo,batchNo,quantity,comment;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.teal,
      onPressed: () {
        if (_fbKey.currentState.validate()) {
          Utils.check_connectivity().then((result){
            if(result){
              ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
              pd.show();
              inventoryServices.inventorySave(null, token, 0, name.text, itemtypeid, stockid, code.text, location.text, enterDate, dueDate, serialNo.text, batchNo.text, int.parse(quantity.text), itemstatusid, toberepaire, outofRanch, comment.text).then((response){
               pd.dismiss();
                print(response);
                if(response!=null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Training Added Sucessfully"),
                  ));
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Training not Added"),
                  ));
                }
              });
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Network not Available"),
              ));
              // local_db.create_training(Training(selected_horse,selected_trainer,'',training_center.text,Start_date.toString(),End_Date.toString(),target_date.toString(),excerciseplan,));
            }
          });

        }
      },
      child:Text("Add Training",style: TextStyle(color: Colors.white),),
    );
  }
}