import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/pages/signup.dart';
import 'package:fod/service/auth.dart';
import 'package:fod/service/database.dart';
import 'package:fod/service/shared_pref.dart';
import 'package:fod/widget/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

//<============================Module 1=============================>
// This module represents the profile screen of the application.
class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFff5c30);
  Map<String,dynamic> ?infoGet;

  String? profile,name,email;

  final ImagePicker _picker =ImagePicker();
  File? SelectedImage;
  SharedPreferenceHelper sp = new SharedPreferenceHelper();

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  Widget logout()
  {
    return GestureDetector(
        onTap:(){ AuthMethods().SignOut();
        sp.saveLoginKey("false") ;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
        },
        child: Columns2(Icons.logout_rounded, "Logout Profile")
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: name==null? Container(child:Column(children: [Center(child: CircularProgressIndicator()),logout()],)):SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 45, left: 20, right: 20),
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        border: Border(
                          bottom: BorderSide(width: 3, color: golden),
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 105)),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/6.5), // Adjust height as needed
                        child: Material(
                          color: golden,
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(60),
                          child: ClipOval(
                            child: GestureDetector(
                              onTap: getImage,
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [orange, golden],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: SelectedImage == null
                                    ? (profile == null
                                    ? Image.asset(
                                  "images/boy3.png",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  profile!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ))
                                    : Image.file(
                                  SelectedImage!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(padding: EdgeInsets.only(top: 70.0,),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( "${name}",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white,25 ),),
                            ],
                          )
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                // <============================Module 2=============================>
                // Displays user name.
                Columns(Icons.person_outline_rounded,"Name", "${name}"),
                SizedBox(height: 10,),
                // <============================Module 3=============================>
                // Displays user email.
                Columns(Icons.email_outlined,"Email","${email}"),
                SizedBox(height: 10,),
                // <============================Module 4=============================>
                // Terms and Conditions
                Columns2(Icons.note_alt, "Terms And Conditions"),
                SizedBox(height: 10,),
                // <============================Module 5=============================>
                // Deletes user account.
                GestureDetector(
                    onTap:(){
                      AuthMethods().deleteuser();
                    },child: Columns2(Icons.delete_outline_rounded, "Delete Account")),
                SizedBox(height: 10,),
                // <============================Module 6=============================>
                // Logs out user.
                GestureDetector(
                    onTap:(){ AuthMethods().SignOut();
                    sp.saveLoginKey("false") ;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                    },
                    child: Columns2(Icons.logout_rounded, "Logout Profile")),
              ],
            ),
          ),
        )
    );
  }

  // <============================Module 7=============================>
  // Allows user to pick an image from gallery.
  Future getImage () async{
    var image =await _picker.pickImage(source: ImageSource.gallery);
    SelectedImage = File(image!.path);

    setState(() {
      uploadItem();

    });
  }

  // <============================Module 8=============================>
  // Uploads user profile picture to Firebase storage.
  uploadItem () async
  {
    if(SelectedImage!=null )
    {
      String addId=randomAlphaNumeric(10);

      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(SelectedImage!);
      var downloadUrl= await(await task).ref.getDownloadURL();

      await  SharedPreferenceHelper().saveUserProfile(downloadUrl);
    }
  }

  // <============================Module 9=============================>
  // Retrieves user data from shared preferences.
  getthesharepref() async {
    email=await sp.getUserEmail();
    infoGet= await DataBaseMethods().getUserInfoByEmail(email!);
    profile= await sp.getUserProfile();
    name=infoGet!["Name"];

    setState(() {

    });
  }

  // <============================Module 10=============================>
  // Loads user data.
  onthisload() async {
    await getthesharepref();
    setState(() {
    });
  }

  // <============================Module 11=============================>
  // Creates a container to display user information.
  Widget Columns(IconData icon,String Txt1,String Txt2)
  {
    return
      Container(

        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          borderRadius:BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: golden,width: 0.5),
            ),

            child: Row(
              children: [
                Icon(icon, color: orange, size: 28,),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Txt1,
                            style: AppWidget.LightlessTextFieldStyleCustom(orange, 16.0),
                          ),
                          SizedBox(width: 20.0,),
                          Text(
                            Txt2,
                            style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 13.0),
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

  // <============================Module 12=============================>
  // Creates a container to display user name.
  Widget Columns1(IconData icon,String Txt1,String Txt2)
  {
    return
      Container(

        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          borderRadius:BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: golden,width: 0.5),
            ),

            child: Row(
              children: [
                Icon(icon, color: orange, size: 28,),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Txt1,
                            style: AppWidget.LightlessTextFieldStyleCustom(orange, 16.0),
                          ),
                          SizedBox(width: 20.0,),
                          Text(
                            Txt2,
                            style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 13.0),
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

  // <============================Module 13=============================>
  // Creates a container to display icons and labels.
  Widget Columns2(IconData icon,String Txt2)
  {
    return
      Container(

        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          borderRadius:BorderRadius.circular(10),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: golden,width: 0.5),
            ),
            child: Row(
              children: [
                Icon(icon,color: orange,),
                SizedBox(width: 20.0,),
                Text(Txt2,style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 17.0),)
              ],
            ),
          ),
        ),
      );
  }

  // <============================Module 14=============================>
  // Shows a snackbar with a message.
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
