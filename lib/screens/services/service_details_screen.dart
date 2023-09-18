import 'package:absherv2/screens/imports.dart';
class ServiceDetailsScreen extends StatefulWidget {
  final int id;
  final int subId;
  final String name;
  final String imagePath;
  final String bio;
  final String cost;
  final String costNotes;
  final String text;

  ServiceDetailsScreen({
    required this.id,
    required this.subId,
    required this.name,
    required this.imagePath,
    required this.bio,
    required this.cost,
    required this.costNotes,
    required this.text,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Service Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Network Image
            Image.network(
              widget.imagePath,
              width: double.infinity, // Full width
              fit: BoxFit.cover,
            ),
            // Service Name or Details
Row(
  mainAxisAlignment: MainAxisAlignment.end, // Align text to the right
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0), // Add your desired padding
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    ),
  ],
),

            // Bio
  Row(
  mainAxisAlignment: MainAxisAlignment.end, // Align to the right
  children: [
    Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20 ,8,20,8), // Add padding here
        child: Text(
          widget.bio,
          textAlign: TextAlign.right,
        ),
      ),
    ),
  ],
),


            // Preview Cost
        Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      '  ${widget.cost} ',
      textAlign: TextAlign.center,
    ),
  ],
),
            // Preview Cost
        Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      ' ${widget.costNotes} ',
      textAlign: TextAlign.center,
    ),
  ],
),
            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,16),
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                },
                child: Text('مـعـايـنـة'),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
