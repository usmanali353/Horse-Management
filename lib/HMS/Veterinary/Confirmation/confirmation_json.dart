import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;

class ConfirmationServices {

  static Future<String> confirmationdropdowns(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Veterinary/GetConformationById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> confirmationvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Veterinary/ConformationVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> confirmationlist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Veterinary/GetAllConformations',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> add_confirmation(String token,int confirmationId,int horseId,DateTime date,int vetId,int opinion, String comments, String createdBy,List<Map>confirmationDetails) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({
      "conformationId":confirmationId,
      "horseId":horseId,
      "vetId":vetId,
      "opinion":opinion,
      "comments":comments,
      "createdBy": createdBy,
      "createdOn":DateTime.now(),
      "isActive":true,
      "conformationDetails":confirmationDetails
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/Veterinary/ConformationSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


}