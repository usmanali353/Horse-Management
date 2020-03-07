import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class healthServices{

  static Future<String> horseIdhealthRecord(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHealthRecordById/'+id.toString(),
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> healthRecordTestlist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllHealthRecords',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> healthdropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHealthRecordById/1',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> healthRecordSave(String token,int horseid,int responsibleid,int recordtype,String product,int quantity,String comment,String amount,int currencyid,int categoryId,int costcenterid,int contactid,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"horseId": horseid, "recordType": "0", "responsibleId": responsibleid, "product": product, "quantity": quantity, "comments": comment, "amount": amount, "currency": currencyid, "categoryId": categoryId, "costCenterId": costcenterid,"contactCustomerProvider":contactid,
      "createdBy": "404f7199-9e7b-4173-a8c6-30fad0a2e2b6", "createdOn": "2020-02-08T02:13:05.707", "isActive": true});
    final response = await http.post('http://192.236.147.77:8083/api/horse/HealthRecordSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }



}