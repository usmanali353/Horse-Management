import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';




class DamServices{

  static Future<String> addDam(String token,int damHorseId, String damName, bool isHorse, bool isSire, bool isDam, int breedId, int colorId, DateTime date, String number, String microchip, String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({
      "horseId":damHorseId,
      "name":damName,
      "isHorse": true,
      "isSire": false,
      "isDam": true,
      "genderId": 2,
      "createdBy":createdBy,
      "createdOn":DateTime.now(),
      "isActive":true,
      "breedId":breedId,
      "colorId":colorId,
      "dateOfBirth":date,
      "number":number,
      "microchipNo":microchip,


    },toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/DamSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getDam(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllDams', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeDamVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/DamVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> get_Dam_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/configuration/GetDamById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> dam_by_page (String token,int pagenum, String search) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/configuration/GetAllDams?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> dam_update(String createdBy,String token,int horseid,String name,int genderid,bool ishorse,String number,String passportNo,String microChip,DateTime dateofbirth,int colorId,int breedId,int categoryId,int sireid,int damid,String dna,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"createdBy": createdBy,"createdOn": DateTime.now(), "isSire": false,
    "isDam": true,"IsActive" : true,"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"number":number,"passportNo":passportNo,"microchipNo":microChip,"dateOfBirth":dateofbirth,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"sireId":sireid,"damId":damid,"HorseDetails": {"dna": dna,"breederId": null, "vetId": 8, "riderId": 6, "locationId": 4, "inchargeId": null,"associationId": 2,}},toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/configuration/DamSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}