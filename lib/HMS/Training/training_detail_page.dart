import 'package:flutter/material.dart';

class training_details_page extends StatefulWidget{
  var training_data;
   String training_type_name;

  training_details_page(this.training_data,this.training_type_name);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _training_detail_page_state(training_data,training_type_name);
  }

}
class _training_detail_page_state extends State<training_details_page>{
  var training_data;
  String training_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Training Details"),),
      body: ListView(
        children: <Widget>[
          Column(
             children: <Widget>[
               ListTile(
                 title: Text("Training Id"),
                 trailing: Text(training_data['trainingId'].toString()!=null?training_data['trainingId'].toString():''),
               ),
               Divider(),
               ListTile(
                 title: Text("Trainer"),
                 trailing: Text(training_data['trainerName']['contactName']['name'].toString()!=null?training_data['trainerName']['contactName']['name'].toString():''),
               ),
               ListTile(
                 title: Text("Training Center"),
                 trailing: Text(training_data['trainingCenter']!=null?training_data['trainingCenter']:''),
               ),
               Divider(),
               ListTile(
                 title: Text("Training type"),
                 trailing: Text(training_type_name!=null?training_type_name:''),
               ),
               Divider(),
               ListTile(
                 title: Text("Sessions"),
                 trailing: Text(training_data['sessions']!=null?training_data['sessions'].toString():''),
               ),
               Divider(),
               ListTile(
                 title: Text("Targer Competition"),
                 trailing: Text(training_data['targetCompetition']!=null?training_data['targetCompetition']:''),
               ),
               Divider(),
               ListTile(
                 title: Text("Start Date"),
                 trailing: Text(training_data['startDate']!=null?training_data['startDate']:''),
               ),
               Divider(),
               ListTile(
                 title: Text("End Date"),
                 trailing: Text(training_data['endDate']!=null?training_data['endDate']:''),
               ),
               Divider(),
               ListTile(
                 title: Text("Target Date"),
                 trailing: Text(training_data['targetDate']!=null?training_data['targetDate']:''),
               ),
               Divider(),
             ],
          ),
        ],
      ),
    );
  }

  _training_detail_page_state(this.training_data,this.training_type_name);


}