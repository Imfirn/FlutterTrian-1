// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:meme_app/auth_page.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

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
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [              
              // SizedBox(height:200,),                             
                    Stack(
                      children: [
                        Container(
                          padding:EdgeInsets.only(left: 40,top:70) ,
                          child: 
                           Text('Let’s tell your',style: TextStyle(fontSize: 26,fontWeight:FontWeight.w300,color: Colors.white ),),                           
                        ),
                        Container(
                          padding:EdgeInsets.only(left: 40,top:110) ,
                          child: 
                           Text('Feeling',style: TextStyle(fontSize: 26,fontWeight:FontWeight.bold,color: Colors.white),),                           
                        ),
                        Container(
                          padding:EdgeInsets.only(left: 40,top:150) ,
                          child: 
                           Text('Throung your',style: TextStyle(fontSize: 26,fontWeight:FontWeight.w300,color: Colors.white),),                           
                        ),
                        Container(
                          padding:EdgeInsets.only(left: 40,top:190) ,
                          child: 
                           Text('Meme',style: TextStyle(fontSize: 26,fontWeight:FontWeight.bold,color: Colors.white),),                           
                        ),
                        Container(
                        padding: EdgeInsets.only(left: 100,top:100),
                        child:     
                          // Image.asset('auth_assets/women.png',width: 400,height: 500,)
                         AnimateImage(),  
                      ),                      
                        Container(   
                        padding: EdgeInsets.only(left: 300,top:115),                  
                        child:              
                        Image.asset('auth_assets/face1.png',width: 85,height: 85,) 
                    ),
                      Container(   
                        padding: EdgeInsets.only(left: 55,top:300),                  
                        child:              
                        Image.asset('auth_assets/face3.png',width: 80,height: 80,)
                       
                    ),
                     Container(   
                        padding: EdgeInsets.only(left: 30,top:440),                  
                        child:              
                        Image.asset('auth_assets/face2.png',width: 120,height: 120,) 
                    ),
                    Container(
                        alignment:AlignmentDirectional.center ,
                        padding: EdgeInsets.only(top:640),                        
                        child: 
                        TextButton(child: 
                        Text('Make your meme',style: TextStyle(color: Color(0xFF965EB8),fontWeight:FontWeight.w300,fontSize: 16))
                        ,onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AuthPage()));
                        },
                        style: TextButton.styleFrom(backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        
                        )),
                    ),
                      ],
                    
                    )                  
              
            ],
            
          )
        ),
    );
  }
}

class AnimateImage extends StatefulWidget {
  const AnimateImage({ Key? key }) : super(key: key);

  @override
  _AnimateImageState createState() => _AnimateImageState();
}

class _AnimateImageState extends State<AnimateImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this,
  duration: const Duration(seconds:3),
  )..repeat(reverse: true);
  // ignore: prefer_final_fields
  late Animation<Offset> _animation =Tween(
    begin: Offset.zero,
    end: Offset(0,0.09),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
 

  @override
  void dispose() {
    if(_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
        child: Image.asset('auth_assets/women.png',width: 400,height: 500,)
    );
  }
}
