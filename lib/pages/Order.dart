import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fod/service/database.dart';
import 'package:fod/service/shared_pref.dart';

import '../widget/widget_support.dart';
import 'details.dart';

//<============================Module 1=============================>
// This module represents the 'Order' screen of the application.
class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? foodStream;
  String? id;
  String? email;
  int total =0;
  int amount2 =0;
  Map<String,dynamic>? infoGet;
  String? wallet;
  bool isVisible = true;
  DataBaseMethods db = DataBaseMethods();
  SharedPreferenceHelper shared =  SharedPreferenceHelper();
  DocumentSnapshot? dss;
  AsyncSnapshot? Snapshot;

  //<============================Module 2=============================>
  // This module calculates the total amount of the items in the food cart.
  Future<void> Calculate() async {
    total =0;
    int length2= await Snapshot!.data.docs.length;
    Timer(Duration(seconds: 2),(){
      for(int i=0;i<Snapshot!.data.docs.length;i++) {
        dss= Snapshot!.data.docs[i];

        //print("<=================BEFORE Total in Food Cart=========> ${total} ${dss!["Name"]} ${length2}");
        total = total + int.parse(dss!["Total"]);
        print("<=================After Total in Food Cart=========> ${dss!["Total"]} ${dss!["Name"]} Length /n ${length2}");

      }
      setState(() {
        print("<=================Total in Food Cart=========> ${total} ");

      });
    });
  }

  void startTimer() {
    Calculate();

    Timer(Duration(seconds: 2),(){
      amount2=total;
      isVisible=true;
    });
  }

  getthesharepref() async {
    email=await shared.getUserEmail();
    infoGet=await DataBaseMethods().getUserInfoByEmail(email!);
    id=infoGet!["Id"];
    wallet=infoGet!["Wallet"];
    setState(() {

    });
  }

  ontheload() async {
    await getthesharepref();
    foodStream=await db.getFoodCart(id! );

    setState(() {

    });

  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  //<============================Module 3=============================>
  // This module builds the UI for the food cart items.
  Widget foodCart() {
    return StatefulBuilder(
      builder: (context, StateSetter setState) {
        // Reset total to zero before recalculating
        return StreamBuilder(
          stream: foodStream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                dss=ds;
                Snapshot=snapshot;
                return RecycleVertical(ds);
              },
            )
                : CircularProgressIndicator();
          },
        );
      },
    );
  }

  Widget RecycleVertical(DocumentSnapshot ds)
  {
    int quantity = int.parse(ds["Quantity"]);
    int price = int.parse(ds["Total"]);
    int per=(price/quantity).toInt();
    return
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0,bottom: 10),
          width: MediaQuery.sizeOf(context).width,
          child: Material(
            elevation: 5.0,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          ds["Quantity"],
                          style: AppWidget.LightlessTextFieldStyleCustom(
                              Colors.white, 17),
                        )),
                  ),
                  SizedBox(width: 10.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      ds["Image"],
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.0,),

                  Container(
                    width: MediaQuery.sizeOf(context).width/2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ds["Name"],style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 13),),
                        SizedBox(height: 10.0,),
                        Row(children: [
                          Column(children: [
                            Text("\$ "+ds["Total"],style: AppWidget.PriceTextFieldStyleCustom(15),),
                            SizedBox(height: 5,),

                            Row(
                              children: [
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      quantity++;
                                      price=per+price;
                                      print("<============Per=============> ${per}\n price = ${price}");
                                    });
                                    db.updateFoodCartItem(id!, ds["Name"],{
                                      "Quantity": quantity.toString(),
                                      "Total": price.toString()
                                    });
                                    dss=ds;
                                    Calculate();
                                  },
                                  child: Container(
                                      width:20,
                                      height:20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: orange,
                                      ),
                                      child: Icon(Icons.add,color:Colors.white,size: 13,)),
                                ),
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: (){

                                    if (quantity > 1) {
                                      quantity--;
                                      price=price-per;
                                      db.updateFoodCartItem(id!,ds["Name"], {
                                        "Quantity": quantity.toString(),
                                        "Total": price.toString()
                                      });
                                    }
                                    else
                                    {
                                      db.deleteFoodFromCart(ds["Name"], id!);
                                    }
                                    dss=ds;
                                    Calculate();

                                    print("minus Pressed --------------------------");

                                  },
                                  child: Container(
                                      width:20,
                                      height:20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: orange,
                                      ),
                                      child: Icon(Icons.remove,color:Colors.white,size: 13,)),
                                ),
                              ],
                            ),
                          ],),

                          SizedBox(width: 30.0,),
                          GestureDetector(
                              onTap: (){
                                db.deleteFoodFromCart(ds["Name"], id!);
                                dss=ds;
                                Calculate();
                              },
                              child: Icon(Icons.delete_outline_sharp,color:golden,size: 25,)),
                        ],
                        ),

                      ],),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFff5c30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,color:Color(0xFFE2A808) ,size: 30,),
                      SizedBox(width: 20.0,),
                      Container(
                        child: Text("Food Cart",
                          style: AppWidget.LightlessTextFieldStyleCustom(  Color(0xFFE2A808),30,
                          ),),

                      ),
                    ],
                  ),


                ),
              ),
            ),
            SizedBox(height: 20.0,),

            Container(
                height:MediaQuery.of(context).size.height/2,

                child:  foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 10.0,bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price : ",style: AppWidget.LightlessTextFieldStyleCustom(golden, 18),),
                  SizedBox(width: 20.0,),
                  Text("\$ "+total.toString(),style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white,18),),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            GestureDetector(
              onTap: () async{
                if(int.parse(wallet!) >= total)
                {
                  int amount=0;
                  amount=int.parse(wallet!)-total;
                  await db.UpdateUserwallet(id!, amount.toString());
                  await shared.saveUserWallet(amount.toString());
                  setState(() {

                  });
                }
                else
                  popup("Amount Not Sufficient",Icon( Icons.warning_amber,color: Colors.white,size: 15,), red, 15);
              },
              child: Visibility(
                visible: isVisible,
                child: Container(

                  margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 8),
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text("Check Out",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 18),)),
                  decoration: BoxDecoration(color: golden,borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This method shows a snackbar with a message.
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

