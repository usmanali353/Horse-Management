import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class IronBrandServices{

  static Future<String> addIronBrand(String token,int id,String name,String createdBy,Uint8List brandImage) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"brandId":id,"brandTitle":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"brandImage":brandImage},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/IronBrandSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getIronBrand(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllIronBrands', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeIronBrandVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/IronBrandVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}