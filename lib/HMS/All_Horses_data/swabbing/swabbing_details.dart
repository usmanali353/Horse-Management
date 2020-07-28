import 'package:flutter/material.dart';

class Swabbing_details_page extends StatefulWidget{
  var farrierlist;
  Swabbing_details_page(this.farrierlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Swabbing_details_page(farrierlist);
  }

}
class _Swabbing_details_page extends State<Swabbing_details_page>{
  var farrierlist;
  String training_type_name;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Swabbing Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Swabbing ID: "),
                    trailing: Text(farrierlist['swabbingId'].toString()!=null?farrierlist['swabbingId'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Horse: "),
                    trailing: Text(farrierlist['horseName']['name'].toString()!=null?farrierlist['horseName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("swabbing Date:"),
                    trailing: Text(farrierlist['swabbingDate'].toString()!=null?farrierlist['swabbingDate'].toString().substring(0,10):''),
                  ),
                  ListTile(
                    title: Text("Treatment Date:"),
                    trailing: Text(farrierlist['dateOfTreatment'].toString()!=null?farrierlist['dateOfTreatment'].toString().substring(0,10):''),
                  ),
//                  ListTile(
//                    title: Text("Responsible :"),
//                    trailing: Text(farrierlist['responsibleName']['contactName']['name'].toString()!=null?farrierlist['responsibleName']['contactName']['name'].toString():''),
//                  ),
                  ListTile(
                    title: Text("Antibiotic:"),
                    trailing: Text(farrierlist['antibiotic']!=null?(farrierlist['antibiotic'].toString()):''),
                  ),
                  ListTile(
                    title: Text("Comments:"),
                    trailing: Text(farrierlist['comments']!=null?farrierlist['comments'].toString():''),
                  ),
                  ListTile(
                    title: Text("Result:"),
                    trailing: Text(farrierlist['result']!=null?farrierlist['result'].toString():''),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  _Swabbing_details_page(this.farrierlist);


}