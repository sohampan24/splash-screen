import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splash_screen/screens/login.dart';
import 'package:splash_screen/screens/user_services.dart';
import '../screens/home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>LoginScreen(title:'breakdown buddy')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'lib/assets/logo2.jpg',
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
      ),
    );
  }
}
