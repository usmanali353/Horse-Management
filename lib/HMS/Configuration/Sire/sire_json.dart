import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';


class SireServices{

  static Future<String> addSire(String token,int sireId,String sireName, int genderId, String createdBy,int breedId,DateTime date,int colorId,String number,String microchip ) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({
      "horseId":sireId,
      "name":sireName,
      "isHorse": true,
      "isSire": true,
      "isDam": false,
      "genderId":genderId,
      "createdBy":createdBy,
      "createdOn":DateTime.now(),
      "isActive":true,
      "breedId":breedId,
      "colorId":colorId,
      "dateOfBirth":date,
      "number":number,
      "microchipNo":microchip,
    },toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/SireSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getSire(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllSires', headers: headers,);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeSireVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/SireVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> get_Sire_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/configuration/GetSireById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}