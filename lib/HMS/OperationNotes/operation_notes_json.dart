import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../Utils.dart';



class OperationNotesServices{

  static Future<String> get_Operation_Notes(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/OperationNotes/GetAllOperationNotes',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> change_Operation_Notes_Visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/OperationNotes/OperationNotesVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> add_Operation_Notes(String createdBy,String token,int operationNotesId, DateTime date, int generalCategoryId, String details,) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({"createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "operationNoteId":operationNotesId,
      "date":date,
      "generalCategoryId":generalCategoryId,
      "details":details,
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/OperationNotes/OperationNotesSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_Operation_Notes_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/OperationNotes/GetOperationNoteById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}