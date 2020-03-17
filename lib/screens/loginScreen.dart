import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/Home_Page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email,password;


  @override
  void initState(){
    email=new TextEditingController();
    password=new TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollview(email: email, password: password),
    );
  }
}

class scrollview extends StatelessWidget {

  const scrollview({
    Key key,
    @required this.email,
    @required this.password,
  }) : super(key: key);
  final TextEditingController email;
  final TextEditingController password;


  @override
  Widget build(BuildContext context) {
    final focusPassword = FocusNode();
    final focusbutton = FocusNode();
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
                      Text("Sign In to continue",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25
                      )),
                      SizedBox(height: 40),
                      TextFormField(
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
                          FocusScope.of(context).requestFocus(focusPassword);
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
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
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                            suffixIcon: Icon(Icons.https,color: Colors.teal,size: 27,)
                        ),
                        focusNode: focusPassword,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(focusbutton);
                        },

                      ),
                      SizedBox(height: 40),
                      InkWell(

                        onTap: (){
                          if(email.text==null||email.text.isEmpty){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Email is Required"),
                            ));
                          }else if(!Utils.validateEmail(email.text)){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Email Format is Invalid"),
                            ));
                          }
                          else if(password.text==null||password.text.isEmpty){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Password is Required"),
                            ));
                          }else if(!Utils.validateStructure(password.text)){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Password must contain atleast one lower case,Upper case and special characters"),
                            ));
                          }else{
                             Utils.check_connectivity().then((result){
                               if(result){
                                 var pd= ProgressDialog(context, type: ProgressDialogType.Normal);
                                 pd.show();
                                 network_operations.Sign_In(email.text,password.text).then((response_json)async{
                                   pd.dismiss();
                                   if(response_json==null){
                                     Scaffold.of(context).showSnackBar(SnackBar(
                                       backgroundColor: Colors.red,
                                       content: Text("Invalid Username or Password"),
                                     ));
                                   }else{
                                     var parsedJson = json.decode(response_json);
                                     if(parsedJson['isSuccess']==true){

                                       Scaffold.of(context).showSnackBar(SnackBar(
                                         backgroundColor: Colors.green,
                                         content: Text("Login Sucess"),
                                       ));
                                       SharedPreferences  prefs= await SharedPreferences.getInstance();
                                       await prefs.setString("token", parsedJson['result']);
                                       await prefs.setBool("isLogin", true);
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home_Page()),(Route<dynamic> route) => false);
                                     }else{
                                       Scaffold.of(context).showSnackBar(SnackBar(
                                         backgroundColor: Colors.red,
                                         content: Text("Invalid Username or Password"),
                                       ));
                                     }
                                   }
                                 });
                               }else{
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   backgroundColor: Colors.red,
                                     content: Text('Network not Available'),
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
                            child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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