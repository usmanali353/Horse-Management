import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/Utils.dart';
import 'package:horse_management/screens/reset_password_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController email;

  @override
  void initState() {
    email=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollview(email: email),
    );
  }
}

class scrollview extends StatelessWidget {
  const scrollview({
    Key key,
    @required this.email,
  }) : super(key: key);

  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/horse22.jpg"),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
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
                      Text("Forgot Password",style: TextStyle(
                          color: Colors.teal,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      )),
                      Text("Please enter your email",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25
                      )),
                      SizedBox(height: 90),
                      TextField(
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
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                           if(email.text.isEmpty||email.text==null){
                             Scaffold.of(context).showSnackBar(SnackBar(
                               content: Text("Email is Required"),
                               backgroundColor: Colors.green,
                             ));
                           }else if(!Utils.validateEmail(email.text)){
                             Scaffold.of(context).showSnackBar(SnackBar(
                               content: Text("Email is Invalid"),
                               backgroundColor: Colors.green,
                             ));
                           }else{
                             Utils.check_connectivity().then((result){
                               if(result){
                                 var pd= ProgressDialog(context, type: ProgressDialogType.Normal);
                                 pd.show();
                                 network_operations.Forgot_Password(email.text).then((response){
                                   pd.dismiss();
                                   if(response==null){
                                     Scaffold.of(context).showSnackBar(SnackBar(
                                       content: Text("Email Does not Exist in our Record"),
                                       backgroundColor: Colors.red,
                                     ));
                                   }else{
                                     var parsedjson=json.decode(response);
                                     if(parsedjson['isSuccess']==true){
                                       Scaffold.of(context).showSnackBar(SnackBar(
                                         content: Text("Your Email is Verified"),
                                         backgroundColor: Colors.green,
                                       ));
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>reset_password_screen(email.text,parsedjson['result']['token'])),(Route<dynamic> route) => false);
                                     }else{
                                       Scaffold.of(context).showSnackBar(SnackBar(
                                         content: Text("Email Does not Exist in our Record"),
                                         backgroundColor: Colors.red,
                                       ));
                                     }
                                   }

                                 });
                               }else{
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   content: Text("Network not Available"),
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
                            child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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