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
  double xTop=60,yTop=30,xBtm=60,yBtm=200;
  double size=52;
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
              DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
          ){
            return Image.asset('assets/meme/${widget.imageName}.jpg');
          },
          onAcceptWithDetails:(DragTargetDetails<String>details) 
          {
              print(details.data);
              print(details.offset);
              var newX=details.offset.dx-MediaQuery.of(context).padding.left;
              var newY=details.offset.dy-MediaQuery.of(context).padding.top-AppBar().preferredSize.height;
              setState(() {
                if(details.data=='top')
                {
                  xTop=newX;
                  yTop=newY;
                }else if(details.data=='bottom'){
                  xBtm=newX;
                  yBtm=newY;
                }
              });
          }
          ,
           )
              ,              
              Positioned(
                top: yTop,
                left: xTop,
                child: 
                Draggable<String>(
                  data: 'top',
                  child: buildStrokeText(topText,size),
                  feedback: buildStrokeText(topText,size),
                  childWhenDragging: Container(),
                ),
              ),
              Positioned(
                top: yBtm,
                left: xBtm,
                child: Draggable<String>(
                  data: 'bottom',
                  child: buildStrokeText(bottmText,size),
                  feedback: buildStrokeText(bottmText,size),
                  childWhenDragging: Container(),
                ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(child: Text('+',style: TextStyle(color: Colors.black,fontSize: 25)),
                      onPressed: (){
                        print('Expand');
                        setState(() {
                          
                          print(size);
                          if(size <= 110){size+=1.0; }
                          
                        });
                      },style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.amber)),),
                      TextButton(child: Text('-',style: TextStyle(color: Colors.black,fontSize: 25)),
                      onPressed: (){
                        print('Reduce');
                        setState(() {
                          
                          print(size);
                          if(size>=10){size-=1.0; }
                        });
                      },style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.amber)),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    child: Text('Export',style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      print('Export');
                      exportMeme();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black45)
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

  Stack buildStrokeText(String text,double size) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: size,
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
