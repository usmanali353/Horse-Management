import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class DietServices {


  static Future<String> newDietList (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetAllDiets',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> newDietVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Diet/DietVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> newDietDropDown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    var response = await http.get('http://192.236.147.77:8083/api/Diet/GetDietById', headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> newdietById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetDietById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> newDietSave (String createdBy,String token,int dietId,String name,String description,List<Map> dietDetails) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"DietId": dietId,
      "Name": name,
      "decription": description,
      "createdBy": createdBy,
      "createdOn": DateTime.now(),
      "isActive": true,
      "dietDetails": dietDetails,
    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/DietSave', headers: headers,
        body: body
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> productTypeList (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetAllProductTypes',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String>productTypeVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Diet/ProductTypeVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }



  static Future<String> productTypeById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetProductTypeById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/InventoryGetProductTypeById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductDropDown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/InventoryGetProductTypeById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> productTypeSave (String createdBy,String token,int id,int category,String name,int cost,int unit) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"productTypeId": id,
      "category": category,
      "name": name,
      "costPerUnit": cost,
      "unit": unit,
      "IsInventory": false,
      "createdBy": createdBy,
      "createdOn": "2020-03-06T10:18:37.417",
      "isActive": true
    });
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/ProductTypeSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductSave (String createdBy,String token,int id,int inventoryId,int categoryId,String cost) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"productTypeId": id,
      "category": categoryId,
      "name": "No name",
      "costPerUnit": cost,
      "unit": "1",
      "inventoryId": inventoryId,
      "IsInventory": true,
      "createdBy": createdBy,
      "createdOn": "2020-03-06T10:18:37.417",
      "isActive": true
    });
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/InventoryProductTypeSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}