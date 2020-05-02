import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class hypothetic_pedegree_page extends StatefulWidget{
  var hp_data;
  String hp_name;

  hypothetic_pedegree_page(this.hp_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _hypothetic_pedegree_page(hp_data);
  }

}
class _hypothetic_pedegree_page extends State<hypothetic_pedegree_page>{
  var hp_data;
  String training_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Hypothetic Pedigree"),),
        body:  Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,

                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 20,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                  //  alignment: Alignment.center,
                   // child: Text(hp_data['breedingControlId'].toString()!=null?hp_data['breedingControlId'].toString():'', style: TextStyle(color: Colors.black),),
                      color: Colors.lightBlue[200],
                      child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(hp_data['breedingControlId'].toString()!=null?hp_data['breedingControlId'].toString():'', style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,

                ),
              ),
              height: MediaQuery.of(context).size.height * 0.31,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 30,
                    child: Container(
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Container(
                      color: Colors.pink.shade200,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,

                ),
              ),
              height: MediaQuery.of(context).size.height * 0.27,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.pink.shade200,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.pink.shade200,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // height: MediaQuery.of(context).size.height * 0.20,
        )

    );
  }


  _hypothetic_pedegree_page(this.hp_data);


}