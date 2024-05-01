import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod/admin/add_food.dart';
import 'package:fod/admin/itemcheck.dart';
import 'package:fod/widget/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

  Color red= Color(0xFFE50914);
  Color golden =Color(0xFFE2A808);
  Color grey =Color(0xFF525252);
  Color grey2 =Color(0xFF949494);
  Color orange=Color(0xFFff5c30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 50.0,left:20.0,right:20.0),

        child: Column(
          children: [
            Center(child: Text("Home Admin",style: AppWidget.HeadlineTextFieldStyleCustom(30, Colors.white),)),
           SizedBox(height: 50.0,),
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10),
              child: Center(

                child: Container(
                  decoration: BoxDecoration(
                    gradient:   LinearGradient(colors:
                      [golden,grey2],begin:Alignment.topLeft,end:Alignment.bottomRight,
                  ),
                    border: Border.all(color: golden,width: 0.9),
                    //color: grey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    children: [
                      Padding(padding:EdgeInsets.all(6.0)
                      ,child:ClipOval(
                            child: Image.asset(
                              "images/food.jpg",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),),
                      SizedBox(width: 30.0,),
                      GestureDetector(
                          onTap :(){
                      Route route =MaterialPageRoute(builder: (context)=>AddFood());
                      Navigator.push(context, route);
                      }
                        ,child: Text("Add Food Item ",style:AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 20) ,)),
                    ],
                  ),
                ),
              ),

            ),

            SizedBox(height: 25,),

            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10),
              child: Center(

                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient:   LinearGradient(colors:
                    [golden,grey2],begin:Alignment.topLeft,end:Alignment.bottomRight,
                    ),
                    border: Border.all(color: golden,width: 0.9),
                    //color: grey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Row(
                    children: [
                      Padding(padding:EdgeInsets.all(6.0)
                        ,child:ClipOval(
                          child: Image.asset(
                            "images/food.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),),
                      SizedBox(width: 30.0,),
                      GestureDetector(
                          onTap :(){
                            Route route =MaterialPageRoute(builder: (context)=>ItemCheck());
                            Navigator.push(context, route);
                          }
                          ,child: Text("Update Food Item ",style:AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 13) ,)),
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),

      ),
    );
  }
}
