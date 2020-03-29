import 'package:flutter/material.dart';

class semen_collection_details_page extends StatefulWidget{
  var semen_collection_data;
  

  semen_collection_details_page(this.semen_collection_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _semen_collection_details_page(semen_collection_data);
  }

}
class _semen_collection_details_page extends State<semen_collection_details_page>{
  var semen_collection_data;
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Semen Collection Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Semen Collection ID: "),
                trailing: Text(semen_collection_data['semenCollectionId'].toString()!=null?semen_collection_data['semenCollectionId'].toString():''),
              ),
              Divider(),
              ListTile(
                title: Text("Horse: "),
                trailing: Text(semen_collection_data['horseName']['name'].toString()!=null?semen_collection_data['horseName']['name'].toString():''),
              ),
              ListTile(
                title: Text("Date"),
                trailing: Text(semen_collection_data['date'].toString()!=null?semen_collection_data['date'].toString():''),
              ),
              ListTile(
                title: Text("In Charge"),
                trailing: Text(semen_collection_data['inChargeName']['contactName']['name']!=null?semen_collection_data['inChargeName']['contactName']['name']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Comments"),
                trailing: Text(semen_collection_data['comments'].toString()!=null?semen_collection_data['comments'].toString():''),
              ),
//              ListTile(
//                title: Text("Assigned Vet"),
//                trailing: Text(semen_collection_data['assignedVetName']['contactName']['name']!=null?semen_collection_data['assignedVetName']['contactName']['name']:''),
//              ),
              Divider(),
              Text("Semen Evaluation",style: TextStyle(color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),),
              ListTile(
                title: Text("Extracted Volume"),
                trailing: Text(semen_collection_data['extractedVolume'].toString()!=null?semen_collection_data['extractedVolume'].toString():''),
              ),
              ListTile(
                title: Text("Concentration"),
                trailing: Text(semen_collection_data['concentration'].toString()!=null?semen_collection_data['concentration'].toString():''),
              ),
              ListTile(
                title: Text("General Motility"),
                trailing: Text(semen_collection_data['generalMotility'].toString()!=null?semen_collection_data['generalMotility'].toString():''),
              ),
              ListTile(
                title: Text("Progressive Motility"),
                trailing: Text(semen_collection_data['progressiveMotility'].toString()!=null?semen_collection_data['progressiveMotility'].toString():''),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

  _semen_collection_details_page(this.semen_collection_data);


}