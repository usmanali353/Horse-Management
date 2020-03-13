import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class PerformanceTypesServices{

  //Location
  //Performance Type
  static Future<String> addPerformanceType(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"performanceId":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/PerformanceTypeSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changePerformanceTypeVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/PerformanceTypeVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> getPerformanceType(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllPerformanceTypes', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}