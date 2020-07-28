import 'package:flutter/material.dart';

class LabReport_details_page extends StatefulWidget{
  var farrierlist;
  LabReport_details_page(this.farrierlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LabReport_details_page(farrierlist);
  }

}
class _LabReport_details_page extends State<LabReport_details_page>{
  var farrierlist;
  String training_type_name;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Lab Reports Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("LabReport ID: "),
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
                    title: Text("Responsible :"),
                    trailing: Text(farrierlist['responsibleName']['contactName']['name'].toString()!=null?farrierlist['responsibleName']['contactName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Test Types :"),
                    trailing: Text(farrierlist['testTypes']['name'].toString()!=null?farrierlist['testTypes']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Lab:"),
                    trailing: Text(farrierlist['lab']!=null?(farrierlist['lab'].toString()):''),
                  ),
                  ListTile(
                    title: Text("Result:"),
                    trailing: Text(farrierlist['result']!=null?farrierlist['result'].toString():''),
                  ),
                  ListTile(
                    title: Text("Positive:"),
                    trailing: Text(farrierlist['isPositive']==true?"Yes":'No'),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  _LabReport_details_page(this.farrierlist);


}