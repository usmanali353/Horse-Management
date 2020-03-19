import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'currencies_json.dart';



class update_currency extends StatefulWidget{
  String token;
   var specificcurrency;
  update_currency(this.token, this.specificcurrency);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _update_currency(token, specificcurrency);
  }
}


class _update_currency extends State<update_currency>{
  final token;
  var specificcurrency;
  _update_currency(this.token, this.specificcurrency);
  String selected_currency;
  int selected_currency_id=0;

  List<String> currency=[];
  var currency_response;
  //var training_types_list=['Simple','Endurance','Customized','Speed'];
//  bool _isvisible=false;
//  bool currency_loaded=false;
  var currency_name;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrenciesServices.getCurrencyDropdown(token).then((response){
      if(response!=null){
        setState(() {
          currency_response=json.decode(response);
          //currency_loaded=true;
          for(int i=0;i<currency_response['currencySymbolsDropDown'].length;i++)
            currency.add(currency_response['currencySymbolsDropDown'][i]['name']);
        });

      }else{
      }
    });
  }
  String get_currency_by_id(int id){
    var currency_name;
    if(specificcurrency!=null&&currency_response['currencySymbolsDropDown']!=null&&id!=null){
      for(int i=0;i<currency.length;i++){
        if(currency_response['currencySymbolsDropDown'][i]['id']==id){
          currency_name=currency_name['currencySymbolsDropDown'][i]['name'];
        }
      }
      return currency_name;
    }else
      return null;
  }


//  @override
//  void initState() {
//    super.initState();
//    setState(() {
//      CurrenciesServices.getCurrency(token).then((response){
//        if(response!=null){
//          print(response);
//          setState(() {
//            currency_response=json.decode(response);
//            for(int i=0;i<currency_response['currencySymbolsDropDown'].length;i++)
//              currency.add(currency_response['currencySymbolsDropDown'][i]['name']);
//            // stocks_loaded=true;
//          });
//        }
//      });
//    });
////    Utils.check_connectivity().then((result){
////      if(result){
////        CurrenciesServices.getCurrency(token).then((response){
////          if(response!=null){
////            print(response);
////            setState(() {
////              currency_response=json.decode(response);
////              for(int i=0;i<currency_response['currencySymbolsDropDown'].length;i++)
////                currency.add(currency_response['currencySymbolsDropDown'][i]['name']);
////              // stocks_loaded=true;
////            });
////          }
////        });
////      }else{
////        print("Network Not Available");
////      }
////    });
//
//  }
//  String get_currency_name(int id){
//
//    if(currency_response!=null&&id!=null) {
//      for (int i = 0; i < currency_response.length; i++) {
//        if(currency_response['currencySymbolsDropDown'][i]['id']==id) {
//          currency_name = currency_response['currencySymbolsDropDown'][i]['name'];
//        }
//      }
//    }
//    return currency_name;
//  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Update Currency"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //visible: stocks_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Currency",
                              initialValue: get_currency_by_id(specificcurrency['symbolId'])!= null ?get_currency_by_id(specificcurrency['symbolId']):null,
                            //  initialValue: specificcurrency!=null?specificcurrency['id']:null,
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Currency"),
                              items:currency!=null?currency.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Currency",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_currency=value;
                                  this.selected_currency_id=currency.indexOf(value);
                                });
                              },
                              onSaved:  (value){
                                setState(() {
                                  this.selected_currency=value;
                                  this.selected_currency_id=currency.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child:Padding(
                          padding: const EdgeInsets.all(16),
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Update",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                _fbKey.currentState.save();
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    CurrenciesServices.addCurrency(token, specificcurrency['id'],selected_currency, specificcurrency['createdBy'],).then((respons){
                                      pd.dismiss();
                                      setState(() {
                                        var parsedjson  = jsonDecode(respons);
                                        if(parsedjson != null){
                                          if(parsedjson['isSuccess'] == true){
                                            print("Successfully data updated");
                                          }else
                                            print("not saved");
                                        }else
                                          print("json response null");
                                      });
                                    });
                                  }
                                });
                              }
                            },
                          )
                      )
                  )
                ],
              )
            ]
        )
    );
  }
}

