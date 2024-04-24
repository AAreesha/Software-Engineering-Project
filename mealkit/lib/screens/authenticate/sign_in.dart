import 'package:flutter/material.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/screens/services/auth.dart';


class SignIn extends StatelessWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Navigationbar(total: 0.0,cartItems: [],),
         automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyCustomForm(toggleView: toggleView),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final Function toggleView;
  MyCustomForm({required this.toggleView});

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (val) =>
                  val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                dynamic result =
                    await _auth.signInWithEmailAndPassword(email, password);
                if (result == null) {
                  setState(() {
                    error = 'Account not found!';
                  });
                }
              }
            },
            child: Text('Sign In'),
          ),

          SizedBox(height: 12.0),

          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),

          GestureDetector(
            onTap: () {
              widget.toggleView(); // Toggle to the registration page
            },
            child: Text(
              "Don't have an Account? Sign Up!",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
