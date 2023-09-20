import 'dart:convert';

import 'package:absherv2/main.dart';
import 'package:absherv2/screens/imports.dart';
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
Future<void> attemptLogin() async {
  final String phone = phoneController.text;
  final String password = passwordController.text;

  try {
    final String token = await API.login(phone, password);
    // Decode the token to extract information
    Map<String, dynamic> decodedToken = json.decode(
      utf8.decode(
        base64Url.decode(token.split('.')[1]),
      ),
    );

    String name = decodedToken['name'];
    
    // Access the AuthProvider and update the authentication state
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(token, name);

    // Handle successful login and navigation
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp()));
  } catch (e) {
    // Handle login failure
 showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('خطأ في تسجيل الدخول', textAlign: TextAlign.right),
      content: Text(
        'حدث خطأ أثناء محاولة تسجيل الدخول. الرجاء التأكد من بيانات الدخول و المحاولة مرة أخرى.',
        textAlign: TextAlign.right,
      ),  // Replace with your Arabic error message
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
}  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Text(
                    'تذكرني',
                    style: TextStyle(
                      fontFamily: AppVariables.serviceFontFamily,
                    ),
                  ),
                ],
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
                  // Handle the tap event, e.g., navigate to another screen
                  // You can use Navigator to navigate to a different screen
                  // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherScreen()));
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
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
