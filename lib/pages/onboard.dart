import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/pages/signup.dart';
import 'package:fod/widget/widget_support.dart';
import '../widget/content_model.dart';

//<============================Module 1=============================>
// This module represents the onboarding screen of the application.
class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex=0;
  late PageController _controller;

  @override
  void initState() {
    _controller=PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller:_controller,
                itemCount: contents.length,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex=index;
                  });
                },
                itemBuilder: (_,i)
                {
                  return Padding(padding: EdgeInsets.all(20),
                      child: Column(children:[
                        Image.asset(contents[i].image,height: 300,
                          width: MediaQuery.sizeOf(context).width/2.5,fit: BoxFit.fill,),
                        SizedBox(height: 40,),
                        Text(contents[i].title,style: AppWidget.PriceTextFieldStyle(),),
                        SizedBox(height: 20,),
                        Text(contents[i].description,style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 14),),

                      ],)
                  );
                }),
          ),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length, (index)=>
                  buildDot(index,context)
              ),
            ),
          ),

          GestureDetector(
            onTap:()
            {
              if(currentIndex == contents.length-1)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));
              }
              else
              {
                _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
              }
            },
            child: Container(
                decoration: BoxDecoration(color:Color(0xffff5722), borderRadius: BorderRadius.circular(10),),
                height: 60,
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: Center(child: Text(
                  currentIndex== contents.length -1? "Start":"Next"
                  ,style:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),))
            ),
          )

        ],
      ),
    );
  }


  Container buildDot(int index,BuildContext context)
  {
    return Container(
      height:10.0,
      width: currentIndex ==index ?18:7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),color:Colors.black38
      ),
    );
  }
}

