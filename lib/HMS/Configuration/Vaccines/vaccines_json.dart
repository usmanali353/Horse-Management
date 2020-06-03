import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class VaccinesServices{

  //Vaccines
  static Future<String> addVaccines(String token,int id,String name,String comments,bool reminder,int usage, String primary_vaccination, String booster, String revaccination, String fisrt_dose, String second_dose, String third_dose,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({
      "id":id,
      "name":name,
      "comments":comments,
      "reminder":reminder,
      "usage":usage,
      "primaryVaccination":primary_vaccination,
      "booster":booster,
      "revaccination":revaccination,
      "doze1MonthNo":fisrt_dose,
      "doze2MonthNo":second_dose,
      "doze3MonthNo":third_dose,
      "createdBy":createdBy,
      "createdOn":DateTime.now(),
      "isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/VaccineSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getVaccine(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllVaccines', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeVaccinesVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/VaccineVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> vaccines_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/configuration/GetAllVaccines?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}