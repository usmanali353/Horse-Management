import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils.dart';




class PaddockServices{

  static Future<String> addPaddock(String token,int paddockId, String paddockName, String mainUse, int locationId, String area, bool hasShade, bool hasWater, bool grass, bool otherAnimals, String comments, String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"Id":paddockId,"Name":paddockName,"createdOn":DateTime.now(), "mainUse":mainUse, "locationId":locationId, "area":area, "hasShade":hasShade, "hasWater":hasWater, "grass":grass, "otherAnimals":otherAnimals, "comments":comments, "isActive":true,"createdBy":createdBy,},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/Paddock/PaddockSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getPaddock(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/GetAllPaddocks', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changePaddockVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/PaddockVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> get_Paddock_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/Paddock/GetPaddockById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> get_add_horses_to_paddock_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/Paddock/GetHorsesDropdownForPaddock/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> save_horses_to_paddock_dropdowns(String token,int id,int paddockId,int horseId,String createdBy,) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"PaddockId":paddockId,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"HorseId":horseId},toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/Paddock/AddHorseToPaddock",headers: headers,body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getPaddockDetails(String token,int id, int pagenum, String search) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/GetAllPaddockDetails/'+id.toString()+'?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> delete_horses_from_paddock(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/DeleteHorseInPaddock/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> paddocks_by_page (String token,int pagenum, String search) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/Paddock/GetAllPaddocks?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

//  static Future<String> paddockDetails_by_page (String token,int pagenum) async {
//    Map<String, String> headers = {'Authorization': 'Bearer '+token};
//    final response = await http.get(
//      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
//
//      'http://192.236.147.77:8083/api/OperationNotes/GetAllOperationNotes?pageNumber='+pagenum.toString()+'&pageSize=10',
//      headers: headers,
//    );
//    if (response.statusCode == 200) {
//      return response.body;
//    } else
//      return null;
//  }

}