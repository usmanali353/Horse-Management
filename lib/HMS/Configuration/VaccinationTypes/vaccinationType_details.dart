import 'package:flutter/material.dart';

class vaccinationType_details_page extends StatefulWidget{
  var vaccinationtype_data;


  vaccinationType_details_page(this.vaccinationtype_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vaccinationType_details_page(vaccinationtype_data);
  }

}
class _vaccinationType_details_page extends State<vaccinationType_details_page>{
  var vaccinationtype_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Vaccination Type Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Vaccination Type ID: "),
                  trailing: Text(vaccinationtype_data['vaccinationTypeId'].toString()!=null?vaccinationtype_data['vaccinationTypeId'].toString():''),
                ),
                Divider(),

                ListTile(
                  title: Text("Vaccination Type: "),
                  trailing: Text(vaccinationtype_data['vaccinationType'].toString()!=null?vaccinationtype_data['vaccinationType'].toString():''),
                ),
                ListTile(
                  title: Text("Can Be Delayed:"),
                  trailing: Text(vaccinationtype_data['canBeDelayed'] == true ? "Yes":"No" ),
                ),

//                ListTile(
//                  title: Text("Description: "),
//                  subtitle: Wrap(
//                    children: <Widget>[
//                      Text(vaccinationtype_data['description'].toString()!=null?vaccinationtype_data['description'].toString():''
//                      )],
//                  ),
//                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _vaccinationType_details_page(this.vaccinationtype_data);


}