import 'package:flutter/material.dart';

class Movement_details_page extends StatefulWidget{
  var farrierlist;
  Movement_details_page(this.farrierlist);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Movement_details_page(farrierlist);
  }

}
class _Movement_details_page extends State<Movement_details_page>{
  var farrierlist;
  String training_type_name;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Movement Details"),),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Movement ID: "),
                    trailing: Text(farrierlist['movementId'].toString()!=null?farrierlist['movementId'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Horse: "),
                    trailing: Text(farrierlist['horseName']['name'].toString()!=null?farrierlist['horseName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Departure Date:"),
                    trailing: Text(farrierlist['departureDate'].toString()!=null?farrierlist['departureDate'].toString().substring(0,10):''),
                  ),
                  ListTile(
                    title: Text("Return Date:"),
                    trailing: Text(farrierlist['returnDate'].toString()!=null?farrierlist['returnDate'].toString().substring(0,10):''),
                  ),
//                  ListTile(
//                    title: Text("Responsible :"),
//                    trailing: Text(farrierlist['responsibleName']['contactName']['name'].toString()!=null?farrierlist['responsibleName']['contactName']['name'].toString():''),
//                  ),
                  ListTile(
                    title: Text("From Location:"),
                    trailing: Text(farrierlist['fromLocationName']['name'].toString()!=null?farrierlist['fromLocationName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("To Location:"),
                    trailing: Text(farrierlist['toLocationName']['name'].toString()!=null?farrierlist['toLocationName']['name'].toString():''),
                  ),
                  ListTile(
                    title: Text("Responsible:"),
                    trailing: Text(farrierlist['responsible']!=null?(farrierlist['responsible'].toString()):''),
                  ),
                  ListTile(
                    title: Text("Comments:"),
                    trailing: Text(farrierlist['comments']!=null?farrierlist['comments'].toString():''),
                  ),
                  ListTile(
                    title: Text("amount:"),
                    trailing: Text(farrierlist['amount']!=null?farrierlist['amount'].toString():''),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  _Movement_details_page(this.farrierlist);


}