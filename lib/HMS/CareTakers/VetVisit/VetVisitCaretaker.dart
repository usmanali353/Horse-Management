import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class VetVisitCareTakerServices{

  static Future<String> get_vetVisit_caretaker(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/AllVetVisits',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> start_vetVisit(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/StartVaccinations/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> complete_vetVisit(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/CompleteVaccinations/'+id.toString(),headers: headers);
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
    final response = await http.post('http://192.236.147.77:8083/api/CareTakers/LateCompleteVetVisitsReason', headers: headers, body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}