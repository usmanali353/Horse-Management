import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';


class VaccinationTypesServices{

  static Future<String> addVaccinationType(String token,int vaccinationId,String vaccinationType, bool canDelayed, String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"vaccinationTypeId":vaccinationId,"vaccinationType":vaccinationType, "canBeDelayed":canDelayed, "createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/VaccinationTypeSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getVaccinationType(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllVaccinationTypes', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeVaccinationTypeVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/VaccinationTypeVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}