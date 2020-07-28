import 'package:flutter/material.dart';

class farrier_details_page extends StatefulWidget{
  var farrierlist;
  farrier_details_page(this.farrierlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _farrier_details_page(farrierlist);
  }

}
class _farrier_details_page extends State<farrier_details_page>{
  var farrierlist;
  String training_type_name;
  
  
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Farrier Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Farrier ID: "),
                    trailing: Text(farrierlist['id'].toString()!=null?farrierlist['id'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Horse: "),
                    trailing: Text(farrierlist['horseName']['name'].toString()!=null?farrierlist['horseName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Date:"),
                    trailing: Text(farrierlist['date'].toString()!=null?farrierlist['date'].toString().substring(0,10):''),
                  ),
                  ListTile(
                    title: Text("Farrier Name:"),
                    trailing: Text(farrierlist['farrierName']['contactName']['name'].toString()!=null?farrierlist['farrierName']['contactName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Shoe Type:"),
                    trailing: Text(farrierlist['shoeingType']!=null?get_shoetype_by_id(farrierlist['shoeingType']):''),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  _farrier_details_page(this.farrierlist);


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