import 'dart:convert';
import 'dart:io';
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

  static Future<String> sire_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/configuration/GetAllSires?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> sire_update(String createdBy,String token,int horseid,String name,int genderid,bool ishorse,String number,String passportNo,String microChip,DateTime dateofbirth,int colorId,int breedId,int categoryId,int sireid,int damid,String dna,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"createdBy": createdBy,"createdOn": DateTime.now(), "isSire": true,
      "isDam": false,"IsActive" : true,"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"number":number,"passportNo":passportNo,"microchipNo":microChip,"dateOfBirth":dateofbirth,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"sireId":sireid,"damId":damid,"HorseDetails": {"dna": dna,"breederId": null, "vetId": 8, "riderId": 6, "locationId": 4, "inchargeId": null,"associationId": 2,}},toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/configuration/SireSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}