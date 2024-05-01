//<============================module 1=============================>
// This module contains the code for the details page of a food item.

import 'package:flutter/material.dart';
import 'package:fod/service/database.dart';
import 'package:fod/service/shared_pref.dart';
import 'package:fod/widget/widget_support.dart';

class Details extends StatefulWidget {

  final String image, name, detail, price;
  Details({required this.detail, required this.name, required this.image, required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  //<============================module 2=============================>
  // Color variables used in the details page.
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color orange = Color(0xFFff5c30);

  int count = 1;
  int total = 0;
  String? id;
  String? email;
  Map<String, dynamic>? infoGet;

  @override
  void initState() {
    super.initState();
    _getSharedPref();
    total = int.parse(widget.price);
  }

  _getSharedPref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    infoGet = await DataBaseMethods().getUserInfoByEmail(email!);
    id = infoGet!["Id"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int Price = int.parse(widget.price);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            ),
            SizedBox(height: 20),
            Center(
              child: ClipOval(
                child: Image.network(
                  height: MediaQuery.of(context).size.height / 2.25,
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Column(
                  children: [
                    Text(widget.name, style: AppWidget.HeadlineTextFieldStyleCustom(18, Colors.white)),
                  ],
                ),
                Spacer(),
              ],
            ),
            Row(children: [
              SizedBox(width:200),
              GestureDetector(
                onTap: () {
                  setState(() {
                    count++;
                    total = total + Price;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
              SizedBox(width: 20.0),
              Text(count.toString(), style: AppWidget.HeadlineTextFieldStyleCustom(17, Colors.white)),
              SizedBox(width: 20.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      --count;
                      total = total - Price;
                    } else {
                      _popup("Don't Test me!");
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ),
            ],),
            SizedBox(height: 20),
            Text(
              widget.detail,
              maxLines: 3,
              style: AppWidget.LightlessTextFieldStyleCustom(grey2, 11),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Delivery time", style: AppWidget.boldTextFieldStyleCustom(Colors.white)),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                Icon(Icons.timelapse, color: Colors.white),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                Text("30 min", style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 12)),
              ],
            ),
            Row(
              children: [
                Text("Serving Time", style: AppWidget.boldTextFieldStyleCustom(Colors.white)),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                Icon(Icons.alarm, color: Colors.white),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
                Text(((count + total) / 2).toStringAsFixed(1) + " min", style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 12)),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Cash", style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 12)),
                          SizedBox(width: MediaQuery.of(context).size.width / 9),
                          Icon(Icons.money_sharp, color: Colors.deepOrange),
                        ],
                      ),
                      Text("\$ " + total.toString(), style: AppWidget.PriceTextFieldStyle()),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async{
                      Map<String, dynamic> addFoodCart = {
                        "Name" : widget.name,
                        "Quantity" : count.toString(),
                        "Total" : total.toString(),
                        "Image" : widget.image,
                      };
                      await DataBaseMethods().addFoodToCart(id!, addFoodCart);
                      _popupCustom("Item Added To Cart", Icon(Icons.shopping_basket_outlined), golden, 15);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add To Cart  ", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20)),
                          SizedBox(width: 40.0,),
                          Container(
                            width: MediaQuery.of(context).size.width / 14,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                            child: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _popup(String txt) {
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
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _popupCustom(String txt, Icon icon, Color c, int size) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: c, // Custom color
        content: Row(
          children: [
            icon,
            SizedBox(width: 8), // Add spacing between icon and text
            Text(
              txt,
              style: TextStyle(fontSize: size.toDouble(), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
