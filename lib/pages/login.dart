

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/admin/admin_login.dart';
import 'package:fod/pages/signup.dart';
import 'package:fod/widget/widget_support.dart';

import '../service/shared_pref.dart';
import 'bottomnav.dart';
import 'details.dart';
import 'forgotpassword.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  String email="",password="";
  String? isLoggedIn="false";

//<============================module 2=============================>
  // Initializing variables
  final _formkey =GlobalKey<FormState>();
  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();
  SharedPreferenceHelper sh = SharedPreferenceHelper();

  //<============================module 3=============================>
  // Function to check login status
  void checkLoginStatus() async {

    isLoggedIn = await sh.getLoginKey() ;
    setState(() {});
  }

  //<============================module 4=============================>
  // Function to handle user login
  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      popup("Welcome Back User",15);
      await SharedPreferenceHelper ().saveUserEmail(email);
      await SharedPreferenceHelper().saveLoginKey("true");
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      print("Firebase Authentication Exception: ${e.code}");
      if (e.code == "invalid-credential") {
        popup("No User Registered For The Provided Email Address",10);
      } else if (e.code == "invalid-credential") {
        popup("Wrong Password Provided By User",12);
      }
    } catch (e) {
      print("Other Error: $e");
      // Handle other exceptions here
    }
  }

  //<============================module 5=============================>
  // Icon for password visibility
  Icon key=Icon(Icons.key);
  bool _obsecureText=true;


  //<============================module 6=============================>
  // Widget build function

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == "false") {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFff5c30), Color(0xFFe74b1a)])),
              ),
              Container(
                margin:
                EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 2.75),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                          "images/logo.png",
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2,
                          fit: BoxFit.cover,
                        )
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        )
                        ,),
                      child: Column(children: [
                        Text("Login", style: AppWidget
                            .SemiboldTextFieldStyle(),),
                      ],),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Color(0xFFF14921), // Border color
                              width: 0.9, // Border width
                            ),
                          ),
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),

                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: useremailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Dimag Na Shart Kar Sahi Email Enter Kaar , Bharway !";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(hintText: 'Email',
                                    hintStyle: AppWidget
                                        .SemiboldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),),
                                ),
                                SizedBox(height: 15,),
                                TextFormField(
                                  controller: userpasswordcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Dimag Na Shart Kar Password Enter Kaar , Bharway !";
                                    }
                                    return null;
                                  },
                                  obscureText: _obsecureText,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidget
                                        .SemiboldTextFieldStyle(),
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          changeIcon();
                                        });
                                      },
                                      child: key,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),),
                                ),
                                SizedBox(height: 20.0,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text("Forgot Password ? ",
                                          style: AppWidget
                                              .LightlessTextFieldStyle())),
                                ),
                                SizedBox(height: 30.0,),
                                GestureDetector(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = useremailcontroller.text;
                                        password = userpasswordcontroller.text;
                                      });
                                    }
                                    if (email == "musa" &&
                                        password == "19542") {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminLogin()));
                                    }
                                    userLogin();
                                  },
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Color(0xffff5722),
                                          borderRadius: BorderRadius.circular(
                                              50),),
                                        child: Center(child: Text("Login",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'Poppins1',
                                              fontWeight: FontWeight.w500),))
                                    ),
                                  ),
                                ),

                              ],),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => SignUp()));
                      },
                      child: Text(
                        "Don't Have An Account ? Sign up",
                        style: AppWidget.SemiboldTextFieldStyle(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    else
    {
      return  BottomNav();
    }
  }
  //<============================module 6=============================>
  // Widget build function
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
  //<============================module 8=============================>
  // Function to toggle password visibility

  void changeIcon()
  {

    if(_obsecureText == true)
    {
      key= Icon(Icons.key_off_outlined);
    }
    else if(_obsecureText == false)
    {
      key= Icon(Icons.key);
    }
    _obsecureText=!_obsecureText;
  }
}
