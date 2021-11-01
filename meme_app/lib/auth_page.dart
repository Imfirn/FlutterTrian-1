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
    return  Scaffold(
        
        appBar: AppBar(
        // backgroundColor: Colors.pinkAccent,      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(250),bottomRight: Radius.circular(250))
        ),
        flexibleSpace: ClipRRect(
           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(250),bottomRight: Radius.circular(250)),
          child: Container(
            
          decoration: BoxDecoration(
            
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [ 
              Color(0xFFEA93A1),
              Color(0xFFF596E5),
              Color(0xFF8B8DD1),
              Color(0xFF965EB8),],
              
            )

          ),

        ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
             // ignore: prefer_const_literals_to_create_immutables
             children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0,right:80.0),
                child: Text('Welcome to',style: TextStyle(fontSize: 26,fontWeight:FontWeight.w300,color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,right:80.0),
                child: Text('Meme Generator app',style: TextStyle(fontSize: 26,fontWeight:FontWeight.bold,color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,right:80.0),
                child: Text('please login or sign in',style: TextStyle(fontSize: 26,fontWeight:FontWeight.w300,color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,right:80.0),
                child: Text('before use this app',style: TextStyle(fontSize: 26,fontWeight:FontWeight.w300,color: Colors.white)),
              ),
              
              SizedBox(height: 140,)
            ],


          )

          )

        ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                
                  child: TextField(
                    decoration: InputDecoration( 
                    labelText: "Email",
                    hintText: 'Insert your email here',
                    fillColor: Color(0xFFE3E3E3),
                        filled: true,
                       enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                          ,borderSide: BorderSide(color:Colors.transparent),                          
                          ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20)
                          ,borderSide: BorderSide(color:Colors.grey),
                    )),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                   padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
                 
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                         labelText: "Password",
                    hintText: 'Insert your password here',
                    fillColor: Color(0xFFE3E3E3),
                        filled: true,
                       enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                          ,borderSide: BorderSide(color:Colors.transparent),                          
                          ),
                    focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20)
                          ,borderSide: BorderSide(color:Colors.grey),
                    )),
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
                        await auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SelectMeme()));
                        print("Login");
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF594F4F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                    ),
                    icon: Icon(Icons.login),
                    label: Text(
                      "Login",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),
                      
                    )),
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
                    },style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      
                    ),
                    icon: Icon(Icons.add,color: Color(0xFF594F4F),),
                    label: Text(
                      "Register",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color:Color(0xFF594F4F)),
                    )),
                
              ],
            ),
          )
    );
  }
}
