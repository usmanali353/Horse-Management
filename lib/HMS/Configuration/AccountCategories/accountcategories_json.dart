import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class AccountCategoriesServices{
  static Future<String> addAccountCategory(String token,int id,String code,String name,String description,String createdBy,bool isIncome, bool isActive) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id, "code":code, "name":name, "description":description,"createdBy":createdBy,"createdOn":DateTime.now(),"isIncome":isIncome,"isActive":isActive,},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/AccountCategorySave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> getAccountCategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllAccountCategories', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeAccountCategoryVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/AccountCategoryVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}