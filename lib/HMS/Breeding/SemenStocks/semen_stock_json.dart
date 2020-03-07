import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class SemenStockServices{

  static Future<String> get_semen_dose(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/GetAllSemenDoses',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> change_semen_dose_visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/SemenDoseVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> add_semen_dose(String token,int embryostockId,int horseID,int tankID, DateTime entry_date, DateTime collection_date, String quantity, String cannister, String price, String serial_number,  String batch_number, bool was_bought, bool on_sale, ) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({"createdOn":DateTime.now(),
      "createdBy":"ce84c3c9-c8b3-464f-8516-49aae24af9ea",
      "isActive":true,
      "semenCollectionId":embryostockId,
      "horseId":horseID,
      "tankId":tankID,
      "enterDate":  entry_date,
      "collectionDate":collection_date,
      "quantity":quantity,
      "canister":cannister,
      "price":price,
      "serialNumber":serial_number,
      "batchNumber":batch_number,
      "isbrought":was_bought,
      "onSale":on_sale,
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/breed/SemenCollectionSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_semen_dose_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/breed/GetSemenDoseById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}