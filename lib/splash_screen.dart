import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.accessibility_new_outlined,
            color: Color.fromARGB(255, 0, 0, 0),
            size: 50.0,
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 0, 0, 0)))
        ],
      ),
    );
  }
}
