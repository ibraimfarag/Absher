import 'package:absherv2/screens/imports.dart';




class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/register_image.png'), // Replace with your register image
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement signup button functionality
                // Call API for registration
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
