// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'dart:ui' as ui;
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
  String topText = '', bottmText = '';
  GlobalKey globalKey = new GlobalKey();
  double xTop = 60, yTop = 30, xBtm = 60, yBtm = 200;
  double size = 52;
  @override
  void initState() {
    super.initState();
    topText = 'Top text';
    bottmText = 'Bottom text';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Text',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
        ),
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
      body: ListView(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Stack(
              children: [
                DragTarget(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Image.asset('assets/meme/${widget.imageName}.jpg');
                  },
                  onAcceptWithDetails: (DragTargetDetails<String> details) {
                    print(details.data);
                    print(details.offset);
                    var newX =
                        details.offset.dx - MediaQuery.of(context).padding.left;
                    var newY = details.offset.dy -
                        MediaQuery.of(context).padding.top -
                        AppBar().preferredSize.height;
                    setState(() {
                      if (details.data == 'top') {
                        xTop = newX;
                        yTop = newY;
                      } else if (details.data == 'bottom') {
                        xBtm = newX;
                        yBtm = newY;
                      }
                    });
                  },
                ),
                Positioned(
                  top: yTop,
                  left: xTop,
                  child: Draggable<String>(
                    data: 'top',
                    child: buildStrokeText(topText, size),
                    feedback: buildStrokeText(topText, size),
                    childWhenDragging: Container(),
                  ),
                ),
                Positioned(
                  top: yBtm,
                  left: xBtm,
                  child: Draggable<String>(
                    data: 'bottom',
                    child: buildStrokeText(bottmText, size),
                    feedback: buildStrokeText(bottmText, size),
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
                SizedBox(height: 40),
                TextFormField(
                    onChanged: (text) {
                      setState(() {
                        topText = text;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Top text',
                        fillColor: Color(0xFFE3E3E3),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey),
                        ))),
                SizedBox(height: 24),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      bottmText = text;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Bottom text',
                      fillColor: Color(0xFFE3E3E3),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      )),
                ),
                SizedBox(height: 24),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text('+',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          print('Expand');
                          setState(() {
                            print(size);
                            if (size <= 110) {
                              size += 1.0;
                            }
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF594F4F))),
                      ),
                      TextButton(
                        child: Text('-',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400)),
                        onPressed: () {
                          print('Reduce');
                          setState(() {
                            print(size);
                            if (size >= 10) {
                              size -= 1.0;
                            }
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF594F4F))),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextButton(
                    child: Text(
                      'Export',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      print('Export');
                      exportMeme();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFCB7C2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack buildStrokeText(String text, double size) {
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
    try {
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
    } catch (e) {}
  }
}
