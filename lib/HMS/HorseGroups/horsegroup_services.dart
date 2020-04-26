import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class Add_horsegroup_services{

  static Future<String> gender(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GenderDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horsegrouplist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/HorseGroup/GetAllHorseGroups',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horsesdropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/HorseGroup/GetHorseGroupById',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horsegroupvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/HorseGroup/HorseGroupVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horseGroupSave(String token,String createdBy,int id,String name,bool isdynamic,int genderid,int locationid,int colorid,
      int breedid,int damid, int sireid,int breederid,int ownerid,int categoryid,int riderid,DateTime birthfrom,
      DateTime birthto,DateTime createdfrom,DateTime createto,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({
      "id": 0,
      "name": name,
      "isDynamic": isdynamic,
      "comments": "No Comment",
      "createdBy": createdBy,
      "createdOn": DateTime.now(),
      "IsActive" : true,
      "gender": genderid,
      "location": locationid,
      "birth": birthfrom,
      "birthTo": birthto,
      "age": null,
      "ageTo": null,
      "colorId": colorid,
      "breedId": breedid,
      "sireId": sireid,
      "damId": damid,
      "breederId": breederid,
      "ownerId": ownerid,
      "categoryId": categoryid,
      "riderId": riderid,
      "created": createdfrom,
      "createdTo": createto,
      "modified": null,
      "modifiedTo": null,
    },toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/HorseGroup/HorseGroupSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> addHorseToGroup(String token,int groupid,int horseId) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"id": 0,"groupId": groupid, "horseId": horseId});
    final response = await http.post('http://192.236.147.77:8083/api/HorseGroup/HorseGroupDetailSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> gethorselistOfGroup(String token,int groupid) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/HorseGroup/GetAllHorseGroupDetailss/'+groupid.toString(),
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> deleteHorseInGroup(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/HorseGroup/DeleteHorseInGroup/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}