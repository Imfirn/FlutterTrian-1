// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'dart:ui'as ui;
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class EditMeme extends StatefulWidget {
  final String imageName;
  const EditMeme({Key? key, required this.imageName}) : super(key: key);

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends State<EditMeme> {
  String topText ='',bottmText ='';
  GlobalKey globalKey = new GlobalKey();
   @override
  void initState(){
    super.initState();
    topText='Top text';
    bottmText='Bottom text';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Add TexT',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(        
        children: [
          RepaintBoundary(
          key:globalKey,
          child:Stack(
            children: [
              Image.asset('assets/meme/${widget.imageName}.jpg'),
              Positioned(
                top: 30,
                left: 60,
                child: buildStrokeText(topText),
              ),
              Positioned(
                top: 230,
                left: 60,
                child: buildStrokeText(bottmText),
              ),
            ],
          ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                SizedBox(height: 24),
                TextFormField(
                  onChanged: (text){
                    setState(() {
                      topText=text;
                    });
                  },decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    filled: true,
                    fillColor: Colors.amberAccent,
                    hintText: 'Top text',
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  onChanged: (text){
                    setState(() {
                      bottmText=text;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    filled: true,
                    fillColor: Colors.amberAccent,
                    hintText: 'Bottom text',
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  child: TextButton(
                    child: Text('Export',style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      print('Export');
                      exportMeme();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)
                    ),
                ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack buildStrokeText(String text) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

  void exportMeme() async {
    try{
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();

    final directory = (await getApplicationDocumentsDirectory()).path;

    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngByte = byteData.buffer.asUint8List();
    File imageFile = File('$directory/meme.png');
    imageFile.writeAsBytesSync(pngByte);

    Share.shareFiles(['$directory/meme.png']);
  }catch(e){

  }

  }
}
