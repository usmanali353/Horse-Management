import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState() => _SplashScreen();

  }


class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 650,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: -370,
                  right: -340,
                  bottom: 0,
                  child: Image.asset("assets/ss5.jpg",
                  fit: BoxFit.contain,
                  width: 820,
                    height: 1470,
                  ),
                ),
                Positioned(left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: 340,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withOpacity(.8),
                        Colors.tealAccent.withOpacity(.05),
                      ]
                    ),

                  ),
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
