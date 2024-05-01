//<============================ Module 1 =============================>
// This module is the StatefulWidget that defines the Wallet screen.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//<============================ Module 2 =============================>
// Imported Database and Shared Preference services for user info and wallet balance.
import '../service/database.dart';
import '../service/shared_pref.dart';

//<============================ Module 3 =============================>
// Imported necessary widgets and constants.
import '../widget/widget_support.dart';
import 'app_constant.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id,email;
  int? add;
  TextEditingController amountController = TextEditingController();
  Map<String,dynamic> ?infoGet;
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFF64B00);

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  //<============================ Module 4 =============================>
  // Fetches user wallet information from the shared preferences.
  Future<void> getthesharepref() async {
    email=await SharedPreferenceHelper().getUserEmail();
    infoGet = await DataBaseMethods().getUserInfoByEmail((email!));
    wallet=  infoGet!["Wallet"];
    id=  infoGet!["Id"];
    print("<======================================================================>Wallet<==================================> =  ${email}");
    print("<======================================================================>Wallet<==================================> =  ${wallet}");
    print("<======================================================================>id<==================================> =  ${id}");
    setState(() {});
  }

  //<============================ Module 5 =============================>
  // Calls getthesharepref() method to initialize wallet information.
  Future<void> ontheload() async {
    await getthesharepref();
    setState(() {});
  }

  //<============================ Module 6 =============================>
  // Refreshes the wallet screen.
  void _refresh()
  {
    Timer(Duration(seconds: 3),(){
      setState(() {
        ontheload();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("    Wallet",
            style: AppWidget.HeadlineTextFieldStyleCustom(
                30, Color(0xFFE2A808)),),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded,color: golden,),
            onPressed: _refresh,
          ),
        ],
      ),

      backgroundColor: Colors.black,
      body: wallet == null
          ? Center(child: CircularProgressIndicator())
          : buildWalletScreen(),
    );
  }

  //<============================ Module 7 =============================>
  // Constructs the wallet screen UI.
  Widget buildWalletScreen() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 0.8,color: golden),
            ),
            child: Row(
              children: [
                Image.asset(
                  "images/wallet.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 40.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Wallet ",
                      style: AppWidget.SemiboldTextFieldStyleCustom(
                          Colors.white, 18),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      " \$  " + wallet!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Add Money ",
              style: AppWidget.SemiboldTextFieldStyleCustom(
                  Colors.white, 18),),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddMoney(100),
              AddMoney(500),
              AddMoney(1000),
              AddMoney(2500),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              openEdit();
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF909090),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text("Add Money",
                  style: AppWidget.SemiboldTextFieldStyleCustom(
                      Colors.white, 18.0),),)
            ),
          ),
        ],
      ),
    );
  }

  //<============================ Module 8 =============================>
  // Adds money widget.
  Widget AddMoney(int money) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()
        {
          makePayment(context, money.toString());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE2A808), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(" \$ " + "${money}", style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),),
      ),
    );
  }

  //<============================ Module 9 =============================>
  // Makes payment with Stripe.
  Future<void> makePayment(BuildContext context, String amount) async {
    Map<String, dynamic>? paymentIntent;

    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Musa',
        ),
      );

      await displayPaymentSheet(context, amount);
    } on StripeException catch (e) {
      print('Stripe Exception: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e, s) {
      print('Exception: $e $s');
    }
  }

  //<============================ Module 10 =============================>
  // Displays the payment sheet.
  Future<void> displayPaymentSheet(BuildContext context, String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        print("<========================id==================================> ${id}");
        await DataBaseMethods().UpdateUserwallet(id!, add.toString());

        setState(() {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                side: BorderSide(
                  color: Color(0xFFE2A808), // Border color
                  width: 2.0, // Border width
                ),
              ),
              content: Container(
                height: 30,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFFE2A808)),
                        Text("  Payment Successful",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 16),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });

        await getthesharepref();
      });
    } catch (e, s) {
      print('Error: $e $s');
    }
  }

  //<============================ Module 11 =============================>
  // Creates payment intent.
  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers:
        {
          'Authorization':'Bearer $secretKey',
          'Content-Type':'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body ->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (e) {
      print('Error creating payment intent: $e');
      rethrow;
    }
  }

  //<============================ Module 12 =============================>
  // Converts amount to cents.
  String calculateAmount(String amount) {
    final calculatedAmount=(int.parse(amount)*100);
    return calculatedAmount.toString();
  }

  //<============================ Module 13 =============================>
  // Opens the edit dialog.
  Future openEdit()=>showDialog(context: context, builder: (context)=>AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
        side: BorderSide(
          color: Color(0xFFE2A808), // Border color
          width: 2.0, // Border width
        ),
      ),
      content: SingleChildScrollView(
          child:Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel,color:Colors.white)),
                    SizedBox(width: 25.0,),
                    Text("Add Money",style:AppWidget.HeadlineTextFieldStyleCustom( 24,Color(0xFFE50914)),
                    ),
                  ],
                ),

                SizedBox(height: 20.0,),
                Center(child: Text("Amount",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 12))),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration:BoxDecoration(
                    border:Border.all(color:Color(0xFFE2A808),width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration:InputDecoration(
                        border: InputBorder.none,hintText:'Enter Amount',hintStyle:AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 14)
                    ),
                    style:AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 14),
                  ),
                ),
                SizedBox(height: 20.0,),

                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      makePayment(context, amountController.text);
                    },
                    child: Container(
                      width:100,
                      padding: EdgeInsets.all(5),
                      decoration:BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Color(0xFFE2A808),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Center(child: Text("Pay",style:TextStyle(color: Colors.white))),

                    ),
                  ),
                ),
              ],
            ),
          )
      )
  )
  );
}
