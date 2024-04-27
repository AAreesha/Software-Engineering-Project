import 'package:flutter/material.dart';
import 'package:mealkit/navigation.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State
{
final _formKey = GlobalKey<FormState>();

TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController cardHolderNameController = TextEditingController();
TextEditingController cvvController = TextEditingController();
TextEditingController expDateController = TextEditingController();
bool? isCODSelected = false;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
         title: Navigationbar(total: 0.0,cartItems: [],),
         automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
      ),
body: SingleChildScrollView(
padding: EdgeInsets.all(20.0),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
Text(
'Enter your details to complete the order:',
style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
),
SizedBox(height: 20.0),
TextFormField(
controller: nameController,
decoration: InputDecoration(labelText: 'Name'),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your name';
}
return null;
},
),
TextFormField(
controller: addressController,
decoration: InputDecoration(labelText: 'Address'),
maxLines: 3,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your address';
}
return null;
},
),
TextFormField(
controller: phoneNumberController,
decoration: InputDecoration(labelText: 'Phone Number'),
keyboardType: TextInputType.phone,
validator: (value) {
if (value == null || value.isEmpty || value.length < 10) {
return 'Please enter a valid phone number';
}
return null;
},
),
SizedBox(height: 20.0),
Text(
'Payment Method:',
style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
),
Row(
children: <Widget>[
Radio(
value: false,
groupValue: isCODSelected,
onChanged: (bool? value) {
setState(() {
isCODSelected = value;
});
},
),
Text('Cash on Delivery'),
],
),
Row(
children: <Widget>[
Radio(
value: true,
groupValue: isCODSelected,
onChanged: (bool? value) {
setState(() {
isCODSelected = value;
});
},
),
Text('Credit/Debit Card'),
],
),
if (isCODSelected == true) ...[
SizedBox(height: 20.0),
Text(
'Enter Card Details:',
style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
),
TextFormField(
controller: cardNumberController,
decoration: InputDecoration(labelText: 'Card Number'),
keyboardType: TextInputType.number,
validator: (value) {
if (value == null || value.isEmpty || value.length != 16) {
return 'Please enter a valid card number';
}
return null;
},
),
TextFormField(
controller: cardHolderNameController,
decoration: InputDecoration(labelText: 'Card Holder Name'),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter the card holder name';
}
return null;
},
),
Row(
children: <Widget>[
Expanded(
child: TextFormField(
controller: expDateController,
decoration: InputDecoration(labelText: 'Expiration Date (MM/YY)'),
validator: (value) {
if (value == null || value.isEmpty || value.length != 5 || !value.contains('/')) {
return 'Please enter a valid expiration date';
}
return null;
},
),
),
SizedBox(width: 20.0),
Expanded(
child: TextFormField(
controller: cvvController,
decoration: InputDecoration(labelText: 'CVV'),
keyboardType: TextInputType.number,
validator: (value) {
if (value == null || value.isEmpty || value.length != 3) {
return 'Please enter a valid CVV';
}
return null;
},
),
),
],
),
],
SizedBox(height: 20.0),
ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
// Form is valid, submit order logic here
}
},
child: Text('Submit Order'),
),
],
),
),
),
);
}
}