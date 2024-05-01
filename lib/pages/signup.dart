
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/shared_pref.dart';
import '../widget/widget_support.dart';
import 'bottomnav.dart';
import 'home.dart';
import 'login.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email="",password="",name="";

  TextEditingController namecontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();
  TextEditingController repasswordcontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
  String? isLoggedIn="false";
  SharedPreferenceHelper sh = SharedPreferenceHelper();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  void checkLoginStatus() async {

    isLoggedIn = await sh.getLoginKey() ;
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }


  registeration() async {
    // Validate form inputs


    if(password!=null)
      try {
        // Attempt to create a new user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Registration successful, navigate to home screen
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Registration Successful!",
            style: TextStyle(fontSize: 20.0),
          ),
        ));

        String Id=randomAlphaNumeric(10);
        Map<String,dynamic> addUserInfo={
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Wallet":"0",
          "Id":Id,
        };

        print(" User Id ${Id}   User Name ${namecontroller.text} ");

        await DataBaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPreferenceHelper ().saveUserName(namecontroller.text);
        await SharedPreferenceHelper ().saveUserEmail(emailcontroller.text);
        await SharedPreferenceHelper ().saveUserWallet('0');
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveLoginKey("true");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase authentication errors
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "The provided password is too weak!",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text(
              "An account with this email already exists!",
              style: TextStyle(fontSize: 20.0),
            ),
          ));
        }
      } catch (e) {
        // Handle other errors
        print(e.toString());
      }

  }



  Icon key=Icon(Icons.key);
  bool _obsecureText=true;
  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == "false") {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
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
                              Text("Sign Up",
                                style: AppWidget.SemiboldTextFieldStyle(),),
                            ],),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 20, right: 20),
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
                                    .height / 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                    color: Color(0xFFF14921), // Border color
                                    width: 0.9, // Border width
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0),


                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        controller: namecontroller,
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Correct Name Sir ! ";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Name',
                                          hintStyle: AppWidget
                                              .SemiboldTextFieldStyle(),
                                          prefixIcon: Icon(
                                              Icons.person_2_outlined),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 2),
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),),
                                      ),
                                      SizedBox(height: 5,),
                                      TextFormField(
                                        controller: emailcontroller,
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Correct Email Sir ! ";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: AppWidget
                                              .SemiboldTextFieldStyle(),
                                          prefixIcon: Icon(
                                              Icons.email_outlined),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 2),
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),),
                                      ),
                                      SizedBox(height: 5,),
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Correct Password Sir ! ";
                                          }
                                          return null;
                                        },
                                        controller: passwordcontroller,
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
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),),
                                      ),

                                      SizedBox(height: 5,),
                                      TextFormField(
                                        controller: repasswordcontroller,
                                        validator: (value) {
                                          if (value == null) {
                                            return "Please Enter Correct Password Sir ! ";
                                          }
                                          else if (value !=
                                              passwordcontroller.text) {
                                            return "Passwords Donot Match";
                                          }
                                          return null;
                                        },
                                        obscureText: _obsecureText,
                                        decoration: InputDecoration(
                                          hintText: 'Re-Enter-Password',
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
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),),
                                      ),
                                      SizedBox(height: 5.0,),
                                      Container(
                                          alignment: Alignment.topRight,
                                          child: Text("Forgot Password ? ",
                                              style: AppWidget
                                                  .LightlessTextFieldStyle())),
                                      SizedBox(height: 10.0,),

                                      GestureDetector(
                                        onTap: () async {
                                          if (_formkey.currentState != null &&
                                              _formkey.currentState!
                                                  .validate()) {
                                            setState(() {
                                              email = emailcontroller.text;
                                              name = namecontroller.text;
                                              password =
                                                  passwordcontroller.text;
                                              print(
                                                  "<================Signup pressed ===================================>");
                                              registeration();
                                            });
                                          }
                                          else {
                                            print(
                                                "<================Failed Validation ===================================>");
                                            failed();
                                          }
                                        },
                                        child: Material(
                                          elevation: 5.0,
                                          borderRadius: BorderRadius.circular(
                                              50),
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Color(0xffff5722),
                                                borderRadius: BorderRadius
                                                    .circular(50),),
                                              child: Center(child: Text(
                                                "SIGN UP", style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Poppins1',
                                                  fontWeight: FontWeight
                                                      .w500),))
                                          ),
                                        ),

                                      ),
                                      SizedBox(height: 5,),

                                    ],),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LogIn()));
                            },
                            child: Text(
                              "Already Have An Account ? LogIn",
                              style: AppWidget.SemiboldTextFieldStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),

          ),
        ),
      );
    }
    else
    {
      return  BottomNav();
    }
  }

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
  void failed()
  {
    // Registration successful, navigate to home screen
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "Registration UnSuccessful!",
        style: TextStyle(fontSize: 20.0),
      ),
    ));

  }
}
