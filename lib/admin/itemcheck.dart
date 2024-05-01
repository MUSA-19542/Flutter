import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fod/admin/UpdateFood.dart';

import '../pages/bottomnav.dart';
import '../pages/details.dart';
import '../service/database.dart';
import '../widget/widget_support.dart';

class ItemCheck extends StatefulWidget {
  const ItemCheck({super.key});

  @override
  State<ItemCheck> createState() => _ItemCheckState();
}

class _ItemCheckState extends State<ItemCheck> {
  bool icecream = false, burger = false, pizza = false, salad = false;
  String? Type;
  Stream? fooditemsfoodStream;
  Color red = Color(0xFFE50914);
  Color golden = Color(0xFFE2A808);
  Color grey = Color(0xFF525252);
  Color grey2 = Color(0xFF949494);
  Color black = Color(0xFF100C10);
  Color orange = Color(0xFFff5c30);

  ontheload() async
  {
    DataBaseMethods db = DataBaseMethods();
    fooditemsfoodStream =await db.getFoodItem("Pizza Sliders");
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
  }



  Widget allItemsVertically()

  {
    return StreamBuilder( stream:fooditemsfoodStream,builder: (context,AsyncSnapshot snapshot)
    {
      return snapshot.hasData? ListView.builder(
          padding:EdgeInsets.all(0),
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            DocumentSnapshot ds =snapshot.data.docs[index];
            return RecycleVertical(ds);

          }):CircularProgressIndicator();
    });
  }



  Widget RecycleVertical(DocumentSnapshot ds)
  {
    return
      Container(
        margin: EdgeInsets.all(10),
        color: Colors.black,

        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: ()
            {

              //<============update ==================================================== >
              Navigator.push(context,MaterialPageRoute(builder:  (context) => UpdateFood(detail:ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"], )));
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 0.9,color: golden),color: Colors.black,borderRadius: BorderRadius.circular(20),
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
                          width:MediaQuery.of(context).size.width/2.5,
                          child: Text(
                            ds["Name"],
                            style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15),
                          )),

                      SizedBox(height: 10,),
                      Container(
                          width:MediaQuery.of(context).size.width/2.5,
                          child: Text(
                              "Honey Goat Cheese",
                              style: AppWidget.LightlessTextFieldStyleCustom(grey2, 13)

                          )),
                      SizedBox(height: 5,),
                      Container(
                          width:MediaQuery.of(context).size.width/2.5,
                          child: Text("\$ "+ds["Price"],
                              style: AppWidget.PriceTextFieldStyle())),

                      GestureDetector(
                        onTap: (){DeleteItem(ds["Name"]);},
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top:5),
                            decoration: BoxDecoration(
                              color:red,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text("Delete",style: AppWidget.HeadlineTextFieldStyleCustom(16, Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
         backgroundColor: Colors.black,
         title: Row(
           children: [
             GestureDetector(
               onTap: () {
                // Navigator.push(context,MaterialPageRoute(builder:  (context) =>BottomNav()));
                 Navigator.pop(context);
               },
             child:Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                    Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),

                 SizedBox(width: 20), // Adjust the space between icon and text
               ],
             ),
     ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.person, color: golden), // Add your icon here
                 SizedBox(width: 8), // Adjust the space between icon and text
                 Text(
                   "Admin Panel",
                   style: AppWidget.HeadlineTextFieldStyleCustom(28, golden),
                 ),
               ],
             ),
           ],
         ),
       ),

       body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20.0),
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20.0),
              Container(
                  color:Colors.black,margin: EdgeInsets.only(right: 20.0), child: showItem()),
              SizedBox(
                height: 20,
              ),


              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [


                    allItemsVertically(),

                       ],
                ),
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNav(),
    );

  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemsfoodStream=await DataBaseMethods().getFoodItem("Flavoured Ice Cream");
            Type="Flavoured Ice Cream";
            setState(() {});
          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black ,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/ice-cream.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? golden : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Added SizedBox for spacing
        GestureDetector(
          onTap: () async{
            pizza = true;
            icecream = false;
            salad = false;
            burger = false;
            fooditemsfoodStream=await DataBaseMethods().getFoodItem("Pizza Sliders");
            Type="Pizza Sliders";
            setState(() {});

          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black ,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? golden : Colors.white,
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
            fooditemsfoodStream=await DataBaseMethods().getFoodItem("Salads");
            Type="Salads";
            setState(() {});

          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black ,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/salad.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? golden : Colors.white,
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
            fooditemsfoodStream=await DataBaseMethods().getFoodItem("Soft Bun Burger");
            Type="Soft Bun Burger";
            setState(() {});

          },
          child: Material(
            color: Colors.black,
            elevation: 5.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black ,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "images/burger.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? golden : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }



  void DeleteItem(String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: golden, width: 0.4),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Are you sure you want to delete?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(

                      backgroundColor: golden,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {

                      DataBaseMethods().deleteFoodItem(name, Type!);
                      Navigator.pop(context);
                      // Add delete functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Delete', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
