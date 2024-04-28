import 'package:flutter/material.dart';
import 'package:mealkit/screens/services/auth.dart';
import 'package:mealkit/navigation.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field states
  String username = '';
  String email = '';
  String password = '';
  String contactNumber = '';
  String address = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Navigationbar(total: 0.0),
         automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a username' : null,
                  onChanged: (val) {
                    setState(() => username = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a contact number' : null,
                  onChanged: (val) {
                    setState(() => contactNumber = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an address' : null,
                  onChanged: (val) {
                    setState(() => address = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email,password,username,address,contactNumber);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  },
                  child: Text('Register'),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
