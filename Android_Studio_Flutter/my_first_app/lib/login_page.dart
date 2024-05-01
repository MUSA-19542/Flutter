import 'dart:js';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:textfields/textfields.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/chat_page.dart';
import 'package:my_first_app/utils/spaces.dart';
import 'package:my_first_app/utils/textfield_styles.dart';
import 'package:my_first_app/widgets/login_text_field.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _mainUrl = "https://Hitman.com";

  LoginPage({Key? key}) : super(key: key);

  void loginuser(context) {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print('user name = ' + usernameController.text);
      print('password = ' + passwordController.text);
      // Navigator.pushNamed(
      Navigator.pushReplacementNamed(
          context,'/chat', arguments:usernameController.text
      );
      print('Logged In');
    } else {
      print('not Successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              //<================================================Header==================================================================================>
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Let\'s sign You In ==>",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Welcome back! \n You\'ve Been Missing',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black),
                ),

                Image.network(
                  'data:image/png;base64,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',
                  height: 200,
                ),

                verticalSpacing(24),

                //<================================================UserName==================================================================================>
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      LoginTextField(
                        hintText: "Enter Your UserName",
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 5) {
                            return "Your Username Must Be More Than 5 characters";
                          } else if (value != null && value.isEmpty) {
                            return " ! warning !  Your Username Is Empty !";
                          }
                          if (value == null) {
                            return " ! warning !  Your Username Is Null !";
                          }
                          return null;
                        },
                        controller: usernameController,


                      ),
                    ],
                  ),
                ),
                verticalSpacing(24),

                //<================================================Password==================================================================================>

                LoginTextField(
                  controller: passwordController,
                  // onChanged: (value) {
                  //   print('value :$value');
                  // },
                  hintText: 'Add Your Password',
                  hasAsteriks: true,




                ),
                //<================================================Email Button==================================================================================>


                //<================================================Elevated Button==================================================================================>



                ElevatedButton(
                  onPressed: () {
                    loginuser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF8D0900),
                    ),
                  ),
                ),

                //<================================================Gesture==================================================================================>
                GestureDetector(
                  onTap: () async{
                    if (!await launch('$_mainUrl')) {
                      throw Exception('Could not launch this');
                    }
                    print('Clicked');
                  },
                  onDoubleTap: () {
                    //todo: Navigate To Browser
                    print('Double Tap');
                  },
                  onLongPress: () {
                    //todo: Navigate To Browser
                    print('Long Press');
                  },
                  child: Column(children: [
                    Text('Find Us on'),
                    Text(
                      '$_mainUrl',
                      style: TextStyle(color: Color(0xFF8D0900)),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaButton.instagram(size:30,color:Color(0xFF8D0900),url:"https://www.instagram.com/hitman_official"),
                    SocialMediaButton.twitter(size:30,color:Color(0xFF8D0900),url:"https://twitter.com/IOInteractive?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor"),
                    SocialMediaButton.facebook(size:30,color:Color(0xFF8D0900),url:"https://www.facebook.com/hitman/"),
                    SocialMediaButton.linkedin(size:30,color:Color(0xFF8D0900),url:"https://www.linkedin.com/company/iointeractive/"),

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
