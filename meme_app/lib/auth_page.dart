// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/selectmeme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
        center: Alignment.topLeft, // near the top right
        radius: 2,
        // ignore: prefer_const_literals_to_create_immutables
        colors: <Color>[
          Color(0xFFEA93A1),
          Color(0xFFF596E5),
          Color(0xFF8B8DD1),
          Color(0xFF965EB8),
        ],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Register/Login"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Email", hintText: "Insert your email here"),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Insert your Password here"),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await auth.createUserWithEmailAndPassword(
                          email: _email, password: _password);
                      print("Sign-in");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SelectMeme()));
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  )),
              ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SelectMeme()));
                      print("Login");
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
                  },
                  icon: Icon(Icons.login),
                  label: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          )),
    );
  }
}
