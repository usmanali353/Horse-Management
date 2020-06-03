import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class movement_services {


  static Future<String> movement_list (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllMovements',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> movement_listbypage (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllMovements?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> movement_Dropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetMovementById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdmovement (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetMovementById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> movementSave (String createdBy,String token,int id, int horseid, DateTime depatureDate,DateTime returnDate,bool roundtrip,int transportid,int reasonid,int fromlocation,int tolocation,String amount,String reposible,String comment,int categoryid,int currencyid,int costcenterid ) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"MovementId" : id,
      "horseId": horseid,
      "RoundTrip": roundtrip,
      "TransportType": transportid,
      "Reason": reasonid,
      "DepartureDate": depatureDate,
      "FromLoc": fromlocation,
      "ToLoc": tolocation,
      "Amount": amount,
      "returnDate": returnDate,
      "CreatedOn": DateTime.now(),
      "responsible": reposible,
      "comments": comment,
      "currencyId": currencyid,
      "categoryId": categoryid,
      "costCenterId": costcenterid,
      "CreatedBy":createdBy,
      "IsActive": true

    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/MovementSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> movementVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/MovementVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}