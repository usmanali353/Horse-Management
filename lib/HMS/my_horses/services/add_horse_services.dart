import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class Add_horse_services{

  static Future<String> gender(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GenderDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> colors(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/colorsdropdown',
      headers: headers,
    );
   // var parsedjson= jsonDecode(response.body);
//    Gender gender= Gender.fromJson(parsedjson);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> barns(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/BarnDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> breed(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/BreederDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horsecategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/HorseCategoryDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> sire(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/SireDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> dam(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/DamDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> diet(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/DietDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> headmarking(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/HeadMarkingDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> bodymarking(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/BodyMarkingDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> legmarking(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/LegMarkingDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> ironbrand(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/IronBrandDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> breeder(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/colorsdropdown',
      headers: headers,
    );if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> vet(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/VetDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> rider(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/RiderDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> incharge(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/InchargeDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> location(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/LocationDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> association(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/AssociationDropdown',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horselist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHorses',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horselistbypage(String token,int pagenum) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHorses?pageNumber='+pagenum.toString()+'&pageSize=10',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horsesdropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHorseById',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horsevisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/HorseVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horseDashBoard(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetHorseDashboard/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horsesave(String token,int horseid,String name,int genderid,bool ishorse,String number,String passportNo,String microChip,DateTime dateofbirth,int colorId,int breedId,int categoryId,int sireid,int damid,int headmarkid,int bodymarkid,int legmarkid,int dietid,int barnid,int vet,int breeder,int location,int riderid,int inchargeid,int associationid,String dna) async{
////  static Future<String> horsesave(String token,int horseid,String name,int genderid,bool ishorse,DateTime dateofbirth,String number,String passportNo,int colorId,int breedId,int categoryId,int sireid,int damid,int headmarkid,int bodymarkid,int legmarkid,int dietid,int barnid,int ironbrandid,int riderid,int inchargeid,String dna) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
        final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"number":number,"passportNo":passportNo,"microchipNo":"123456","dateOfBirth":dateofbirth,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"sireId":sireid,"damId":damid,"headmarkingId": headmarkid, "bodymarkingId": bodymarkid, "legmarkingId": legmarkid, "dietId": dietid,"HorseDetails": {"breederId": breeder, "vetId": vet, "riderId": riderid, "locationId": location, "inchargeId": inchargeid, "associationId": associationid, "dna": dna,}},toEncodable: Utils.myEncode);
//    final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"dateOfBirth":dateofbirth,"number":number,"passportNo":passportNo,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"sireId":sireid,"damId":damid,"headmarkingId":headmarkid,"bodymarkingId":bodymarkid,"legmarkingId":legmarkid,"dietId":dietid,"barnId":barnid,"brandId":ironbrandid,"riderId":riderid,"inchargeId":inchargeid,"dna":dna,});

   // final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"dateOfBirth":dateofbirth,"number":number,"passportNo":passportNo,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"microchipNo":microChip,"sireId":sireid,"damId":damid,});
    final response = await http.post('http://192.236.147.77:8083/api/horse/HorseSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> horsesaveReq(String token,int horseid,String name,int genderid,bool ishorse,String number,String microChip,DateTime dateofbirth,int colorId,int breedId,int sireid,int damid,int barnid,int vet,int breeder) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"number":number,"microchipNo":"123456","dateOfBirth":dateofbirth,"colorId":colorId,"breedId":breedId,"sireId":sireid,"damId":damid, "HorseDetails": {"breederId": breeder, "vetId": vet,}},toEncodable: Utils.myEncode);

    final response = await http.post('http://192.236.147.77:8083/api/horse/HorseSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
 // ,int headmarkid,int bodymarkid,int legmarkid,int dietid,int barnid,int ironbrandid,int riderid,int inchargeid,int associationid
  static Future<String> horseupdate(String token,String createdBy,int horseid,String name,int genderid,bool ishorse,String number,String passportNo,String microChip,DateTime dateofbirth,int colorId,int breedId,int categoryId,int sireid,int damid,int headmarkid,int bodymarkid,int legmarkid,int dietid,int barnid,int brandid,int vet,int breeder,int location,int riderid,int inchargeid,int associationid,String dna,) async{
////  static Future<String> horsesave(String token,int horseid,String name,int genderid,bool ishorse,DateTime dateofbirth,String number,String passportNo,int colorId,int breedId,int categoryId,String microChip,int sireid,int damid,int headmarkid,int bodymarkid,int legmarkid,int dietid,int barnid,int ironbrandid,int riderid,int inchargeid,String dna) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    //"dietId": dietid,"barnId": 3,"brandId": ironbrandid,"headMarkingsDropDown": headmarkid, "bodyMarkingsDropDown": bodymarkid, "legMarkingsDropDown": legmarkid,
    final body = jsonEncode({"createdBy": createdBy,"createdOn": DateTime.now(),"IsActive" : true,"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"barnId": barnid,"number":number,"passportNo":passportNo,"microchipNo":microChip,"dateOfBirth":dateofbirth,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"sireId":sireid,"damId":damid,"headmarkingId": headmarkid, "bodymarkingId": bodymarkid, "legmarkingId": legmarkid, "dietId": dietid,"brandId":brandid,"HorseDetails": {"dna": dna,"breederId": breeder, "vetId": vet, "riderId": riderid, "locationId": location, "inchargeId": inchargeid,"associationId": associationid,}},toEncodable: Utils.myEncode);
//    final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"dateOfBirth":dateofbirth,"number":number,"passportNo":passportNo,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"microchipNo":microChip,"sireId":sireid,"damId":damid,"headmarkingId":headmarkid,"bodymarkingId":bodymarkid,"legmarkingId":legmarkid,"dietId":dietid,"barnId":barnid,"brandId":ironbrandid,"riderId":riderid,"inchargeId":inchargeid,"dna":dna,});

    // final body = jsonEncode({"horseId":horseid,"name":name,"genderId":genderid,"IsHorse":ishorse,"dateOfBirth":dateofbirth,"number":number,"passportNo":passportNo,"colorId":colorId,"breedId":breedId,"horseCategoryId":categoryId,"microchipNo":microChip,"sireId":sireid,"damId":damid,});
    final response = await http.post('http://192.236.147.77:8083/api/horse/HorseSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  /// Lab Services
  static Future<String> labTestlist(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllLabTests',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> labdropdown(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetLabTestById',
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> horseIdLabtest(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/horse/GetLabTestById/'+id.toString(),
      headers: headers,
    );
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> labTestSave(String token,int horseid,DateTime date,int testtypeid,bool positive,int responsibleid,String lab,String result,String amount,int currencyid,int categoryId,int costcenterid,int contactid,) async{
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader : 'Bearer '+token
    };
    final body = jsonEncode({"id": 4, "horseId": 13, "typeTestId": 4, "date": "2020-02-08T00:00:00", "isPositive": positive, "responsible": responsibleid, "lab": lab, "result": result, "amount": amount, "categoryId": categoryId, "costCenterId": costcenterid, "contactId": contactid, "currencyId": currencyid, "labTestReportImage": null,
      "createdBy": "404f7199-9e7b-4173-a8c6-30fad0a2e2b6", "createdOn": DateTime.now(), "isActive": true});
    final response = await http.post('http://192.236.147.77:8083/api/horse/HorseSave', headers: headers, body: body
    );
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}