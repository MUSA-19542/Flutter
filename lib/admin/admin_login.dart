import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/pages/home_admin.dart';
import 'package:fod/widget/widget_support.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  Color red= Color(0xFFE50914);
  Color golden =Color(0xFFE2A808);
  Color grey =Color(0xFF212121);

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasscontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
               Container(
                margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/2),
                 padding: EdgeInsets.only(top: 45.0,left: 20.0,right: 20.0),
                 height: MediaQuery.sizeOf(context).height,
                 width: MediaQuery.sizeOf(context).width,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(colors:
                   [golden,Colors.red],begin:Alignment.topLeft,end:Alignment.bottomRight
                   ),
                   borderRadius: BorderRadius.vertical(
                     top: Radius.elliptical(MediaQuery.of(context).size.width, 110),
                   ),
                 ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,top:60),
                child: Form(key: _formkey,
                    child:Column(
                  children: [
                    Text("Let's start \n   Admin ",style:AppWidget.SemiboldTextFieldStyleCustom(golden, 25),),
                    SizedBox(height: 30.0),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child:Container(
                      height: MediaQuery.of(context).size.height/2,
                        decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
          
          
                        child: Column(children: [
                          SizedBox(height: 50.0,),
          
                          Container(
                            padding:EdgeInsets.only(left: 20.0,top:5.0,bottom:5.0) ,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration:BoxDecoration(
                              border:Border.all(color:golden,width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
          
                            child:Center(
          
                              child:TextFormField(
                                style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 14),
                                controller: usernamecontroller,
                                validator: (value)
                                {
                                  if(value==null || value.isEmpty)
                                    {
                                      return 'Please Enter UserName';
                                    }
                                },
                                decoration: InputDecoration(border: InputBorder.none,hintText: "User Name ",
                                    hintStyle: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15)),
                              ),
                            ),
                            
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            padding:EdgeInsets.only(left: 20.0,top:5.0,bottom:5.0) ,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration:BoxDecoration(
                              border:Border.all(color: golden,width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
          
                            child:Center(
                              child:TextFormField(
                                style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 14),
                                controller: userpasscontroller,
                                validator: (value)
                                {
                                  if(value==null || value.isEmpty)
                                  {
                                    return 'Please Enter Password';
                                  }
                                },
                                decoration: InputDecoration(border: InputBorder.none,hintText: "Password",
                                    hintStyle: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15)),
                              ),
                            ),
          
                          ),
                          SizedBox(height:40.0),
          
                         GestureDetector(
                           onTap: (){
                             LoginAdmin();
                           },
                           child: Container(
                             padding: EdgeInsets.symmetric(vertical: 10),
                             margin: EdgeInsets.symmetric(horizontal:  20),
                             width:MediaQuery.sizeOf(context).width,
                             decoration: BoxDecoration(
                               color: Colors.black,borderRadius: BorderRadius.circular(50),
                               border: Border.all(color: golden,width: 2),
                             ),
                             child: Center(child: Text("Log In",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 20),)),
                           ),
          
                         )],),
          
          
                      ),
                    ),
                  ],
                ),),
              ),
            ],
          
          ),
        ),
      ),
    );
  }

  LoginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) => {
    snapshot.docs.forEach((result) {
   if(result.data()['id']!= usernamecontroller.text.trim()){
 popup("You Id Is Not Correct", 17);
   }
   else if(result.data()['password']!= userpasscontroller.text.trim()){
   popup("You Password Is Not Correct", 17);

   }
   else
   {
     Route route =MaterialPageRoute(builder: (context)=>HomeAdmin());
     Navigator.pushReplacement(context, route);
   }

    }),
    });


  }


  void popup(String txt,double size) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFFE50914), // Netflix red
        content: Row(
          children: [
            Icon(
              Icons.warning,
              color: Colors.white,
            ),
            SizedBox(width: 8), // Add spacing between icon and text
            Text(
              txt,
              style: TextStyle(fontSize: size, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

}
