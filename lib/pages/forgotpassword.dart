import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController mailcontroller = TextEditingController();

  String email = "";
  final _formkey = GlobalKey<FormState>();

  resetPassword() async
  {
    try
        {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          popup("Password Reset Email Has Been Sent", Icon(Icons.email_outlined), Color(0xFFE2A808),13);
        }on FirebaseAuthException catch (e)
    {
      if(e.code=='user-not-found');
      {
        popup("No User Found Against Email !", Icon(Icons.warning_amber),Color(0xFFE50914),17);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
      body:Container(
        child: Column(children: [
          SizedBox(height:70),
          Center(
              child: Image.asset(
                "images/logo.png",
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              )
          ),
          SizedBox(height:70),
         Container(
           alignment: Alignment.topCenter,
           child:Text("Password Recovery ",style:TextStyle( color: Color(0xFFE2A808),fontSize:30.0,fontWeight: FontWeight.bold )),
         ),
          SizedBox(height: 10,),
          Text("Enter Your Email ",style:TextStyle(color:Colors.white,fontSize:20.0 )),
          
          Expanded(
            child: Form(
              key:_formkey,
              child: Padding(
            padding:EdgeInsets.only(left:10.0),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left:10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70,width:2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller:mailcontroller ,
                      validator: (value)
                        {
                          if(value==null || value.isEmpty)
                          {
                            return "Dimag Na Shart Kar Sahi Email Enter Kaar , Bharway !";
                          }
                          return null;
                        },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          color:Colors.white,
                        ),
                        prefixIcon: Icon(Icons.person_2_outlined,color:Colors.white,size:30),

                      ),
                    ),
                  ),
                ),
             SizedBox(height: 50,),
                      GestureDetector(
                        onTap: ()
                        {
                          if(_formkey.currentState!.validate())
                            {
                              setState(() {
                                email=mailcontroller.text;
                              });
                            resetPassword();
                            }
                        },
                        child: Container(
                          width: 140,
                          padding: EdgeInsets.all(10),
                          decoration:BoxDecoration(
                            color:Color(0xFFE50914),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("Send Email",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have An Account ? ",style: TextStyle(fontSize: 18.9,color:Colors.white),),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 18.0,
                              color:Color(0xFFE50914),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],

                ),
                    ],
                  ),
                )

            ),
          ),
          SizedBox(height: 30,),

          

        ],),
      )
    );
  }

  void popup(String txt,Icon icon,Color c,int size) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: c, // Netflix red
        content: Row(
          children: [
              icon ,
            SizedBox(width: 8), // Add spacing between icon and text
            Text(
              txt,
              style: TextStyle(fontSize:size.toDouble(), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

