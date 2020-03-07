import 'package:flutter/material.dart';
import 'package:horse_management/HMS/Veterinary/Confirmation/add_confirmation_form.dart';



class confirmartion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _confirmartion_State();
  }

}

class _confirmartion_State extends State<confirmartion>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation"),),
      body: Center(

        child: Column(

          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>add_confirmation_form()));
        },
        tooltip: 'Add Confirmation Form',
        child: Icon(Icons.add),
      ), // This trailing comma mak
    );
  }
}

