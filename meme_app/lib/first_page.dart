// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
class Firstpage extends StatefulWidget {
  const Firstpage({ Key? key }) : super(key: key);

  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return Container(    
        
        decoration: BoxDecoration(
         
          gradient: RadialGradient(
          center: Alignment.topLeft, // near the top right
          radius: 2,
          colors: <Color>[
            Color(0xFFEA93A1), 
            Color(0xFFF596E5),
            Color(0xFF8B8DD1),
            Color(0xFF965EB8),  
          ],
          // stops: <double>[0.4, 1.0],
  )
        ),
        child: Scaffold(
          
          backgroundColor: Colors.transparent,
          body:Column(
          
            children: [
              Container(
                padding: EdgeInsets.only(left: 55),
                child: Text(
                'Let’s tell your',style:TextStyle(fontSize:16,color: Colors.white,height: 10 ),
              ),
                )
              
            ],
          )
          
        ),
       
        
      );
    
  }
}