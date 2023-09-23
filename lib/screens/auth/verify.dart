import 'dart:convert';

import 'package:absherv2/main.dart';
import 'package:absherv2/screens/imports.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController verifyCodeController = TextEditingController();
  String phoneNumber = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the phone number from route arguments
    final Map<String, String>? args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args != null && args.containsKey('phone')) {
      setState(() {
        phoneNumber = args['phone'] ?? '';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: false),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'تفعيل الحساب ',
                  style: TextStyle(fontSize: 24.0, fontFamily: AppVariables.serviceFontFamily),
                ),
                SizedBox(height: 20), // Add some space between the title and sub-title
                Text(
                  'أدخل رمز التفعيل الذي تلقيته عبر الرسائل',
                  style: TextStyle(fontSize: 16.0, fontFamily: AppVariables.serviceFontFamily),
                ),
                SizedBox(height: 20), // Add some space between the title and sub-title
                Text(
                  '  على رقم $phoneNumber',
                  style: TextStyle(fontSize: 16.0, fontFamily: AppVariables.serviceFontFamily),
                ),
                SizedBox(height: 20), // Add space below the "على رقم" text
                Container(
                  width: 150, // Set the width to 50
                  child: TextField(
                    controller: verifyCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل رمز التفعيل',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                      // Set text alignment to center
                      alignLabelWithHint: true,
                      // Other InputDecoration properties...
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    // Set text alignment to center
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20), // Add space below the TextField
ElevatedButton(
  onPressed: () async {
    try {
      // Call the API to verify the account
      final token = await API.verifyAccount(phoneNumber, verifyCodeController.text);

      // Decode the token to extract information
      Map<String, dynamic> decodedToken = json.decode(
        utf8.decode(
          base64Url.decode(token!.split('.')[1]),
        ),
      );

      String name = decodedToken['name'];

      // Access the AuthProvider and update the authentication state
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(token, name);

      // Verification successful, you can navigate to the next screen or perform other actions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Successful'),
            content: Text('You can now proceed with your account.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Add navigation code here if needed
                  // For example, you can navigate to the MainApp
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Verification unsuccessful, handle the exception and show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Failed'),
            content: Text('$e'), // Display the error message
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  },
  child: Text('تفعيل'),
),

              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }
}