import 'package:flutter/material.dart';
import 'package:meme_app/editmeme.dart';
import 'meme_data.dart';
class SelectMeme extends StatefulWidget {
  const SelectMeme({ Key? key }) : super(key: key);

  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  int maxItem=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text('Select Meme',style: TextStyle(color: Colors.black),
      ),
      ),
      body: SafeArea(
        child: ListView(
          children: [Wrap(
            spacing: 2,
            runSpacing: 2,
            children: [
              for(var i =0;i<maxItem;i++)
                RawMaterialButton(
                  onPressed: (){
                    print(memeName[i]);
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return EditMeme(imageName: memeName[i]);
                    },));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width-4)/3,
                    height:(MediaQuery.of(context).size.width-4)/3,
                    child: Image.asset('assets/meme/${memeName[i]}.jpg',
                    fit: BoxFit.cover,),
                  ),
                )
            ],
          ),
          maxItem<memeName.length
          ?TextButton(onPressed: (){
            setState(() {
              if(maxItem+20<memeName.length){
                maxItem+=20;

              }else{
                maxItem=memeName.length;
              }
            });
          }, child: Text('load more'),
          ):Container()
          ],
        ),
        ),
    );
  }
}