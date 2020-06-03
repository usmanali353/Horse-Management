import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;

class FlushesServicesJson {

  static Future<String> flushes_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
      'http://192.236.147.77:8083/api/breed/GetAllFlushes?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> flushesdropdowns(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/breed/GetFlushesById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> flushesvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/breed/FlushesVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> flusheslist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/breed/GetAllFlushes',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> add_flushes(String createdBy,String token,int flushesId, int horseid,DateTime service_date, int vetid, bool is_success, String embryo, String comments,) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({"createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "id":flushesId,
      "horseId":horseid,
      "date":service_date,
      "vetId":vetid,
      "isSuccess":is_success,
      "embryos":embryo,
      "comments":comments,
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/breed/FlushesSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


}