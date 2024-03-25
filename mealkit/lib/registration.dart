import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mealkit/sqldb.dart';


class Registration extends StatelessWidget{
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        centerTitle: true,
      ),

      body:  MyCustomForm(),
    );
  }
}


class MyCustomForm extends StatelessWidget {
  
  //const MyCustomForm({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Userdetails userDetails = Userdetails();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: username,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Username',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Email',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Password',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: contact,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Contact Number',
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your Address',
            ),
          ),
        ),
      
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () async {
            // Prepare the SQL statement with placeholders (?)
            String sql = "INSERT INTO user_details (username, contact) VALUES (?, ?)";

            // Prepare the values to be inserted
            List<dynamic> values = [username.text, contact.text];

            // Call the insertData method with the prepared SQL statement and values
            int response = await userDetails.insertData(sql, values);
            print(response);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Registration Complete"),
                );
              },
            );
          },
          child: Text('Register'),
          
        )
      ],
    );
  }
}


