
//import 'dart:convert';
//
//List<contact> genderFromJson(String str) => List<contact>.from(json.decode(str).map((x) => contact.fromJson(x)));
//
//String genderToJson(List<contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//class contact {
//
//  List contactlist;
//
//  contact({
//    this.contactlist,
//  });
//
////  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
////    id: json["id"],
////    name: json["name"],
////  );
//  factory contact.fromJson(Map<String, dynamic> parsedJson) {
//
//    var streetsFromJson  = parsedJson['name'];
//    //print(streetsFromJson.runtimeType);
//    // List<String> streetsList = new List<String>.from(streetsFromJson);
//    List<String> streetsList = streetsFromJson.cast<String>();
//   // List<dynamic> data = json.decode(parsedJson).cast<String>();
//
//    return new contact(
//      contactlist: streetsList,
//
//    );
//  }
//
//
//  List<Map> carOptionJson = new List();
//  CarJson carJson = new CarJson("ca339e40-10cc-4459-b9ec-07f7df0f4c69");
//
//  var body = json.encode({
//    "LstUserOptions": carOptionJson
//  });
//
////http.Response response = await http.post(
////Uri.encodeFull(ConfigApi.SAVE),
////body: body,
////headers: {'Content-type': 'application/json'});
//
//
//}
//class CarJson {
//  String OptionID;
//  CarJson(this.OptionID);
//  Map<String, dynamic> TojsonData() {
//    var map = new Map<String, dynamic>();
//    map["OptionID"] = OptionID;
//    return map;
//  }
//}
//



//
//class Page{
//  int page;
//  int perPage;
//  int total;
//  int totalPages;
//  Author author;
//  List<Data> data;
//
//  Page({this.page,
//    this.perPage,
//    this.total,
//    this.totalPages, this.author, this.data});
//
//  factory Page.fromJson(Map<String, dynamic> parsedJson){
//
//    var list = parsedJson['data'] as List;
//    List<Data> data = list.map((i) => Data.fromJson(i)).toList();
//
//
//    return Page(
//        page: parsedJson['page'],
//        perPage: parsedJson['per_page'],
//        total: parsedJson['total'],
//        totalPages: parsedJson['total_pages'],
//        author: Author.fromJson(parsedJson['author']),
//        data: data
//
//    );
//  }
//}
//
//
//
//class Author{
//  String firstName;
//  String lastName;
//
//  Author({this.firstName, this.lastName});
//
//  factory Author.fromJson(Map<String, dynamic> parsedJson){
//    return Author(
//      firstName: parsedJson['first_name'],
//      lastName : parsedJson['last_name'],
//    );
//  }
//
//}
//
//class Data{
//  int id;
//  String firstName; // add others
//  List<Image> imagesList;
//
//  Data({
//    this.id, this.firstName, this.imagesList
//  });
//
//  factory Data.fromJson(Map<String, dynamic> parsedJson){
//
//    var list = parsedJson['images'] as List;
//    List<Image> images = list.map((i) => Image.fromJson(i)).toList();
//
//
//    return Data(
//        id: parsedJson['id'],
//        firstName: parsedJson['first_name'],
//        imagesList: images
//
//    );
//  }
//}
//
//class Image{
//  int id;
//  String imageName;
//
//  Image({
//    this.id, this.imageName
//
//  });
//
//  factory Image.fromJson(Map<String, dynamic> parsedJson){
//    return Image(
//      id: parsedJson['id'],
//      imageName : parsedJson['imageName'],
//    );
//  }
//
//}