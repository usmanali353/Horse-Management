import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'Utils.dart';

class network_operations{

static Future<String> Sign_In(String email,String password) async{
  Map<String,String> headers = {'Content-Type':'application/json'};
  final body = jsonEncode({"email":email,"password":password});
  final response = await http.post('http://192.236.147.77:8083/api/account/login',
      headers: headers,
      body: body,
  );
  print(response.body);
  if(response.statusCode==200) {
    return response.body;
  }else
    return null;
}
static Future<String> Sign_Up(String first_name,String email,String password) async{
  Map<String,String> headers = {'Content-Type':'application/json'};
  final body = jsonEncode({"email":email,"password":password,"firstname":first_name,"confirmPassword":password});
  final response = await http.post('http://192.236.147.77:8083/api/account/register',
    headers: headers,
    body: body,
  );
  print(response.body);
  if(response.statusCode==200) {
    return response.body;
  }else
    return null;
}
static Future<String> Forgot_Password(String email) async{
  Map<String,String> headers = {'Content-Type':'application/json'};
  final body = jsonEncode({"email":email});
  final response = await http.post('http://192.236.147.77:8083/api/Account/ForgotPassword',
    headers: headers,
    body: body,
  );
  print(response.body);
  if(response.statusCode==200) {
    return response.body;
  }else
    return null;
}
static Future<String> Reset_Password(String email,String token,String password) async{
  Map<String,String> headers = {'Content-Type':'application/json'};
  final body = jsonEncode({"email":email,"password":password,"token":token,"confirmPassword":password});
  final response = await http.post('http://192.236.147.77:8083/api/Account/ResetPassword',
    headers: headers,
    body: body,
  );
  print(response.body);
  if(response.statusCode==300) {
    return response.body;
  }else
    return null;
}
static Future<String> get_training(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  var response =await http.get('http://192.236.147.77:8083/api/Training/GetTrainings',headers: headers);
  print(response.body);
  if(response.statusCode==200){
     return response.body;
  }else
    return null;
}
static Future<String> change_training_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  var response =await http.get('http://192.236.147.77:8083/api/Training/TrainingVisibility/'+id.toString(),headers: headers);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_training(int training_id,int training_type,DateTime startDate,DateTime endDate,int horse,String training_center,DateTime target_date,String target_competition,String token,int trainer_id,String horse_name,int planid,String trainername,String plan_name,String created_by) async{
  Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
  final body = jsonEncode({"createdOn":DateTime.now(),"isActive":true,"trainingId":training_id,"trainingType":training_type,"startDate":startDate,"endDate":endDate,"horseId":horse,"trainingCenter":training_center,"targetDate":target_date,"targetCompetition":target_competition,"trainerId":trainer_id,"horseName":{"name": horse_name},"planId":planid,"trainerName":{"name":trainername},"createdBy":created_by,"endTraining":false},toEncodable: Utils.myEncode);
  var response=await http.post("http://192.236.147.77:8083/api/Training/TrainingSave",
      headers: headers,
      body:body);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}


static Future<String> get_training_dropdowns(String token) async{
  Map<String,String> headers = {"Authorization":"Bearer "+token};
  var response=await http.get("http://192.236.147.77:8083/api/Training/GetTrainingById",headers: headers);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}


static Future<String> add_video(String token,int videoId,String comments,String title,String link,DateTime date,String horseName,int horseId,String createdby) async{
  Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
  final body = jsonEncode({"videoId":videoId,"Link":link,"IsActive":true,"Date":date,"horseId":horseId,"CreatedBy":createdby,"title":title,"comments":comments,"createdOn":DateTime.now(),"horseName":{"name":horseName}},toEncodable: Utils.myEncode);
  var response= await http.post("http://192.236.147.77:8083/api/horse/VideosSave",headers: headers,body: body);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_videos(String token) async{
  Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
  var response=await http.get("http://192.236.147.77:8083/api/horse/GetAllVideos",headers: headers);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> change_video_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  var response =await http.get('http://192.236.147.77:8083/api/horse/VideosVisibility/'+id.toString(),headers: headers);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_video_dropdowns(String token) async{
  Map<String,String> headers = {"Authorization":"Bearer "+token};
  var response=await http.get("http://192.236.147.77:8083/api/horse/GetVideosById/",headers: headers);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_pictures_dropdown(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/GetPictureById/', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_pictures(int picture_id,String token,int horseid, DateTime date, String title, String description,String created_by,Uint8List picture ) async{
  Map<String,String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader : 'Bearer '+token
  };
  final body = jsonEncode({"PictureId":picture_id,"isActive":true, "createdOn":DateTime.now(), "createdBy": created_by, "horseId":horseid, "date":date,"title":title, "description":description,"Image":picture},toEncodable: Utils.myEncode);
  final response = await http.post('http://192.236.147.77:8083/api/horse/PicturesSave', headers: headers, body: body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_pictures(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllPictures', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> change_picture_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/PicturesVisibility/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_notes(String token,int id,int horse_id,String details,DateTime date,String created_by,String horse_name) async{
  Map<String,String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader : 'Bearer '+token
  };
  final body = jsonEncode({"NoteId":id,"horseId":horse_id,"Date":date,"Details":details,"CreatedBy":created_by,"CreatedOn":DateTime.now(),"IsActive":true,"horseName":{"name":horse_name}},toEncodable: Utils.myEncode);
  final response = await http.post('http://192.236.147.77:8083/api/horse/NotesSave', headers: headers, body: body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_semen_collection_dropdowns(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/GetSemenCollectionById/', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_semen_collection(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/GetAllSemenCollections', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> change_semen_collection_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/SemenCollectionVisibility/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_notes_dropdown(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/GetNotesById/', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> change_notes_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/NotesVisibility/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_notes(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/horse/GetAllNotes', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> change_contact_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  var response =await http.get('http://192.236.147.77:8083/api/Contacts/ContactsVisibility/'+id.toString(),headers: headers);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_contacts(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/Contacts/GetAllContacts', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_contact(String token,int contactId,String name,String website,String facebook,String instagram,String twitter,String email,String address,String mobile,String phone,String cnic,Uint8List picture,List<Map> contact_type)async{
  Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
  final body = jsonEncode({"contactId":contactId,"Name":name,"website":website,"facebook":facebook,"instagram":instagram,"twiter":twitter,"email":email,"address":address,"mobileNo":mobile,"phoneNo":phone,"cnic":cnic,"picture":picture,"contactTypess":contact_type},toEncodable: Utils.myEncode);
  var response= await http.post("http://192.236.147.77:8083/api/Contacts/ContactSave",headers: headers,body: body);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_semen_collection(String token, int id,DateTime selected_date,String horsename, int horseId,createdBy,bool toFreeze, int inchargeid,String comments,int voluume,int concentration , int general,int progressive,String selected_incharge,String kjdnkj) async{
  Map<String,String> headers = {'Content-Type':'application/json',"Authorization":"Bearer "+token};
  final body = jsonEncode({"semenCollectionId": id,
    "horseId": horseId,
    "date": selected_date,
    "hour": "01:02:00",
    "toFreeze": toFreeze,
    "inChargeId": inchargeid,
    "comments": comments,
    "extractedVolume": voluume,
    "concentration": concentration,
    "generalMotility": general,
    "progressiveMotility": progressive,
    "createdBy": createdBy,
    "createdOn": DateTime.now(),
    "isActive": true,
    "inChargeName": {
      "contactTypesId": 26,
      "contactId": inchargeid,
      "contactTypeId": 10,
      "isActive": true,}},toEncodable: Utils.myEncode);
  var response= await http.post("http://192.236.147.77:8083/api/breed/SemenCollectionSave",headers: headers,body: body);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> add_breeding_control(String token, int id, int horseId,DateTime date,DateTime hour,int check_method_id,int serviceid,bool empty,bool pregnancy,bool abortion,bool reabsorption,bool follicle,bool ovule,bool twins,bool volvoplasty,double amount, int currencyid, String Createdby,String comments,String lo,String ro,String uterus,String vagina,String cervix,int accountcategory,int costcenterid,int contactid,int vetId) async{
  Map<String,String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader : 'Bearer '+token
  };
  final body = jsonEncode({"breedingControlId": id,
    "horseId": horseId,
    "date": date,
    "hour": "01:00:00",
    "check_Method": check_method_id,
    "vetId": vetId,
    "lo": lo,
    "ro": ro,
    "uterus": uterus,
    "vagina": vagina,
    "cervix": cervix,
    "comments": comments,
    "relatedServiceId": serviceid,
    "empty": empty,
    "pregnancy": pregnancy,
    "abortion": abortion,
    "reabsorption": reabsorption,
    "follicle": follicle,
    "ovule": ovule,
    "twins": twins,
    "volvoplasty": volvoplasty,
    "nextCheckReason": 0,
    "nextCheckDate": "2020-03-06T10:09:59.17",
    "nextCheckComments": null,
    "amount": amount,
    "currency": currencyid,
    "categoryId": accountcategory,
    "costCenterId": costcenterid,
    "contactId": contactid,
    "status": null,
    "createdBy": Createdby,
    "createdOn": DateTime.now(),
    "updatedBy": "ce84c3c9-c8b3-464f-8516-49aae24af9ea",
    "updatedOn": "2020-03-06T02:21:50.338155-08:00",
    "isActive": true,},toEncodable: Utils.myEncode);
  final response = await http.post('http://192.236.147.77:8083/api/horse/NotesSave', headers: headers, body: body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}

static Future<String> get_breeding_control_dropdowns(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/GetBreedingControlById', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_all_breeding_controls(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/GetAllBreedingControls', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}

static Future<String> change_breeding_control_visibility(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/breed/BreedingControlVisibility/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> end_training(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/Training/EndTraining/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> get_horses_already_trained(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/Training/GetAllAlreadyTrainedHorses', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> delete_already_trained_horses(String token,int id) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/Training/DeleteTrainedHorse/'+id.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
//Barns
static Future<String> addBarn(String token,int barnId,String barnName,String createdBy) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
  final body = jsonEncode({"barnId":barnId,"barnName":barnName,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
  var response= await http.post("http://192.236.147.77:8083/api/configuration/BarnSave",headers: headers,body: body);
  print(response.body);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> getBarns(String token) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllBarns', headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
static Future<String> changeBarnVisibility(String token,int barnId) async{
  Map<String,String> headers = {'Authorization':'Bearer '+token};
  final response = await http.get('http://192.236.147.77:8083/api/configuration/BarnVisibility/'+barnId.toString(), headers: headers,);
  if(response.statusCode==200){
    return response.body;
  }else
    return null;
}
//Colors
  static Future<String> addColor(String token,int colorId,String colorName,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":colorId,"name":colorName,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/ColorSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getColors(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllColors', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeColorVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/BarnVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Breeds
  static Future<String> addBreed(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/BreedSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getBreeds(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllBreeds', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeBreedsVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/BreedVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Currency
  static Future<String> addCurrency(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"symbol":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/Currencysave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getCurrency(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllCurrencies', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeCurrencyVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/CurrencyVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Horse Category
  static Future<String> addHorseCategory(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/HorseCategorySave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeHorseCategoryVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/HorseCategoryVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getHorseCategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllHorseCategories', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //General Category
  static Future<String> addGeneralCategory(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/GeneralCategorySave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getGeneralCategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllGeneralCategories', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeGeneralCategoryVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GeneralCategoryVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Location
  static Future<String> addLocation(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/LocationSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getLocation(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllLocations', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeLocationVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/LocationVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Vaccines
  static Future<String> addVaccines(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/VaccineSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getVaccine(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllVaccines', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeVaccinesVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/VaccineVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Performance Type
  static Future<String> addPerformanceType(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"performanceId":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/PerformanceTypeSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changePerformanceTypeVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/PerformanceTypeVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Cost Center
  static Future<String> addCostCenter(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/CostCenterSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getCostCenters(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllCostCenters', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeCostCenterVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/CostCenterVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Account Category
  static Future<String> addAccountCategory(String token,int id,String name,String createdBy,bool isIncome) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"isIncome":isIncome},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/AccountCategorySave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getAccountCategory(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllAccountCategories', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeAccountCategoryVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/AccountCategoryVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Iron Brand
  static Future<String> addIronBrand(String token,int id,String name,String createdBy,String brandImage) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"brandId":id,"brandTitle":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"brandImage":brandImage},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/IronBrandSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getIronBrand(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllIronBrands', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeIronBrandVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/IronBrandVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Associations
  static Future<String> addAssociations(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/AssociationSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getAssociations(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllAssociations', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeAssociationsVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/AssociationVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Test Types
  static Future<String> addTestTypes(String token,int id,String name,String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/TestTypeSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeTestTypesVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/TestTypeVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getTestTypes(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllTestTypes', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  //Marking
  static Future<String> addMarkings(String token,int id,String name,String createdBy,int type) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"id":id,"name":name,"createdBy":createdBy,"createdOn":DateTime.now(),"isActive":true,"type":type},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/configuration/MarkingSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getMarkings(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllMarkings', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changeMarkingsVisibility(String token,int Id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/configuration/MarkingVisibility/'+Id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

}