import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/home.dart';
import 'login.dart' show LoginScreen;
import 'network_utils/api.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  var orientation, size, height, width;
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    void _register() async {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      var data = {
        'uname': username,
        'email': email,
        'password': password,
      };

      var res = await Network().authData(data, 'register');
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
                      margin: EdgeInsets.all(30),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                key: ValueKey('email'),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                onSaved: (value) {
                                  email = value as String;
                                },
                              ),
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
                          onPressed: _register,
                          child: Text('Sign up',
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
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text('Have an account already? Sign in',
                          style: TextStyle(color: Colors.white)),
                    )),
              ],
            )));
  }
}
