import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../Utils.dart';



class TanksServices{

  static Future<String> get_Tanks(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/Tanks/GetAllTanks',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> change_Tanks_Visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/Tanks/TanksVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> add_Tanks(String createdBy,String token,int tanksId, String name,int locationId,String capacity,DateTime lastfill, DateTime nextfill, String policynumber, DateTime policyduedate,) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({"createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "id":tanksId,
      "name":name,
      "locationId":locationId,
      "capacity":capacity,
      "lastFill":lastfill,
      "nextFill":nextfill,
      "insurancePolicy":policynumber,
      "insurancePolicyDueDate":policyduedate
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/Tanks/TanksSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_Tanks_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/Tanks/GetTankById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> tanks_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/Tanks/GetAllTanks?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
}