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

  //cart items
  final CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');



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

// fetching email change if it causes errors
 Future<String> getUserEmail() async {
    try {
      // Get the user document based on the UID
      DocumentSnapshot userDoc = await userinfo.doc(uid).get();
      // Check if the user document exists and contains an email field
      if (userDoc.exists && userDoc.data() != null) {
        return userDoc['email'] ?? 'Email not found';
      } else {
        return 'Email not found';
      }
    } catch (e) {
      print('Error retrieving user email: $e');
      return 'Email not found';
    }
  }


  // Function to add an order to the 'orders' collection
  Future<void> addOrder(String orderId, String itemName, double price) async {
  if (uid.isEmpty) {
    throw ArgumentError('UID must not be empty');
  }
  
  // Add a new order item with a unique document ID
  await orders.doc(orderId).collection('items').add({
    'userId': uid,
    'Name': itemName,
    'price': price,
    'timestamp': FieldValue.serverTimestamp(), // Timestamp of the order item
  });
}

  
  // Function to retrieve all orders for a specific user
  Future<List<Map<String, dynamic>>> getUserOrders() async {
     QuerySnapshot querySnapshot = await ordersCollection.where('userId', isEqualTo: uid).get();

  // Initialize an empty list to store all order items
  List<Map<String, dynamic>> allOrderItems = [];

  // Iterate through each order document
  for (QueryDocumentSnapshot orderDoc in querySnapshot.docs) {
    // Get the subcollection 'items' for each order document
    QuerySnapshot itemsQuerySnapshot = await orderDoc.reference.collection('items').get();

    // Iterate through each item document in the 'items' subcollection
    for (QueryDocumentSnapshot itemDoc in itemsQuerySnapshot.docs) {
      // Add the item data to the list
      allOrderItems.add(itemDoc.data() as Map<String, dynamic>);
    }
  }

  // Return the list of all order items
  return allOrderItems;
  }
Future<List<Map<String, dynamic>>> getOrderDetails() async {
  // Query the order documents where userId is equal to uid
  QuerySnapshot querySnapshot = await ordersCollection.where('userId', isEqualTo: uid).get();

  // Initialize an empty list to store all order items
  List<Map<String, dynamic>> allOrderItems = [];

  // Iterate through each order document
  for (QueryDocumentSnapshot orderDoc in querySnapshot.docs) {
    // Get the subcollection 'items' for each order document
    QuerySnapshot itemsQuerySnapshot = await orderDoc.reference.collection('items').get();

    // Iterate through each item document in the 'items' subcollection
    for (QueryDocumentSnapshot itemDoc in itemsQuerySnapshot.docs) {
      // Add the item data to the list
      allOrderItems.add(itemDoc.data() as Map<String, dynamic>);
    }
  }

  // Return the list of all order items
  return allOrderItems;
}
Future<void> deleteOrder(String orderId, String itemName, double price, Timestamp timestamp) async {
    try {
      // Query for the order document to delete
      QuerySnapshot querySnapshot = await ordersCollection
          .where('userId', isEqualTo: uid)
          .where('Name', isEqualTo: itemName)
          .where('price', isEqualTo: price)
          .where('timestamp', isEqualTo: timestamp)
          .get();

      // Iterate through the result documents and delete them
      for (QueryDocumentSnapshot orderDoc in querySnapshot.docs) {
        // Delete each order document
        await orderDoc.reference.delete();
      }
    } catch (e) {
      // Handle errors
      print('Error deleting order: $e');
      throw e; // Re-throw the error for handling at a higher level
    }
  }
}