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

}