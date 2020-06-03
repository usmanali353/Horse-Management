import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class weight_hieght_services {


  static Future<String> weight_hieght_list (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllWeightsAndHeights',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> weight_hieght_listbypage (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllWeightsAndHeights?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> weight_hieghtdropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetWeightAndHeightById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdWeight_hieght (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetWeightAndHeightById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> weight_hieghtSave (String createdBy,String token,int id, int horseid, DateTime date,String weight,String hieght,String bodyCond,String comment ) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"Whid" : id,
      "horseId": horseid,
      "Date": date,
      "weight": weight,
      "height": hieght,
      "bodyCond": bodyCond,
      "comments": comment,
      "CreatedOn": DateTime.now(),
      "CreatedBy":createdBy,
      "IsActive": true
    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/WeightAndHeightSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> weight_hieghtvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/WeightAndHeightVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}