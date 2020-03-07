import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import '../../../Utils.dart';



class BreedingSalesServices{

  static Future<String> get_breeding_sales(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/GetAllBreedingSales',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> change_breeding_sales_visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/BreedingSalesVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> add_breeding_sales(String createdBy,String token,int breedingsalesId, int horseID, DateTime date, int customerID, int  assignedVetID, DateTime paymentdate, String paymentreference, bool semen,  bool frozen,  bool cashpayment,  bool gift,  int status, String contract_no, String report_no,  String comments, String amount, int currencyID, int categoryID, int costcenterID, int contactID,) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({"createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "breedingSalesId":breedingsalesId,
      "horseId":horseID,
      "date":date,
      "customerId":customerID,
      "assignedVetId":assignedVetID,
      "paymentDate":paymentdate,
      "paymentReference":paymentreference,
      "isSemen":semen,
      "isFrozen":frozen,
      "isCashPayment":cashpayment,
      "isGift":gift,
      "status":status,
      "contractNo":contract_no,
      "breedingReportNo":report_no,
      "comments":comments,
      "amount":amount,
      "currency":currencyID,
      "categoryId":categoryID,
      "costCenterId":costcenterID,
      "contactId":contactID,
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/breed/BreedingSalesSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_breeding_sales_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/breed/GetBreedingSalesById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}