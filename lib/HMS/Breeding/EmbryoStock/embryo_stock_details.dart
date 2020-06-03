import 'package:flutter/material.dart';

class embryo_stock_details_page extends StatefulWidget{
  var embryo_stock_data;
 

  embryo_stock_details_page(this.embryo_stock_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _embryo_stock_details_page(embryo_stock_data);
  }

}
class _embryo_stock_details_page extends State<embryo_stock_details_page>{
  var embryo_stock_data;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Embryo Stock Details"),),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Embryo Stocks ID: "),
                  trailing: Text(embryo_stock_data['embryoStockId'].toString()!=null?embryo_stock_data['embryoStockId'].toString():''),
                ),
                Divider(),
                ListTile(
                  title: Text("Horse: "),
                  trailing: Text(embryo_stock_data['horseName']['name'].toString()!=null?embryo_stock_data['horseName']['name'].toString():''),
                ),
                ListTile(
                  title: Text("Sire: "),
                  trailing: Text(embryo_stock_data['sireName']['name'].toString()!=null?embryo_stock_data['sireName']['name'].toString():''),
                ),
                ListTile(
                  title: Text("Collection Date:"),
                  trailing: Text(embryo_stock_data['collectionDate'].toString()!=null?embryo_stock_data['collectionDate'].toString().substring(0,10):''),
                ),
                ListTile(
                  title: Text("Stage:"),
                  trailing: Text(embryo_stock_data['stage']!=null?embryo_stock_data['stage']:''),
                ),
                ListTile(
                  title: Text("Tank:"),
                  trailing: Text(embryo_stock_data['tankName']['name']!=null?embryo_stock_data['tankName']['name']:''),
                ),
               ListTile(
                  title: Text("Price:"),
                  trailing: Text(embryo_stock_data['price'].toString()!=null?embryo_stock_data['price'].toString():''),
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _embryo_stock_details_page(this.embryo_stock_data);


}