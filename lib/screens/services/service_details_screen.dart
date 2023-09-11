import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final int id;
  final int subId;
  final String name;
  final String imagePath;
  final String bio;
  final double previewCost;
  final String text;

  ServiceDetailsScreen({
    required this.id,
    required this.subId,
    required this.name,
    required this.imagePath,
    required this.bio,
    required this.previewCost,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Service Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imagePath, // Use the provided image URL
              width: 200, // Set the width as needed
              height: 200, // Set the height as needed
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              text, // Display the service name or details
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Add more widgets to display additional details as needed
            Text('ID: $id'),
            Text('Sub ID: $subId'),
            Text('Bio: $bio'),
            Text('Preview Cost: $previewCost'),
          ],
        ),
      ),
    );
  }
}
