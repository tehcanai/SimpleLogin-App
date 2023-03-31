import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/home.dart';
import 'init.dart';
import 'login.dart';
import 'splash_screen.dart' show SplashScreen;
import 'landing.dart' show LandingScreen;
import 'login.dart' show LoginScreen;
import 'register.dart' show RegisterScreen;
import 'register.dart' show Registerv2Screen;

void main() {
  runApp(MaterialApp(
    title: "Flutter App",
    home: InitializationApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class InitializationApp extends StatelessWidget {
  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization',
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LandingScreen();
          } else {
            return SplashScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
