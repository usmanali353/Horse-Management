import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class CostCenterServices{

  static Future<String> costCenters_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/configuration/GetAllCostCenters?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> addCostCenter(String token,int id,String name, String description, String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name, "description":description,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/CostCenterSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getCostCenters(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllCostCenters', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeCostCenterVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/CostCenterVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> costCenterDropdown(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/CostCenterDropdown', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}