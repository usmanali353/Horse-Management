import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class BreedingSalesCareTakerServices{

  static Future<String> breedingSales_caretaker_by_page (String token,int pagenum, String search) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
      'http://192.236.147.77:8083/api/CareTakers/AllBreedingSales?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> get_breedingSales_caretaker(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/AllBreedingSales',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> start_breeding_sales(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/StartBreedingSales/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> complete_breeding_sales(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/CareTakers/CompleteBreedingSales/'+id.toString(),headers: headers);
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
    final response = await http.post('http://192.236.147.77:8083/api/CareTakers/LateCompleteBreedingSalesReason', headers: headers, body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}