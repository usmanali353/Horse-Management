import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class farrier_services{

  static Future<String> horseIdFarrier(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetFarrierById/'+id.toString(),
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> farrierlist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllFarriers',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> farrierlistbypage(String token,int pagenum,String search) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllFarriers?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> farrierDropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetFarrierById',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> farrierSave(String createdby,int id,String token,int horseid,int farrierid,int shoeingtype,String comment,String amount,int currencyid,int categoryId,int costcenterid,int contactid,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"Id" : id,
      "horseId": horseid,
      "ShoeingType": shoeingtype,
      "Amount": amount,
      "CategoryId": categoryId,
      "FarrierId": farrierid,
      "currencyId": currencyid,
      "costCenterId": 12,
      "contactId": 14,
      "comments": "comment",
      "Date": DateTime.now(),
      "CreatedOn": DateTime.now(),
      "CreatedBy":createdby,
      "IsActive": true,},toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/horse/FarrierSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> weight_hieghtvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/FarrierVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


}