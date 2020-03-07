import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;

class BreedingServicesJson {

  static Future<String> get_breeding_services(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/GetBreedingServices',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> change_breeding_services_visibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/breed/BreedingServiceVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> update_and_add_breeding_service(String createdBy,String token,int breedingServiceId,int horseID, DateTime service_date, bool itsprogrammed, bool toBeFlushed, int  damID, int sireID, int servicetypeID, int sementypeID, String embryo_age, int  donorID, String amount, int currencyID, int categoryID, int costcenterID, int contactID, String comments) async{
    Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
    final body = jsonEncode({
      "createdOn":DateTime.now(),
      "createdBy": createdBy,
      "isActive":true,
      "breedingServiceId":breedingServiceId,
      "horseId":horseID,
      "serviceDate":service_date,
      "isProgrammedService":itsprogrammed,
      "isFlushed":toBeFlushed,
      "damId":damID,
      "sireId":sireID,
      "serviceType":servicetypeID,
      "semenType":sementypeID,
      "embryoAge":embryo_age,
      "donorId":donorID,
      "amount":amount,
      "currency":currencyID,
      "categoryId":categoryID,
      "costCenterId":costcenterID,
      "contactId":contactID,
      "comments":comments,
    },toEncodable: Utils.myEncode);
    var response=await http.post("http://192.236.147.77:8083/api/breed/BreedingServiceSave",
        headers: headers,
        body:body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }


  static Future<String> get_breeding_service_dropdowns(String token) async{
    Map<String,String> headers = {"Authorization":"Bearer "+token};
    var response=await http.get("http://192.236.147.77:8083/api/breed/GetBreedingServiceById/",headers: headers);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}