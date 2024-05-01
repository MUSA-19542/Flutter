

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods
{
  Future addUserDetail(Map<String,dynamic> userInfoMap,String id) async
  {
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);
  }
  UpdateUserwallet(String id,String amount) async
  {
    return await FirebaseFirestore.instance.collection("users").doc(id).update({"Wallet":amount});
  }

  Future<void> updateFoodItem(String collectionName, String itemName, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('Name', isEqualTo: itemName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update(updatedData);
        print("Document updated successfully ${collectionName}  ${itemName} ");
      } else {
        print("Document not found ${collectionName}  ${itemName}");
      }
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  Future addFoodItem(Map<String,dynamic> foodInfoMap,String name) async
  {
    return await FirebaseFirestore.instance.collection(name).add(foodInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name)
  async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }


  Future<void> addFoodToCart(String userId, Map<String, dynamic> foodInfo) async {
    try {
      String itemName = foodInfo["Name"];

      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("Cart")
          .where("Name", isEqualTo: itemName)
          .get();

      if (cartSnapshot.docs.isNotEmpty) {
        // Item already exists in the cart, update quantity and price

          int newQuantity = int.parse(foodInfo["Quantity"]) ;
          int newTotal = int.parse(foodInfo["Total"]) ;
          await updateFoodCartItem(userId,itemName,{"Quantity" : newQuantity.toString(),"Total":newTotal.toString()});

          print("Cart item updated successfully ${itemName} ${newQuantity} ${newTotal} ");
        }

       else {
        // Item doesn't exist in the cart, add it
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("Cart")
            .add(foodInfo);
        print("Food item added to cart successfully");
      }
    } catch (e) {
      print("Error adding food item to cart: $e");
      // Handle error
    }
  }

  Future<void> updateFoodCartItem(String userId, String itemName, Map<String, dynamic> updateData) async {
    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("Cart")
          .where("Name", isEqualTo: itemName)
          .get();

      for (QueryDocumentSnapshot cartItem in cartSnapshot.docs) {
        await cartItem.reference.update(updateData);
      }

      print("Cart items updated successfully");
    } catch (e) {
      print("Error updating cart items: $e");
      // Handle error
    }
  }



  Future deleteFoodFromCart(String itemName, String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .where("Name", isEqualTo: itemName)
        .get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }



  Future<Stream<QuerySnapshot>> getFoodCart(String id)
  async{
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").snapshots();
  }


   Future deleteFoodItem(String itemName, String name) async {
      return await FirebaseFirestore.instance
      .collection(name)
      .where("Name", isEqualTo: itemName)
      .get()
      .then((snapshot) {
    snapshot.docs.first.reference.delete();
  });
}


  Future<Map<String, dynamic>> getUserInfoByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return {
          "Id": querySnapshot.docs.first.id,
          "Wallet": querySnapshot.docs.first.get("Wallet"),
          "Name": querySnapshot.docs.first.get("Name")
        };
      } else {
        return {"Id": "Not Found", "Wallet": "Not Found", "Name": "Not Found"};
      }
    } catch (e) {
      print("Error getting user info: $e");
      return {"Id": "Not Found", "Wallet": "Not Found", "Name": "Not Found"};
    }
  }

}