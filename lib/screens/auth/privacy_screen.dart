import 'package:absherv2/main.dart';
import 'package:absherv2/screens/imports.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: true),
        body: SingleChildScrollView(
          // Wrap your content in SingleChildScrollView
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'سياسة الخصوصية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right, // Align the heading to the right
              ),
              SizedBox(height: 16),
              Text(
                // Add your privacy policy text here
                'نص سياسة الخصوصية يمكن وضعه هنا...',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.right, // Align the text to the right
              ),
              // You can add more text or widgets as needed
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
