import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

//
//Future<String> _loadAddressAsset() async {
//  return await rootBundle.loadString('http://192.236.147.77:8083/api/account/login.json');
//}
//
// Future<List> gender(String email,String password) async{
//   Map<String,String> headers = {'Authorization':'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJjZTg0YzNjOS1jOGIzLTQ2NGYtODUxNi00OWFhZTI0YWY5ZWEiLCJ1bmlxdWVfbmFtZSI6ImFwcGxpbmsxIiwibmJmIjoxNTgyMDExNjcwLCJleHAiOjE1ODIwOTgwNzAsImlhdCI6MTU4MjAxMTY3MH0.mPTJ2tuLfAZB553IMTjFNK6KNnYhE8Z79F4a-Y8oZS2s4x4RGYHbF0YsyUcSQZLSryCNRaVsWvb-DEMZZUvOVA'};
//   final body = jsonEncode({"email":email,"password":password});
//   final response = await http.get('http://192.236.147.77:8083/api/account/login',
//       headers: headers,
//    );
//    print(response.body);
//    var parsejson = jsonDecode(response.body);
//  Gender address =  Gender.fromJson(parsejson);
//  print(address.name[1]);
//}
//
//









//import 'dart:convert';
//import 'package:http/http.dart' as http;

class horse_operations{

  static Future<String> colors(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJjZTg0YzNjOS1jOGIzLTQ2NGYtODUxNi00OWFhZTI0YWY5ZWEiLCJ1bmlxdWVfbmFtZSI6ImFwcGxpbmsxIiwibmJmIjoxNTgyMDExNjcwLCJleHAiOjE1ODIwOTgwNzAsImlhdCI6MTU4MjAxMTY3MH0.mPTJ2tuLfAZB553IMTjFNK6KNnYhE8Z79F4a-Y8oZS2s4x4RGYHbF0YsyUcSQZLSryCNRaVsWvb-DEMZZUvOVA'};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/colorsdropdown',
      headers: headers,
    );
   var parsedjson= jsonDecode(response.body);
//    Gender gender= Gender.fromJson(parsedjson);
    print(response.body);
    return response.body;

    //print(gender.);

  }

}




//
//
//import 'package:http/http.dart' as http;
//import 'dart:async';
//import 'package:flutter_json/model/post_model.dart';
//import 'dart:io';
//
//String url = 'https://jsonplaceholder.typicode.com/posts';
//
//Future<List<Post>> getAllPosts() async {
//  final response = await http.get(url);
//  print(response.body);
//  return allPostsFromJson(response.body);
//}
//
//Future<Post> getPost() async{
//  final response = await http.get('$url/1');
//  return postFromJson(response.body);
//}
//
//Future<http.Response> createPost(Post post) async{
//  final response = await http.post('$url',
//      headers: {
//        HttpHeaders.contentTypeHeader: 'application/json',
//        HttpHeaders.authorizationHeader : ''
//      },
//      body: postToJson(post)
//  );
//  return response;
//}

//Future<Post> createPost(Post post) async{
//  final response = await http.post('$url',
//      headers: {
//        HttpHeaders.contentTypeHeader: 'application/json'
//      },
//      body: postToJson(post)
//  );
//
//  return postFromJson(response.body);
////}
