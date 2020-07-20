import 'package:flutter/material.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:horse_management/components/customButton.dart';
import 'package:horse_management/components/customButtonAnimation.dart';
import 'loginScreen.dart';
import 'signUpScreen.dart';
import 'forgot_password_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/crop.jpg", fit: BoxFit.cover),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.7),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(2.4,Text("Best management system for", style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 2
                    ))),
                    FadeAnimation(2.6,Text(".horse", style: TextStyle(
                        color: Colors.teal,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ))),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(2.8,CustomButton(
                      label: "Sign up",
                      background: Colors.transparent,
                      fontColor: Colors.teal,
                      borderColor: Colors.teal,
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                      } ,
//                      child: SignUpScreen(),
                    )),
                    SizedBox(height: 20),
                    FadeAnimation(3.2,CustomButtonAnimation(
                      label: "Sign In",
                      backbround: Colors.teal,
                      borderColor: Colors.teal,
                      fontColor: Color(0xFFF001117),
                      child: LoginScreen(),
                    )),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                      }
                      ,
                      child: Center(
                        child:  FadeAnimation(3.4,Text("Forgot password?", style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline
                        ),
                        ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}