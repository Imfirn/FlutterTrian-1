// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/auth_page.dart';
import 'package:meme_app/editmeme.dart';
import 'package:meme_app/first_page.dart';
import 'meme_data.dart';

class SelectMeme extends StatefulWidget {
  const SelectMeme({Key? key}) : super(key: key);

  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  int maxItem = 20;
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_rounded, color: Colors.white),
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>Firstpage()));
            },
          )
        ],
        title: Text('Select meme',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 6,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color(0xFFEA93A1),
                Color(0xFFF596E5),
                Color(0xFF8B8DD1),
                Color(0xFF965EB8),
              ],
            )),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: [
                for (var i = 0; i < maxItem; i++)
                  RawMaterialButton(
                    onPressed: () {
                      print(memeName[i]);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return EditMeme(imageName: memeName[i]);
                        },
                      ));
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 4) / 3,
                      height: (MediaQuery.of(context).size.width - 4) / 3,
                      child: Image.asset(
                        'assets/meme/${memeName[i]}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            ),
            maxItem < memeName.length
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        if (maxItem + 20 < memeName.length) {
                          maxItem += 20;
                        } else {
                          maxItem = memeName.length;
                        }
                      });
                    },
                    child: Text(
                      'load more',
                      style: TextStyle(
                          color: Color(0xFF965EB8),
                          decoration: TextDecoration.underline),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
