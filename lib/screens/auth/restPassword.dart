import 'dart:convert';

import 'package:Absher/main.dart';
import 'package:Absher/screens/imports.dart';
import 'package:provider/provider.dart';





class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  PageController _pageController = PageController(initialPage: 0);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
   appBar: MyAppBar(showBackButton: true),
        body: PageView(
          controller: _pageController,
          children: [
            _buildEmailSlide(),
            _buildCodeAndNewPasswordSlide(),
          ],
        ),
              bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }

  Widget _buildEmailSlide() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'إعادة تعيين كلمة المرور',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
      decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'البريد الإلكتروني',
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
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
       ElevatedButton(
  onPressed: () async {
    try {
      // Send the verification code
      await API.sendVerificationCode(_emailController.text);

      // Move to the next slide
      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } catch (e) {
      // Handle the error (e.g., show an error dialog)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('$e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('موافق'),
              ),
            ],
          );
        },
      );
    }
  },
  child: Text('إرسال الرمز'),
),

        ],
      ),
    );
  }

Widget _buildCodeAndNewPasswordSlide() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'إعادة تعيين كلمة المرور',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(height: 5),
        // Display the entered email
        // Text(
        //   'للبريد الالكتروني: ${_emailController.text}',
        //   style: TextStyle(fontSize: 16.0),
        // ),
        SizedBox(height: 20),
        TextField(
          controller: _codeController,
             decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'رمز التحقق',
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
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _newPasswordController,
            decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'كلمة المرور',
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
        ),
        SizedBox(height: 20),
        TextField(
          controller: _confirmPasswordController,
        
          
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'تأكيد كلمة المرور الجديدة',
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
        ),
        SizedBox(height: 20),

        // Display an error message if passwords don't match
        if (_newPasswordController.text != _confirmPasswordController.text)
          Text(
          'كلمة السر غير متطابقة مع تاكيد كلمة السر , الرجاء التأكد و اعادة المحاولة ',
            style: TextStyle(color: Colors.red),
          ),

        ElevatedButton(
          onPressed: () async {
            // Check if passwords match before proceeding
            if (_newPasswordController.text != _confirmPasswordController.text) {
              // Display an error message
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('خطأ'),
                    content: Text('كلمة السر غير متطابقة مع تاكيد كلمة السر , الرجاء التأكد و اعادة المحاولة '),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                          
                        },
                        child: Text('موافق'),
                      ),
                    ],
                  );
                },
              );
              return; // Exit the function to prevent further execution
            }

            try {
              // Reset the password
              String? token = await API.resetPassword(
                _emailController.text,
                _codeController.text,
                _newPasswordController.text,
                _confirmPasswordController.text,
              );

              // Show a success dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('نجاح'),
                    content: Text('تم إعادة تعيين كلمة المرور بنجاح'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Add navigation code here if needed

                              if (token != null) {
                            // Decode the token and set it in the AuthProvider
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            authProvider.updateToken(token);
                            authProvider.decodeAndSetToken(token);
                            Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainHomeScreen()), // Replace MainScreen with your actual main screen widget
                  );
                          }
                        },
                        child: Text('موافق'),
                      ),
                    ],
                  );
                },
              );
            } catch (e) {
              // Handle the error (e.g., show an error dialog)
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('خطأ'),
                    content: Text('$e'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('موافق'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('تأكيد إعادة تعيين كلمة المرور'),
        ),
      ],
    ),
  );
}


}