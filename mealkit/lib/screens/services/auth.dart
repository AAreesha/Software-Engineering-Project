import 'package:mealkit/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealkit/screens/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late UserCredential result;
  // create user obj based on firebase user
  User_Details? _userFromFirebaseUser(User? user) {
    return user != null ? User_Details(uid: user.uid) : null;
  }


  Stream<User_Details?> get user {
  return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
}
  // sign in anon
  Future <User_Details?>signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
   Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String username, String address,String contact) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(username,address,contact);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }


  // Function to add order details to Firestore
  Future<void> addOrderDetails(String itemName, double price) async {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated');
    }

    try {
      await DatabaseService(uid: user.uid).addOrder(user.uid,itemName, price);
    } catch (e) {
      print('Error adding order details: $e');
    }
  }

  // sign out

}