import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class labtest_services {


  static Future<String> labTestlist (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllLabTests',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> labdropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetLabTestById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdLabtest (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetLabTestById/' + id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> labTestSave (String token, int horseid, DateTime date, int testtypeid, bool positive, int responsibleid, String lab, String result, String amount, int currencyid, int categoryId, int costcenterid, int contactid,) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+ token
    };
    final body = jsonEncode({"id" : 0,
      "horseId": horseid,
      "TypeTestId": testtypeid,
      "Date": date,
      "Amount":amount,
      "CategoryId":categoryId,
      "CreatedBy": "41b19c63-510c-48db-85b5-f745c9132c53",
      "Result": result,
      "isPositive": positive, "responsible": responsibleid, "lab": lab,
       "costCenterId": costcenterid, "contactId": contactid, "currencyId": currencyid, "labTestReportImage": null,
      "isActive":true
    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/LabTestSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}