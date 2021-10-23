import 'dart:ui';

import 'package:flutter/material.dart';

class Homepge extends StatelessWidget {
  const Homepge({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title:Text("Home") ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Home",style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Sign Out",style: TextStyle(fontSize: 20)))
          ],
        ),
      ),

      
    );
  }
}