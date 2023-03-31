import 'package:flutter/material.dart';
import 'register.dart' show RegisterScreen;
import 'login.dart' show LoginScreen;

class LandingScreen extends StatelessWidget {
  var orientation, size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 29, 29, 29),
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.pinkAccent,
                      Colors.lightBlueAccent,
                    ],
                  ),
                ),
                width: width,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: const Icon(
                        Icons.accessibility_new_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 100.0,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 400.0),
                        decoration: ShapeDecoration(shape: StadiumBorder()),
                        child: SizedBox(
                            width: width / 2 + width / 3,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromARGB(255, 255, 255, 255)),
                                  minimumSize: MaterialStatePropertyAll<Size>(
                                    const Size.fromHeight(50),
                                  ),
                                  shape:
                                      MaterialStatePropertyAll<StadiumBorder>(
                                          StadiumBorder())),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text('Sign up',
                                  style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 20.0)),
                            ))),
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        decoration: ShapeDecoration(shape: StadiumBorder()),
                        child: SizedBox(
                            width: width / 2 + width / 3,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromARGB(255, 255, 255, 255)),
                                  minimumSize: MaterialStatePropertyAll<Size>(
                                    const Size.fromHeight(50),
                                  ),
                                  shape:
                                      MaterialStatePropertyAll<StadiumBorder>(
                                          StadiumBorder())),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text('Sign in',
                                  style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 20.0)),
                            ))),
                  ],
                ))));
  }
}
