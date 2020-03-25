//import 'dart:io';
//import 'package:horse_management/HMS/Configuration/Barns/barn_json.dart';
//import 'package:pdf/widgets.dart' as pdfLib;
//import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
//import 'package:flutter/material.dart';
////import 'package:playground_flutter/configs/ioc.dart';
////import 'package:playground_flutter/models/baseball.model.dart';
////import 'package:playground_flutter/pages/code_examples/pdf_and_csv/pdf_viewer.dart';
////import 'package:playground_flutter/services/sqlite_basebal_team.service.dart';
////import 'package:playground_flutter/shared/widgets/crud_demo_list_item.widget.dart';
//
//
//class PdfGeneratorDemo extends StatelessWidget {
//  PdfGeneratorDemo({Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Pdf - generate and view'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.picture_as_pdf),
//            onPressed: () => _generatePdfAndView(context),
//          ),
//          SizedBox(width: 10),
//        ],
//      ),
////      body: StreamBuilder(
////          stream: _databaseService.list(),
////          builder: (_, AsyncSnapshot<List<BaseballModel>> snapshot) {
////            if (!snapshot.hasData) {
////              return Center(
////                child: Text(
////                  "No data found !!!",
////                  style: TextStyle(
////                    color: Colors.red,
////                  ),
////                ),
////              );
////            }
////
////            return ListView(
////              children: snapshot.data.map((item) {
////                return CrudDemoListItem(
////                  item: item,
////                  onPressedDelete: (item) {},
////                  onPressedEdit: (item) {},
////                );
////              }).toList(),
////            );
////          }),
//    );
//  }
//
//  _generatePdfAndView(BuildContext context)async {
//    String token;
//    Map<String,String> headers = {'Authorization':'Bearer '+token};
//   // List<BarnServices> barnData = await
//    final response = await http.get('http://192.236.147.77:8083/api/configuration/GetAllBarns', headers: headers,);
//    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
//
//    pdf.addPage(
//      pdfLib.MultiPage(
//        build: (context) => [
//          pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
////            <String>['Name', 'Coach', 'players'],
////            ...data.map(
////                    (item) => [item.name, item.coach, item.players.toString()])
//         ]),
//        ],
//      ),
//    );
//
////    if(response.statusCode==200){
////      return response.body;
////    }else
////      return null;
//  }
//
//}