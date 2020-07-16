import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class vaccination_services {


  static Future<String> vaccination_list (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllVaccinations',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> vaccination_listbypage (String token,int pagenum,String search) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllVaccinations?pageNumber='+pagenum.toString()+'&pageSize=10&SearchString='+search,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> vaccinationDropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetVaccinationById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdVaccination (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetVaccinationById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> vaccinationSave (String createdBy,String token,int id, int horseid, DateTime startdate,DateTime enddate,int vaccinationtypeId,int vaccineId,int vetId,String noOfDose,String amount,int categoryId,int costcenterId,int currencyId ) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"VaccinationId" : id,
      "horseId": horseid,
      "StartDate": startdate,
      "EndDate": enddate,
      "VaccineId": vaccineId,
      "VaccinationTypeId": vaccinationtypeId,
      "Amount": amount,
      "noOfDoses": noOfDose,
      "vetId":vetId,
      "costCenterId": costcenterId,
      "currencyId":currencyId,
      "CategoryId": categoryId,
      "CreatedOn": DateTime.now(),
      "CreatedBy": createdBy,
      "IsActive": true,

    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/VaccinationSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> vaccinationVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/VaccinationVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}