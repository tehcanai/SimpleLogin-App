import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/landing.dart';

import 'network_utils/api.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  var orientation, size, height, width;
  late String name;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['uname'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    void _logout() async {
      var res = await Network().getData('logout');
      var body = json.decode(res.body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('user');
        localStorage.remove('token');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingScreen()));
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          "$name's Feed",
          style: TextStyle(
              color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          color: Color.fromRGBO(0, 0, 0, 0),
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          padding: EdgeInsets.all(10),
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.pinkAccent,
                  size: 30,
                ),
                onPressed: () {}),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.pinkAccent,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            Spacer(flex: 3),
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.pinkAccent,
                  size: 30,
                ),
                onPressed: _logout),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.pinkAccent, size: 30),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
