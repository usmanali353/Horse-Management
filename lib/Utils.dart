import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  static bool validateStructure(String value){
    RegExp regExp = new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$');
    return regExp.hasMatch(value);
  }
  static bool validateEmail(String value){
  RegExp regExp=  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return regExp.hasMatch(value);
  }
  static Future<bool> check_connectivity () async{
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }
  static dynamic myEncode(dynamic item) {
    if(item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
 static Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }
  static Future<bool> isLogin()async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.getBool("isLogin");
  }
  static Future<String> GetRole()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString("role");
  }
}