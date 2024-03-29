import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class MarkingService {


  static Future<String> markingSave(String token, int horseid, String marking) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    };
    final body = jsonEncode({
      "horseId": horseid,
      "markingPhoto": marking,
    }, toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/HorseMarkingSave', headers: headers,
        body: body
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}