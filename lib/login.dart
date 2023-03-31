import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'network_utils/api.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  var orientation, size, height, width;
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    void _login() async {
      String username = usernameController.text;
      String password = passwordController.text;

      var data = {
        'uname': username,
        'password': password,
      };

      var res = await Network().authData(data, 'login');
      var body = json.decode(res.body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                Form(
                    key: _formKey,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: usernameController,
                                validator: (value) {
                                  if (value == null || value.length < 3) {
                                    return 'Please enter a valid username';
                                  }
                                  return null;
                                },
                                key: ValueKey('username'),
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                ),
                                onSaved: (value) {
                                  username = value as String;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 7 characters';
                                  }
                                  return null;
                                },
                                key: ValueKey('password'),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                                obscureText: true,
                                onSaved: (value) {
                                  password = value as String;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20.0),
                    child: const TextButton(
                      onPressed: null,
                      child: Text('Forgot password?',
                          style: TextStyle(color: Colors.white)),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                        width: width / 2 + width / 3,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              minimumSize: MaterialStatePropertyAll<Size>(
                                const Size.fromHeight(50),
                              ),
                              shape: MaterialStatePropertyAll<StadiumBorder>(
                                  StadiumBorder())),
                          onPressed: _login,
                          child: Text('Sign in',
                              style: TextStyle(
                                  color: Colors.pinkAccent, fontSize: 20.0)),
                        ))),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: const Text('New to this app? Sign up',
                          style: TextStyle(color: Colors.white)),
                    )),
              ],
            )));
  }
}
