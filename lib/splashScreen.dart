import 'package:ar_face_filter_app/cameraWithMaskFilterScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: cameraWithMaskFilterScreen(),
      title: Text("AR  Face  Masks  App",
      style: TextStyle(
        fontSize: 45,
        color: Colors.deepPurpleAccent,
        fontFamily: "Signatra",
      ),
      ),
      image: Image.asset("images/icon.png"),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.deepPurple,
      loadingText: Text("WELCOME!",
      style: TextStyle(
        color: Colors.deepPurpleAccent,
        fontSize: 16.0,
        fontFamily: "Brand Bold"
      ),
      ),
    );
  }
}
