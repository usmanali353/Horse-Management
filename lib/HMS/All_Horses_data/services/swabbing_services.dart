import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class swabbing_services {


  static Future<String> swabbing_list (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllSwabbing',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> swabbing_listbypage (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllSwabbing?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> swabbing_Dropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetSwabbingById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdswabbing (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetSwabbingById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> swabbingSave (String createdBy,String token,int id, int horseid, DateTime swabDate,DateTime treatmentDate,String antibiotic,String result,String amount,String comment ) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"SwabbingId" : id,
      "horseId": horseid,
      "SwabbingDate": swabDate,
      "Antibiotic": antibiotic,
      "CreatedOn": DateTime.now(),
      "CreatedBy":createdBy,
      "IsActive": true,
      "result": result,
      "amount": amount,
      "dateOfTreatment": treatmentDate,
      "comments": comment,

    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/SwabbingSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> swabbingVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/SwabbingVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}