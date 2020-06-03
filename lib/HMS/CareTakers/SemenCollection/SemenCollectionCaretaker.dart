import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class SemenCollectionCareTakerServices{

  static Future<String> semenCollection_caretaker_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
      'http://192.236.147.77:8083/api/CareTakers/AllSemenCollections?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> get_semen_collection_caretaker(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/AllSemenCollections',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> start_semen_collection(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/StartSemenCollections/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> complete_semen_collection(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/CompleteSemenCollections/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> save_late_complete_reason(String token, int id, String lateReason) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({
      // "breedingControlId": id,
      "id" : id,
      "LateReason": lateReason,
    },toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/CareTakers/LateCompleteSemenCollectionsReason', headers: headers, body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}