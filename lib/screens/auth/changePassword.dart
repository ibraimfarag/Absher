import 'dart:convert';

import 'package:absherv2/screens/imports.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  
  TextStyle customTextStyle = TextStyle(
    fontFamily: AppVariables.serviceFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

 TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false; // Define the variable here

  @override
  Widget build(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context);
  final String? token = authProvider.token;
       print('$token');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: false),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  كلمة السر الجديدة',
                    style: customTextStyle,
                  ),
                  Stack(
  children: [
    TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'ادخل كلمة السر الجديدة',
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
      keyboardType: TextInputType.text,
      style: customTextStyle,
      obscureText: !isPasswordVisible,
    ),
    Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isPasswordVisible
                    ? Colors.transparent
                    : Colors.transparent,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
)

                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  تأكيد كلمة السر الجديدة',
                    style: customTextStyle,
                  ),
Stack(
  children: [
    TextFormField(
      controller: confirmPasswordController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'ادخل كلمة السر الجديدة',
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
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(255),
      ],
      style: customTextStyle,
      obscureText: !isConfirmPasswordVisible,
    ),
    Align(
      alignment: AlignmentDirectional.centerEnd,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isConfirmPasswordVisible = !isConfirmPasswordVisible;
          });
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isConfirmPasswordVisible
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.transparent,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
)

                ],
              ),
              SizedBox(height: 20),
ElevatedButton(
  onPressed: () async {
    final String newPassword = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      // Handle empty fields, show an error message, or prevent submission.
      return;
    }

    if (newPassword != confirmPassword) {
      // Passwords don't match, show an alert
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(
        'خطأ',
        textAlign: TextAlign.right, // Align the title to the right
      ),
      content: Text(
        'كلمة السر وتأكيد كلمة السر غير متطابقين.',
        textAlign: TextAlign.right, // Align the content to the right
      ),
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

      return;
    }

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? token = authProvider.token;

      if (token != null) {
        // Send a request to change the password
        await API.updatePassword(token, newPassword, confirmPassword);

        // Show a success alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تم تغيير كلمة السر بنجاح'),
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

        // Optionally, you can clear the text fields:
        passwordController.clear();
        confirmPasswordController.clear();
      }
    } catch (e) {
      // Handle any errors, e.g., show an error message
      print('Error changing password: $e');
    }
  },
  child: Text('تحديث'),
),

                        SizedBox(height: 20),
// Text(
//   'Your Token: ${authProvider.token}', // Display the token here
//   style: customTextStyle,
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
