import 'dart:convert';

import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;
class vieterniaryServices {

  static Future<String> getVetVisitsDropDowns(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Veterinary/GetVetVisitById/', headers: headers,);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> addVetVisits(String token,int vetVisitId,int horseId,int vetId,DateTime visitDate,int type,String createdBy,List<Map>vetVisitsProducts)async{
      Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
      final body = json.encode({"type":type,"horseId":horseId,"vetId":vetId,"vetVisitId":vetVisitId,"visitDate":visitDate,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"vetVisitsProducts":vetVisitsProducts},toEncodable: Utils.myEncode);
      var response=await http.post("http://192.236.147.77:8083/api/Veterinary/VetVisitSave",
          headers: headers,
          body:body);
      print(response.body);
      if(response.statusCode==200){
        return response.body;
      }else
        return null;
    }

}