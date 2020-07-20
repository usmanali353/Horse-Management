import 'package:flutter/material.dart';

class vaccines_details_page extends StatefulWidget{
  var vaccines_data;


  vaccines_details_page(this.vaccines_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vaccines_details_page(vaccines_data);
  }

}
class _vaccines_details_page extends State<vaccines_details_page>{
  var vaccines_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Vaccines Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Vaccines ID: "),
                  trailing: Text(vaccines_data['id'].toString()!=null?vaccines_data['id'].toString():''),
                ),
                Divider(),

                ListTile(
                  title: Text("Vaccine: "),
                  trailing: Text(vaccines_data['name'].toString()!=null?vaccines_data['name'].toString():''),
                ),
                ListTile(
                  title: Text("Reminder:"),
                  trailing: Text(vaccines_data['reminder'] == true ? "Yes":"No" ),
                ),
                ListTile(
                  title: Text("Usage: "),
                  trailing: Text(vaccines_data['usage'].toString()!=null?vaccines_data['usage'].toString():''),
                ),
                ListTile(
                  title: Text("Primary Vaccination: "),
                  trailing: Text(vaccines_data['primaryVaccination'].toString()!=null?vaccines_data['primaryVaccination'].toString():''),
                ),
                ListTile(
                  title: Text("Booster: "),
                  trailing: Text(vaccines_data['booster'].toString()!=null?vaccines_data['booster'].toString():''),
                ),
                ListTile(
                  title: Text("Revaccination: "),
                  trailing: Text(vaccines_data['revaccination'].toString()!=null?vaccines_data['revaccination'].toString():''),
                ),
                ListTile(
                  title: Text("Dosage in Gestation: "),
                  trailing: Text(vaccines_data['doze1MonthNo'].toString()!=null || "-"+vaccines_data['doze2MonthNo'].toString()!=null||vaccines_data['doze3MonthNo'].toString()!=null?vaccines_data['doze1MonthNo'].toString()+" - "+vaccines_data['doze2MonthNo'].toString()+" - "+vaccines_data['doze3MonthNo'].toString():'empty'),
                ),
                ListTile(
                  title: Text("Comments: "),
                  subtitle: Wrap(
                    children: <Widget>[
                      Text(vaccines_data['comments'].toString()!=null?vaccines_data['comments'].toString():''
                      )],
                  ),
           ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _vaccines_details_page(this.vaccines_data);


}