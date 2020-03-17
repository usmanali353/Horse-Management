import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/loginScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:horse_management/Network_Operations.dart';

class reset_password_screen extends StatefulWidget{
  String Email,token;

  reset_password_screen(this.Email, this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _reset_password_screen_state(Email,token);
  }

}
class  _reset_password_screen_state extends State<reset_password_screen>{
  TextEditingController email,password;

  _reset_password_screen_state(this.Email, this.token);

  String Email,token;
  @override
  void initState(){
    email=new TextEditingController();
    password=new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:scrollview(email: email, password: password,Email: Email,token: token,),
    );
  }

}
class scrollview extends StatelessWidget {
  const scrollview({
    Key key,
    @required this.email,
    @required this.password,
    @required this.Email,
    @required this.token
  }) : super(key: key);
   final String Email,token;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/loginBackground.jpg"),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              )
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white,size:40),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Welcome",style: TextStyle(
                          color: Colors.teal,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )),
                      Text("Provide your new Password",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25
                      )),
                      SizedBox(height: 40),
                      TextField(
                        controller: email,
                        style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(Icons.https,color: Colors.teal,size: 27,),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: password,
                        style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                            ),
                            labelText: "Conform Password",
                            labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                            suffixIcon: Icon(Icons.https,color: Colors.teal,size: 27,)
                        ),
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: (){
                          if(email.text==null||email.text.isEmpty){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Password is required"),
                            ));
                          }else if(!Utils.validateStructure(email.text)){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("New Password should have atleast one uppercase,lowercase and special character"),
                            ));
                          }else if(password.text==null||password.text.isEmpty){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Enter Password Again"),
                            ));
                          }else if(!Utils.validateStructure(password.text)){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Conform Password should have atleast one uppercase,lowercase and special character"),
                            ));
                          }else if(email.text!=password.text){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Passwords do no match"),
                            ));
                          }else{
                            Utils.check_connectivity().then((result){
                              if(result){
                                var pd= ProgressDialog(context, type: ProgressDialogType.Normal);
                                pd.show();
                                network_operations.Reset_Password(Email,token,password.text).then((response_json)async{
                                  if(response_json==null){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Failed to Reset Password"),
                                    ));
                                  }else{
                                    var parsedJson = json.decode(response_json);
                                    if(parsedJson['isSuccess']==true){
                                      pd.dismiss();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Your Password is Changed"),
                                      ));
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(Route<dynamic> route) => false);
                                    }else{
                                      pd.dismiss();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Failed to Reset Password"),
                                      ));
                                    }
                                  }
                                }).catchError((error){
                                  print(error);
                                });
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Network not Available"),
                                ));
                              }
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.teal,
                          child: Center(
                            child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}