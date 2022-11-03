import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/text_widget.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () => checkLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.png'), fit: BoxFit.cover)),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: size.height * .4),
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextUtils(
            text: 'My\nGallery',
            fontFamily: 'SegoeUI',
            align: TextAlign.center,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          // SizedBox(
          //   height: size.height * .01,
          // ),
        ],
      ),
    ));
  }

  checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('logged') ?? false;

    if (logged) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen()));
    }

    print(logged);
  }
}
