import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.landscapeRight,
//      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  var hp_data;
  String training_type_name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Hypothetic Pedigree"),),
        body:  ListView(
          children: <Widget>[
            Container(
              height: 92,
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
                      child: Column(
//  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text(hp_data['horseId']!=null?hp_data['name'].toString():'empty', style: TextStyle(color: Colors.black),),
                      ],
                      ),
                      color: Colors.lightBlue[200],
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
                      child: Column(
//  crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(hp_data['sireId']!=null?hp_data['sireName']['name'].toString():'empty', style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Container(
                      color: Colors.pink.shade200,
                      child: Column(
//  crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(hp_data['damId']!=null?hp_data['damName']['name'].toString():'empty', style: TextStyle(color: Colors.black),),
                        ],
                      ),
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