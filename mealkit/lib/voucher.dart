import 'package:flutter/material.dart';
import 'navigation.dart';
import 'menupage.dart';

class VoucherPage extends StatelessWidget {
  // Dummy data for vouchers
  final List<Map<String, dynamic>> availableVouchers = [
    {"name": "50% Off", "code": "VOUCHER50", "details": "Valid until 31st Dec 2024"},
    {"name": "Free Shipping", "code": "FREESHIP", "details": "No minimum purchase required"},
  ];

  final List<Map<String, dynamic>> newVouchers = [
    {"name": "10\$ Off", "code": "SAVE10", "details": "Valid for first-time users"},
    {"name": "20% Off", "code": "SAVE20", "details": "Limited time offer"},
  ];

  final List<Map<String, dynamic>> usedVouchers = [
    {"name": "10% Off", "code": "SAVE10NOW", "details": "Used on 12th March 2024"},
    {"name": "20\$ Off", "code": "SAVE20USED", "details": "Redeemed on 18th Feb 2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Navigationbar(total: 0.0,cartItems: [],),
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          _buildVoucherSection("Available Vouchers", availableVouchers),
          _buildVoucherSection("New Vouchers", newVouchers),
          _buildVoucherSection("Used Vouchers", usedVouchers),
        ],
      ),
    );
  }

  Widget _buildVoucherSection(String title, List<Map<String, dynamic>> vouchers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        vouchers.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "No vouchers available",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vouchers.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildVoucherCard(context, vouchers[index]);
                },
              ),
      ],
    );
  }

  Widget _buildVoucherCard(BuildContext context, Map<String, dynamic> voucher) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () {
            _showVoucherDetails(context, voucher);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  voucher['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Code: ${voucher['code']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showVoucherDetails(BuildContext context, Map<String, dynamic> voucher) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(voucher['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code: ${voucher['code']}'),
              SizedBox(height: 8),
              Text('Details: ${voucher['details']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
