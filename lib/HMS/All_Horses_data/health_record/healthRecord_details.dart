import 'package:flutter/material.dart';

class healthRecord_details_page extends StatefulWidget{
  var farrierlist;
  healthRecord_details_page(this.farrierlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _healthRecord_details_page(farrierlist);
  }

}
class _healthRecord_details_page extends State<healthRecord_details_page>{
  var farrierlist;
  String training_type_name;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Health Records Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("HealthRecord ID: "),
                    trailing: Text(farrierlist['id'].toString()!=null?farrierlist['id'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Horse: "),
                    trailing: Text(farrierlist['horseName']['name'].toString()!=null?farrierlist['horseName']['name'].toString():''),
                  ),
//                  ListTile(
//                    title: Text("Date:"),
//                    trailing: Text(farrierlist['date'].toString()!=null?farrierlist['date'].toString().substring(0,10):''),
//                  ),
                  ListTile(
                    title: Text("Responsible Name:"),
                    trailing: Text(farrierlist['responsibleName']['contactName']['name'].toString()!=null?farrierlist['responsibleName']['contactName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Product:"),
                    trailing: Text(farrierlist['product']!=null?(farrierlist['product'].toString()):''),
                  ),
                  ListTile(
                    title: Text("Quantity:"),
                    trailing: Text(farrierlist['quantity']!=null?farrierlist['quantity'].toString():''),
                  ),
                  ListTile(
                    title: Text("comments:"),
                    trailing: Text(farrierlist['comments']!=null?(farrierlist['comments'].toString()):''),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  _healthRecord_details_page(this.farrierlist);


  String get_shoetype_by_id(int id){
    String shoetypeinitial;
    if(farrierlist != null) {
      if (id == 1) {
        setState(() {
          shoetypeinitial = 'Complete';
        });
      }
      if (id == 2) {
        setState(() {
          shoetypeinitial = 'Front shoeing';
        });
      }
      if (id == 3) {
        setState(() {
          shoetypeinitial = 'Back shoeing';
        });
      }
      if (id == 4) {
        setState(() {
          shoetypeinitial = 'Trimming';
        });
      }
    }
    else{
      shoetypeinitial = null;
      print("genderlist null a");
    }
    return shoetypeinitial;
  }

}