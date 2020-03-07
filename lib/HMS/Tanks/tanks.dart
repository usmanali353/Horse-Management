import 'package:flutter/material.dart';

import 'add_tanks_form.dart';


class paddocks extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _paddocks_State();
  }

}

class _paddocks_State extends State<paddocks>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Tanks"),),
      body: Center(

        child: Column(

          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>add_tanks_form()));
        },
        tooltip: 'Add Tanks Form',
        child: Icon(Icons.add),
      ), // This trailing comma mak
    );
  }
}

