import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'landing.dart';
import 'network_utils/api.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  var orientation, size, height, width;
  late String name, email;
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
        email = user['email'];
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
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "$name's Profile",
          style: TextStyle(
              color: Colors.black54, fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
      ),
      body: Container(
        width: width,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Icon(
              Icons.person,
              size: 300,
              color: Colors.grey,
            ),
            Text("$name",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
            Text("$email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.pinkAccent,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.pinkAccent,
                size: 30,
              ),
              onPressed: () {},
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
          backgroundColor: Colors.white),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
