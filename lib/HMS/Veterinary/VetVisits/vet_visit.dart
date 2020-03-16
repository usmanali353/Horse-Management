import 'package:flutter/material.dart';
import 'add_visit_form.dart';


class vet_visit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _confirmartion_State();
  }

}
class _confirmartion_State extends State<vet_visit>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Vet"),),
      body: Center(

        child: Column(

          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>add_visit_form()));
        },
        tooltip: 'Add Vet',
        child: Icon(Icons.add),
      ), // This trailing comma mak
    );
  }
}

