import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class income_expense_services {


  static Future<String> income_expenselist (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> income_expenselistbypage (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',

      'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> incomevisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/IncomeAndExpenseVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> incomedropdown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetIncomeAndExpenseById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> horseIdincomeExpense (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/horse/GetIncomeAndExpenseById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> income_expenseSave (String createdBy,String token,int id, int horseid, DateTime date, String amount,String description, int currencyid, int categoryId, int costcenterid, int contactid,String account,) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"id" : id,
      "horseId": horseid,
      "Date": date,
      "CreatedOn": DateTime.now(),
      "Amount":amount,
      "CategoryId":categoryId,
      "costCenterId": costcenterid,
      "currency": currencyid,
      "description": description,
      "contactId": contactid,
      "TypeGeneralOrBusiness": account,
      "CreatedBy": createdBy,
      "IsActive": true
    },toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://192.236.147.77:8083/api/horse/IncomeAndExpenseSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}