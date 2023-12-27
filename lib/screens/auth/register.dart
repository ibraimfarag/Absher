import 'package:Absher/main.dart';
import 'package:Absher/screens/imports.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    bool isChecked = false;
  TextStyle customTextStyle = TextStyle(
    fontFamily: AppVariables.serviceFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: false),
        body: SingleChildScrollView(
          // Wrap your content in SingleChildScrollView
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  اسم المستخدم',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    controller: nameController, // Use the name controller here
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل اسم المستخدم',
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
                    // Change keyboardType to TextInputType.text for entering a username
                    keyboardType: TextInputType.text,
                    // Remove the inputFormatters for username, or you can add specific formatters as needed
                    // Example: You can add a LengthLimitingTextInputFormatter if you want to limit the length
                    // inputFormatters: <TextInputFormatter>[
                    //   LengthLimitingTextInputFormatter(30), // Adjust the limit as needed
                    // ],

                    style: customTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                    '  البريد الالكتروني',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    controller: emailController,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل البريد الالكتروني',
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
                    keyboardType: TextInputType
                        .emailAddress, // Use TextInputType.emailAddress
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(
                          255), // Limit the length to a reasonable email length (255 characters)
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
SizedBox(height: 10),
  Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: AppVariables.serviceFontFamily,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "أوافق على الشروط والأحكام، للمزيد ",
              ),
              TextSpan(
                text: "اضغط هنا",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Define the route to navigate to when "اضغط هنا" is clicked
                    Navigator.pushNamed(context, '/privacy');
                  },
              ),
            ],
          ),
        ),
      ],
    ),
  Row(children: [    if (!isChecked) // Show an error message if the checkbox is not checked
    Text(
      "يجب الموافقة على الشروط والأحكام للمتابعة",
      style: TextStyle(
        color: Colors.red,
        fontFamily: AppVariables.serviceFontFamily,
      ),
    ),],)


                ],
              ),
              SizedBox(height: 10),
              Text(
                "ان كان لديك حساب",
                style: TextStyle(
                  fontFamily: AppVariables.serviceFontFamily,
                ),
              ),
              GestureDetector(
                // Wrap the text with GestureDetector
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "اضغط هنا",
                  style: TextStyle(
                    fontFamily: AppVariables.serviceFontFamily,
                    color: Colors
                        .blue, // Change the text color to blue for the link
                    decoration: TextDecoration
                        .underline, // Add underline for link style
                  ),
                ),
              ),
       ElevatedButton(
  onPressed: () async {
    if (!isChecked) {
      // Display an error or prevent registration
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ في التسجيل', textAlign: TextAlign.right),
            content: Text(
              "يجب الموافقة على الشروط والأحكام للتسجيل",
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
    } else {
      try {
        // Call the registration method here
        await API.registerUser(
              nameController.text,
    phoneController.text ?? '',
    emailController.text,
    passwordController.text ?? '',
        );
        
        // Login the user automatically after successful registration
        final token = await API.login(
            phoneController.text, passwordController.text);

        // Decode the token and set it in the AuthProvider
        final authProvider =
            Provider.of<AuthProvider>(context, listen: false);
        authProvider.decodeAndSetToken(token!);

        // Navigate to the next screen or perform other actions
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainApp()));
  


      } catch (e) {
    // Handle login failure and display the API response message
    
    String errorMessage = '$e'; // Display the error message;

    // Check if the error is an HTTP response error

print('error : $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خطأ في عملية التسجيل', textAlign: TextAlign.right),
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
  },
  child: Text('تسجيل'),
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
