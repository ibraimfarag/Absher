import 'package:absherv2/screens/imports.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/login_image.png'), // Replace with your login image
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {
                    // Handle checkbox state
                  },
                ),
                Text('Remember me'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Implement login button functionality
                // Call API for login
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
