import 'dart:convert';
import 'package:http/http.dart' as http;


class DashboardServices{

  static Future<String> getUserDashboardData(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Dashboard/GetUserDashboardData', headers: headers,);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
//  static Future<String> changeDamVisibility(String token,int barnId) async{
//    Map<String,String> headers = {'Authorization':'Bearer '+token};
//    final response = await http.get('http://192.236.147.77:8083/api/configuration/DamVisibility/'+barnId.toString(), headers: headers,);
//    if(response.statusCode==200){
//      return response.body;
//    }else
//      return null;
//  }
//  static Future<String> get_Dam_dropdowns(String token) async{
//    Map<String,String> headers = {"Authorization":"Bearer "+token};
//    var response=await http.get("http://192.236.147.77:8083/api/configuration/GetDamById/",headers: headers);
//    if(response.statusCode==200){
//      return response.body;
//    }else
//      return null;
//  }
}