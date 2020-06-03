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
  static Future<String> addVetVisits(String token,int vetVisitId,int horseId,int vetId,DateTime visitDate,int type,String createdBy,List<Map>vetVisitsProducts,int responsibleId,
      String reason, String temperature, String heart_rate, String breathing_freq, String capillary_filling, String dehydration, int mucus_membrane, String overall_mood,
      int pulse, int hoof_FL, int hoof_FR, int hoof_RL, int hoof_RR, int movements_L, int movements_R, bool feces_presence, int feces_consistency, String observation,
      int effort, int pulmonary_auscultation, int trachea_auscultation, String diagnosis, String dt_observation, String treatment )async{
      Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
      final body = jsonEncode({
        "type":type,
        "horseId":horseId,
        "vetId":vetId,
        "vetVisitId":vetVisitId,
        "visitDate":visitDate,
        "createdBy":createdBy,
        "createdOn":DateTime.now(),
        "isActive":true,
        "vetVisitsProducts":vetVisitsProducts,
        "responsibleId":responsibleId,
        "reason":reason,
        "temperature":temperature,
        "heartRate": heart_rate,
        "breathingFrequency":breathing_freq,
        "capilaryFilling":capillary_filling,
        "dehydration": dehydration,
        "mucousMemberanes": mucus_membrane,
        "overallMood": overall_mood,
        "pulse":pulse,
        "hoofFrontLeft":hoof_FL,
        "hoofFronRight":hoof_FR,
        "hoofRearLeft":hoof_RL,
        "hoofRearRight":hoof_RR,
        "movementsLeft":movements_L,
        "movementsRight":movements_R,
        "presenceOfFeces": feces_presence,
        "consistencyOfFeces":feces_consistency,
        "intestineObservations":observation,
        "effort":effort,
        "pulmonaryAuscultation":pulmonary_auscultation,
        "tracheaAuscultation":trachea_auscultation,
        "diagnosis":diagnosis,
        "treatmentObservations":dt_observation,
        "treatment":treatment
      },toEncodable: Utils.myEncode);
      var response=await http.post("http://192.236.147.77:8083/api/Veterinary/VetVisitSave",
          headers: headers,
          body:body);
      print(response.body);
      if(response.statusCode==200){
        return response.body;
      }else
        return null;
    }
  static Future<String> getVetVisits(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/Veterinary/GetAllVetVisits',headers: headers);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeVetVisitsVisibility(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    var response =await http.get('http://192.236.147.77:8083/api/Veterinary/VetVisitVisibility/'+id.toString(),headers: headers);
    if(response.statusCode==200){
      print(response.body);
      return response.body;
    }else
      return null;
  }
  
  static Future<String> vetvisit_by_page (String token,int pagenum) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      //'http://192.236.147.77:8083/api/horse/GetAllIncomeAndExpenses?pageNumber=2&pageSize=10',
      'http://192.236.147.77:8083/api/Veterinary/GetAllVetVisits?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  
}