//<============================module 1=============================>
// This module contains the code for the bottom navigation bar.

import "package:flutter/material.dart";
import "package:fod/pages/Order.dart";
import "package:fod/pages/Profile.dart";
import "package:fod/pages/home.dart";
import "package:fod/pages/wallet.dart";
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  //<============================module 2=============================>
  // Color variables used in the bottom navigation bar.
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFff5c30);

  late int currentTabindex;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    super.initState();
    //<============================module 3=============================>
    // Initialize variables and pages.
    currentTabindex = 0;
    homepage = Home();
    order = Order();
    profile = Profile();
    wallet = Wallet();
    pages = [homepage, order, wallet, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 75,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabindex = index;
            });
          },
          items: [
            Icon(Icons.home_outlined, color: Colors.white),
            Icon(Icons.shopping_bag_outlined, color: Colors.white),
            Icon(Icons.wallet_outlined, color: Colors.white),
            Icon(Icons.person_outlined, color: Colors.white),
          ],
        ),
        body:  pages[currentTabindex] ,
      ),
    );
  }

}
