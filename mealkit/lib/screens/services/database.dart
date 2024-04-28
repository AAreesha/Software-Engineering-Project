import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealkit/models/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });


  // user info
  final CollectionReference userinfo = FirebaseFirestore.instance.collection('users');
  // orders
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');


  Future<void> updateUserData(String username, String address,String contact) async {
    // Validate uid
    if (uid.isEmpty) {
      throw ArgumentError('UID must not be empty');
    }

    // Use 'set' with 'merge' to avoid overwriting existing data
    await userinfo.doc(uid).set({
      'username': username,
      'address': address,
      'contact': contact,
    }, SetOptions(merge: true)); // Set merge option
  }


  // Function to add an order to the 'orders' collection
  Future<void> addOrder(String orderId, String itemName, double price) async {
    if (uid.isEmpty) {
      throw ArgumentError('UID must not be empty');
    }
    
    // Add a new order with user ID reference
    await orders.doc(orderId).set({
      'userId': uid,
      'Name': itemName,
      'price': price,
      'timestamp': FieldValue.serverTimestamp(), // Timestamp of the order
    });
  }
  
  // Function to retrieve all orders for a specific user
  Future<List<Map<String, dynamic>>> getUserOrders() async {
    QuerySnapshot querySnapshot = await orders.where('userId', isEqualTo: uid).get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

}