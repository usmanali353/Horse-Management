import 'package:flutter/material.dart';


class diet_listspecific extends StatefulWidget{
  String token;
  var  specificdiet;

  diet_listspecific (this.token, this.specificdiet);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token,specificdiet);
  }

}
class _Profile_Page_State extends State<diet_listspecific>{
  int id;

  _Profile_Page_State (this.token,this.specificHealthRecord);

  String token,title,dateOfBirth;
  var specificHealthRecord,healthdropDown;
  var temp=['',''];


  @override
  void initState () {
//    healthServices.horseIdhealthRecord(token, id).then((response){
//      setState(() {
//        print(response);
//        specificHealthRecord =json.decode(response);
//
//      });
//
//    });
//    Add_horse_services.labdropdown(token).then((response){
//      setState((){
//        labdropDown = json.decode(response);
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Diet "),
//          actions: <Widget>[
//          Center(child: Text("Add New",textScaleFactor: 1.3,)),
//          IconButton(
//
//            icon: Icon(
//              Icons.add,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => health_record_form(token)),);
//            },
//          )
//        ],
        ),
        body: ListView.builder(itemCount:specificHealthRecord!=null?specificHealthRecord.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              ExpansionTile(
                //['categoryName']['name']
                title: Text(specificHealthRecord[index]['date']!= null ? specificHealthRecord[index]['date'].toString().substring(0,10):"Date not found"),
                trailing: Text((specificHealthRecord[index]['status'])),

                children: <Widget>[
                  ListTile(
                    title: Text("Product"),
                    trailing: Text(specificHealthRecord != null ? specificHealthRecord[index]['product'].toString(): 'product null'),
                    onTap: ()async{
                      //list[index]['categoryDropDown']['categoryId']['name'].toString()
//                      print(specificHealthRecord['horseDropdown'][specificHealthRecord[0]['horseId']]==['id']);
//                      print(specificHealthRecord['horseDropdown']);
//                      print(specificHealthRecord);
//                      print(specificHealthRecord[0]['horseId']);
//                      prefs= await SharedPreferences.getInstance();
//                      Navigator.push(context, MaterialPageRoute(builder: (context) => (list[index]['allIncomeAndExpenses'],prefs.get('token'),prefs.get('createdBy'))),);

                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity"),
                    trailing: Text(specificHealthRecord != null ?specificHealthRecord[index]['quantity'].toString():'quantity empty'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount"),
                    trailing: Text(specificHealthRecord[index]['amount'].toString()),
                  )

                ],


              ),
            ],

          );

        })
    );
  }

}

