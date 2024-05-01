import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../service/database.dart';
import '../service/shared_pref.dart';
import '../widget/widget_support.dart';

class UpdateFood extends StatefulWidget {
  String image,name,detail,price;
  UpdateFood({required this.detail,required this.name,required this.image,required this.price});
  @override
  State<UpdateFood> createState() => _UpdateFoodState();

}

class _UpdateFoodState extends State<UpdateFood> {
  Color red= Color(0xFFE50914);
  Color golden =Color(0xFFE2A808);
  Color grey =Color(0xFF525252);
  Color grey2 =Color(0xFF949494);
  Color orange=Color(0xFFff5c30);
  String? id;


  getthesharedpref() async{
    id=await SharedPreferenceHelper().getUserId();
    setState(() {
    });

  }

  ontheload() async
  {
    await getthesharedpref();
    setState(() {

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
    set();
  }


  final List<String> items=["Flavoured Ice Cream","Pizza Sliders","Salads","Soft Bun Burger"];
  TextEditingController namecontroller =TextEditingController();
  TextEditingController pricecontroller =TextEditingController();
  TextEditingController Detailcontroller =TextEditingController();
  String? value;



  final ImagePicker _picker =ImagePicker();
  File? SelectedImage;



  Future getImage () async{
    var image =await _picker.pickImage(source: ImageSource.gallery);
    SelectedImage = File(image!.path);

    setState(() {

    });
  }

  uploadItem () async
  {

    if(namecontroller.text=="")
    {
      popup("Please Enter Name Of The ${value}", 13);
    }
    else if(pricecontroller.text =="")
    {
      popup("Please Enter Price Of The ${value}", 13);
    }
    else if(Detailcontroller.text =="")
    {
      popup("Please Enter Price Of The ${value}", 13);
    }
    else if(value =="reset" || value =="");
    {
      popup("Please Enter Category Of The ${value}", 13);
    }


    if(SelectedImage!=null && namecontroller.text!="" && pricecontroller.text !="" && Detailcontroller.text!="" && value!="reset")
    {
      String addId=randomAlphaNumeric(10);

      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(SelectedImage!);
      var downloadUrl= await(await task).ref.getDownloadURL();
      Map<String,dynamic> addItem={
        "Image":downloadUrl,
        "Name":namecontroller.text,
        "Price": pricecontroller.text,
        "Detail": Detailcontroller.text,
      };
      await DataBaseMethods().updateFoodItem(value!,namecontroller.text,addItem).then((value) {
        popup("Food Item Added SucessFully", 18);

        SelectedImage=null;
        namecontroller.text="";
        pricecontroller.text="";
        Detailcontroller.text="";
        value="reset";
        setState(() {

        });


     });
    }

    if(SelectedImage==null && namecontroller.text!="" && pricecontroller.text !="" && Detailcontroller.text!="" && value!="reset")
    {
      String addId=randomAlphaNumeric(10);

      Map<String,dynamic> addItem={
        "Name":namecontroller.text,
        "Price": pricecontroller.text,
        "Detail": Detailcontroller.text,
      };
      await DataBaseMethods().updateFoodItem(value!,namecontroller.text,addItem).then((value) {
        popup("Food Item Added SucessFully", 18);

        SelectedImage=null;
        namecontroller.text="";
        pricecontroller.text="";
        Detailcontroller.text="";
        value="reset";
        setState(() {

        });


      });
    }
  }

void set()
{

  namecontroller.text=widget.name.toString();
  pricecontroller.text=widget.price.toString();
  Detailcontroller.text=widget.detail.toString();
}

  @override
  Widget build(BuildContext context) {

   return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:GestureDetector(
            onTap:(){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
        centerTitle: true,
        title: Text("Update  Item ",style: AppWidget.SemiboldTextFieldStyleCustom(golden, 25),),
      ),

      body:
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0,right:20.0,top:20.0,bottom: 20.0),
          child: Column(
            children: [
              Text("Upload The Item Picture",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white,18 ),),
              SizedBox(height:20.0),

              SelectedImage==null? GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height :150,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: golden,
                            width:1,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.network(widget.image),
                    ),
                  ),
                ),
              ):
              Center(
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    height :150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: golden,
                          width:1,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        SelectedImage!,fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Container(
                child: DropdownButtonHideUnderline(child:DropdownButton<String>(items:
                items.map((item) =>DropdownMenuItem<String>(
                    value: item,child: Text(item,style: AppWidget.LightlessTextFieldStyleCustom(Colors.white, 15),))).toList(),
                  onChanged:((value)=>setState(() { this.value=value;
                  }))
                  , dropdownColor:grey2,
                  hint: Text("     Select Category",style: AppWidget.SemiboldTextFieldStyleCustom(golden, 18),), iconSize: 36,icon: Icon(Icons.arrow_drop_down,color: Colors.white,),value: value,) ,),
              ),
              SizedBox(height: 30.0,),
              Text("Item Name",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 16,), textAlign: TextAlign.start,),
              SizedBox(height: 10,),
              Fields(namecontroller, "Enter Item Name", TextInputType.text,1),

              SizedBox(height: 10.0,),
              Text("Item Price",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 16), textAlign: TextAlign.start,),
              SizedBox(height: 10,),
              Fields(pricecontroller, "Enter Item Price", TextInputType.number,1),

              SizedBox(height: 10.0,),
              Text("Item Detail",style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 16), textAlign: TextAlign.start,),
              SizedBox(height: 10,),
              Fields(Detailcontroller, "Enter Item Detail", TextInputType.text,5),

              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    color: Colors.black,
                    elevation: 5.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.75,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:Colors.black,
                        border: Border.all(
                          color: golden,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(child: Text("Update Item " ,style:AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 18),)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Fields(TextEditingController C, String Txt,TextInputType k,int m)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(10),
      ),
      //<===========================Enter Item Name=======================================================>
      child: TextFormField
        (
        maxLines: m,
        keyboardType: k,
        controller: C,
        style: AppWidget.SemiboldTextFieldStyleCustom(Colors.white, 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: Txt,hintStyle: AppWidget.LightlessTextFieldStyleCustom(Colors.white,15),
        ),
      ),
    );
  }


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
