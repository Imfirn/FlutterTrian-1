// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Testpage extends StatelessWidget {
  const Testpage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,      
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
      );
   
  }
}