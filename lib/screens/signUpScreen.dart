import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name,email,password;


  @override
  void initState() {
    name= TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollview(name: name, password: password, email: email),
    );
  }
}

class scrollview extends StatelessWidget {
  const scrollview({
    Key key,
    @required this.name,
    @required this.password,
    @required this.email,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController password;
  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    final focusPassword = FocusNode();
    final focusemail = FocusNode();
    return SingleChildScrollView(
      child: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/wallpaper2.jpg"),
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
                      Text("Sign Up To continue",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25
                      )),
                      SizedBox(height: 35),
                      TextFormField(
                        controller: name,
                        style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(Icons.perm_identity,color: Colors.teal,size: 27,),
                        ),
                          textInputAction: TextInputAction.next,
                           onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focusemail);}
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        focusNode: focusemail,
                        controller: email,
                        style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(Icons.email,color: Colors.teal,size: 27,),
                        ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(focusPassword);}
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: password,
                        focusNode: focusPassword,
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
                            suffixIcon: Icon(Icons.https,color: Colors.teal,size: 27,)
                        ),
                      ),

                      SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                            if(name.text == null || name.text.isEmpty){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Name is Required"),
                                backgroundColor: Colors.red,
                              ));
                            }else if(email.text == null || email.text.isEmpty){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Email is Required"),
                                backgroundColor: Colors.red,
                              ));
                            }else if(!Utils.validateEmail(email.text)){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Email Format is Invalid"),
                                backgroundColor: Colors.red,
                              ));
                            }else if(password.text == null || password.text.isEmpty){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Password is Required"),
                                backgroundColor: Colors.red,
                              ));
                            }else if(!Utils.validateStructure(password.text)) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Password must contains atleast one lower case,Upper case and special characters"),
                                backgroundColor: Colors.red,
                              ));
                            }else{
                              Utils.check_connectivity().then((result){
                                if(result){
                                  var pd= ProgressDialog(context, type: ProgressDialogType.Normal);
                                  pd.show();
                                  network_operations.Sign_Up(name.text, email.text, password.text).then((response) async{
                                    pd.dismiss();
                                    if(response==null){
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Sign Up Failed"),
                                      ));
                                    }else{
                                      var parsedjson=json.decode(response);
                                      if(parsedjson['isSuccess']==true){
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text("Sign up Sucess"),
                                          backgroundColor: Colors.green,
                                        ));
                                      }else{
                                        if(parsedjson['message']!=null){
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(parsedjson['message']),
                                            backgroundColor: Colors.red,
                                          ));
                                        }else{
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text('Sign Up Failed'),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      }
                                    }
                                  });
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Network not Available'),
                                    backgroundColor: Colors.red,
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
                            child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}