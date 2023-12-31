import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:Absher/main.dart';
import 'package:Absher/screens/imports.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle customTextStyle = TextStyle(
    fontFamily: AppVariables.serviceFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
  String? userToken;

  @override
  void initState() {
    super.initState();
    loadCachedToken();
  }

 Future<void> loadCachedToken() async {
    final String? token = await API.getCachedUserToken();
    setState(() {
      userToken = token;
    });
  }

Future<void> attemptLogin() async {
  final String phone = phoneController.text;
  final String password = passwordController.text;
try {
      String token = await API.login(phone, password);

      // Access the AuthProvider using Provider.of
      AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Call the method to decode and set token information
      authProvider.decodeAndSetToken(token);

      // Handle successful login and navigation
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp()));
    } catch (e) {


    // Handle login failure and display the API response message
    
    String errorMessage = '$e'; // Display the error message;

    // Check if the error is an HTTP response error

print('$e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ في تسجيل الدخول', textAlign: TextAlign.right),
          content: Text(
            errorMessage,
            textAlign: TextAlign.right,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );
  }
}


  ElevatedButton buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Set the predefined phone number and password
        phoneController.text = "01001802216";
        passwordController.text = "123456";

        // Trigger the login attempt
        attemptLogin();
      },
      child: Text('Sign In Developer'),
    );
  }

  @override
  Widget build(BuildContext context) {
        final authProvider = Provider.of<AuthProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: false),
        body: SingleChildScrollView( // Wrap your content in SingleChildScrollView
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  رقم الموبيل',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    controller: phoneController,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل رقم الموبيل',
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
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: customTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  كلمة السر',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    controller: passwordController,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل كلمة السر',
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
                    ),
                    obscureText: true,
                    style: customTextStyle,
                  ),
                ],
              ),
              GestureDetector(
            onTap: () {
             
        
                Navigator.pushNamed(context, '/resetPassword');


            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'هل نسيت كلمة السر؟',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                                      color: Colors.blue, // Change the text color to blue for the link

                ),
              ),
            ),
          ),
              
              SizedBox(height: 10),
              Text(
                "ان لم يكن لديك حساب",
                style: TextStyle(
                  fontFamily: AppVariables.serviceFontFamily,
                ),
              ),
               GestureDetector( // Wrap the text with GestureDetector
                onTap: () {
                   Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(
                  "اضغط هنا",
                  style: TextStyle(
                    fontFamily: AppVariables.serviceFontFamily,
                    color: Colors.blue, // Change the text color to blue for the link
                    decoration: TextDecoration.underline, // Add underline for link style
                  ),
                ),
              ),
              ElevatedButton(
                 onPressed: attemptLogin, // Call the login method here
                child: Text('تسجيل الدخول'),
              ),
                            // buildSignInButton(),

      //   Center(
      //   child: userToken != null
      //       ? Text('User Token: $userToken')
      //       : Text('Token not available'),
      // ),
    

            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }
}


