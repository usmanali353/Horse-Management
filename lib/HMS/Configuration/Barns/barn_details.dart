import 'package:flutter/material.dart';

class barn_details_page extends StatefulWidget{
  var barn_data;


  barn_details_page(this.barn_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _barn_details_page(barn_data);
  }

}
class _barn_details_page extends State<barn_details_page>{
  var barn_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Barn Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Barn ID: "),
                  trailing: Text(barn_data['barnId'].toString()!=null?barn_data['barnId'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Barn Name: "),
                  trailing: Text(barn_data['barnName'].toString()!=null?barn_data['barnName'].toString():''),
                ),

                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _barn_details_page(this.barn_data);


}