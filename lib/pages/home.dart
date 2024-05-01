//<============================module 1=============================>
// This module contains the code for the Home screen of the application.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/pages/details.dart';
import 'package:fod/service/database.dart';
import 'package:fod/widget/widget_support.dart';

import 'bottomnav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //<============================module 2=============================>
  // Variables to manage the state of food categories and food items.
  bool icecream = false, burger = false, pizza = false, salad = false;
  Stream? fooditemsfoodStream;

  //<============================module 3=============================>
  // Color variables used in the Home screen.
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFff5c30);

  @override
  void initState() {
    super.initState();
    //<============================module 4=============================>
    // Call the 'ontheload' function to load food items when the screen initializes.
    ontheload();
  }

  //<============================module 5=============================>
  // Fetch food items from Firestore and update the 'fooditemsfoodStream'.
  ontheload() async {
    DataBaseMethods db = DataBaseMethods();
    fooditemsfoodStream = await db.getFoodItem("Pizza Sliders");
    setState(() {});
  }

  //<============================module 6=============================>
  // Widget to display all food items horizontally.
  Widget allItems() {
    return StreamBuilder(
        stream: fooditemsfoodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Recycle(ds);
              })
              : CircularProgressIndicator();
        });
  }

  //<============================module 7=============================>
  // Widget to display all food items vertically.
  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemsfoodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return RecycleVertical(ds);
              })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.black,
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Welcome !", style: AppWidget.boldTextFieldStyleCustom(Colors.white)),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.deepOrange),
                  )
                ],
              ),
              SizedBox(height: 18.0),
              Text("Delicious Food", style: AppWidget.HeadlineTextFieldStyleCustom(19, Colors.white)),
              SizedBox(height: 5.0),
              Text("Discover and Get Great Food", style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 16)),
              SizedBox(height: 20.0),
              Container(
                color: Colors.black,
                margin: EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 270.0,
                      child: allItems(),
                    ),
                    SizedBox(width: 5.0),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Container(
                    height: 500,
                    child: allItemsVertically(),
                  ),
                ],
              ),
              SizedBox(height: 50), // Added for extra space at the bottom
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNav(),
    );
  }

  //<============================module 8=============================>
  // Widget to display food items vertically.
  Widget RecycleVertical(DocumentSnapshot ds) {
    return Container(
      margin: EdgeInsets.all(10.0),
      color: Colors.black,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(
                  detail: ds["Detail"],
                  name: ds["Name"],
                  price: ds["Price"],
                  image: ds["Image"],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.9, color: golden),
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            ds["Image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        ds["Name"],
                        style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "Honey Goat Cheese",
                        style: AppWidget.LightlessTextFieldStyleCustom(grey2, 13),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "\$ " + ds["Price"],
                        style: AppWidget.PriceTextFieldStyle(),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //<============================module 9=============================>
  // Widget to display food categories.
  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemsfoodStream = await DataBaseMethods().getFoodItem("Flavoured Ice Cream");
            setState(() {});
          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/ice-cream.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.deepOrange : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Added SizedBox for spacing
        GestureDetector(
          onTap: () async {
            pizza = true;
            icecream = false;
            salad = false;
            burger = false;
            fooditemsfoodStream = await DataBaseMethods().getFoodItem("Pizza Sliders");
            setState(() {});
          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.deepOrange : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Added SizedBox for spacing
        GestureDetector(
          onTap: () async {
            salad = true;
            icecream = false;
            pizza = false;
            burger = false;
            fooditemsfoodStream = await DataBaseMethods().getFoodItem("Salads");
            setState(() {});
          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/salad.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.deepOrange : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Added SizedBox for spacing
        GestureDetector(
          onTap: () async {
            burger = true;
            icecream = false;
            pizza = false;
            salad = false;
            fooditemsfoodStream = await DataBaseMethods().getFoodItem("Soft Bun Burger");
            setState(() {});
          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/burger.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.deepOrange : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //<============================module 10=============================>
  // Widget to display food items horizontally.
  Widget Recycle(DocumentSnapshot ds) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              detail: ds["Detail"],
              name: ds["Name"],
              price: ds["Price"],
              image: ds["Image"],
            ),
          ),
        );
      },
      child: Container(
        color: Colors.black,
        margin: EdgeInsets.all(4),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.9, color: golden),
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            ds["Image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(ds["Name"], style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15)),
                SizedBox(height: 5.0,),
                Text(" Fresh & Healthy ", style: AppWidget.LightlessTextFieldStyleCustom(grey2, 13)),
                Center(
                  child: Text("\$ " + ds["Price"], textAlign: TextAlign.center, style: AppWidget.PriceTextFieldStyle()),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

