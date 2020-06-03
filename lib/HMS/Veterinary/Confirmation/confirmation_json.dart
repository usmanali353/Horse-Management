import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;

class ConfirmationServices {

  static Future<String> get_conformations_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/Veterinary/GetConformationById/",headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
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
    final response = await http.get('http://192.236.147.77:8083/api/Veterinary/GetAllConformations',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> add_confirmation(String token,int confirmationId,int horseId,DateTime date,int vetId,int opinion, String createdBy,List<Map>confirmationDetails) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({
      "date":date,
      "conformationId":confirmationId,
      "horseId":horseId,
      "vetId":vetId,
      "opinion":opinion,
      "createdBy": createdBy,
      "createdOn":DateTime.now(),
      "isActive":true,
      "conformationDetails": [
        {
          "conformationDetailsId": 0,
          "limb": 1,
          "foreLimbJoint": 3,
          "hindLimbJoint": 0,
          "conformationStation": 4,
          "scoreStation": 1,
          "conformationMovement": 1,
          "scoreMovement": 1,
          "lesion": 1,
          "treatment": null,
          "response": 1,
          "createdOn": DateTime.now(),
          "isActive": true,
        },
      ]
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/Veterinary/ConformationSave",
        headers: headers,
        body:body);
    print(response.body);
    print(body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> confirmation_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/Veterinary/GetAllConformations?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}