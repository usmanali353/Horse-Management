import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class MarkingServices{

  static Future<String> addMarkings(String token,int id,String name,String abbreviation,String createdBy,int type) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name, "abbreviation":abbreviation, "createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"type":type},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/MarkingSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getMarkings(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllMarkings', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeMarkingsVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/MarkingVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}