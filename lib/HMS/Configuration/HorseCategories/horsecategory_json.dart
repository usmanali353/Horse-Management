import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';


class HorseCategoryServices{

  //Horse Category
  static Future<String> addHorseCategory(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/HorseCategorySave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeHorseCategoryVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/HorseCategoryVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getHorseCategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllHorseCategories', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horseCategories_by_page (String token,int pagenum, String search) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/configuration/GetAllHorseCategories?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
}