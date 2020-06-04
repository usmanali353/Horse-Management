import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class EmbryoStockServices{

  static Future<String> embryo_stock_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
      'http://192.236.147.77:8083/api/breed/GetAllEmbryoStocks?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> get_embryo_stock(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/GetAllEmbryoStocks',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> change_embryo_stock_visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/SemenCollectionVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> add_embryo_stock(String createdBy,String token,int embryostockId,int horseID,int tankID, int  sireID, int gender, DateTime collection_date,  bool on_sale, String price, String grade, String stage, String status,  String comments,) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({
      "createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "embryoStockId":embryostockId,
      "horseId":horseID,
      "TankId":tankID,
      "sireId":sireID,
      "genderId":gender,
      "collectionDate":collection_date,
      "grade":grade,
      "stage":stage,
      "status":status,
      "onScale":on_sale,
      "price":price,
      "comments":comments,
      },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/breed/EmbryoStockSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_embryo_stock_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/breed/GetEmbryoStockById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}