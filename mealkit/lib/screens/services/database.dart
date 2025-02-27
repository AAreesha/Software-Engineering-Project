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

  final CollectionReference orderHistory = FirebaseFirestore.instance.collection('Order History');

  //cart items
  //final CollectionReference ordersCollection = FirebaseFirestore.instance.collection('orders');



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


 Future<void> addOrderItem(String orderId, String itemName, double price) async {
  // Ensure the UID is valid
  if (uid.isEmpty) {
    throw ArgumentError('UID must not be empty');
  }

  // Reference the specific order using orderId
  CollectionReference orderItems = orders.doc(orderId).collection('items');

  // Add a new item with a unique document ID in the order's sub-collection
  await orderItems.add({
    'userId': uid,
    'Name': itemName,
    'price': price,
    'timestamp': FieldValue.serverTimestamp(), // Timestamp of the order item
  });
}

  
  // Function to retrieve all orders for a specific user
  Future<List<Map<String, dynamic>>> getUserOrders() async {
     QuerySnapshot querySnapshot = await orders.where('userId', isEqualTo: uid).get();

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
  QuerySnapshot querySnapshot = await orders.where('userId', isEqualTo: uid).get();

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
Future<void> deleteOrderItem(String orderId, String itemName, double price) async {
  try {
    // Reference the specific order items collection using orderId
    CollectionReference orderItems = orders.doc(orderId).collection('items');

    // Query for the item document to delete
    QuerySnapshot querySnapshot = await orderItems
        .where('Name', isEqualTo: itemName)
        .where('price', isEqualTo: price)
        .get();


    // Iterate through the result documents and delete them
    for (QueryDocumentSnapshot itemDoc in querySnapshot.docs) {
      // Delete each item document
      await itemDoc.reference.delete();
    }
  } catch (e) {
    // Handle errors
    print('Error deleting item: $e');
    throw e; // Re-throw the error for handling at a higher level
  }
}

Future<void> moveOrdersToHistory() async {
    try {
      // Get all orders for the current user
      List<Map<String, dynamic>> orders = await getOrderDetails();
      for (var order in orders) {
      print("Item: ${order['Name']}, Price: ${order['price']}");
    }

      // Check if there are any orders
      if (orders.isNotEmpty) {
        // Get the current timestamp
        DateTime now = DateTime.now();

        // Create a batch
        WriteBatch batch = FirebaseFirestore.instance.batch();

        // Iterate through each order and add it to the order history
        for (var order in orders) {
          // Add the order to the order history with the current timestamp
          batch.set(orderHistory.doc(), {
            'userid': uid,
            'name': order['Name'],
            'price': order['price'],
            'timestamp': now,
          });

          // Delete the order from the orders collection
          await deleteOrderItem(order['userId'], order['Name'], order['price']);
        }

        // Commit the batch
        await batch.commit();
      }
    } catch (e) {
      print('Error moving orders to history: $e');
      throw e;
    }
  }

}