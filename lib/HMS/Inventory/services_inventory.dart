import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class inventoryServices{

  static Future<String> ByIdInventory(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/GetInventoryById/'+id.toString(),
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> Inventorylist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/GetAllInventories',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> itemTypedropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/GetInventoryItemTypeDropDown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> stockdropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/GetInventoryStockDropDown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> itemStatusropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/GetItemStatusDropDown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> inventorySave(String createdby,String token,int id,String name,int itemtypeid,int stockid,String code,String location,DateTime enterDate,
      DateTime dueDate,String serialNo,String batchNo,int quantity,int itemstatus,int tobeeRaoaire,int outofRanch,String comment,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"Id": id,
      "Name": name,
      "ItemType": itemtypeid,
      "stock": stockid,
      "createdBy": createdby,
      "createdOn": DateTime.now(),
      "isActive": true,
      "currentLocation": location,
      "enterDate": enterDate,
      "dueDate": dueDate,
      "serialNo": serialNo,
      "batchNo": batchNo,
      "providorId": null,
      "quantity": quantity,
      "itemStatus": itemstatus,
      "toBeRepaired": 0,
      "outOfRanch": 0,
      "comments": comment,

    },toEncodable: Utils.myEncode);
    final response = await http.post('http://192.236.147.77:8083/api/Inventory/InventorySave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> inventoryvisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Inventory/InventoryVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


}