import 'dart:convert';

import 'package:Absher/screens/imports.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  TextStyle customTextStyle = TextStyle(
    fontFamily: AppVariables.serviceFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? userName = authProvider.name;
    String? userEmail = authProvider.email;
      final String? token = authProvider.token;
    nameController.text = userName ?? '';
    emailController.text = userEmail ?? '';
  }

  // Function to update the user's profile
// Function to update the user's profile
Future<void> updateProfile() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final String? token = authProvider.token;

  if (token != null) {
    final String name = nameController.text;
    final String email = emailController.text;

    final Map<String, dynamic> requestData = {
      'name': name,
      'email': email,
    };

    try {
      final response = await API.updateProfile(context, requestData);


    } catch (e) {
      // Handle any exceptions that may occur
      // Show an error dialog or handle the error appropriately
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(
        'خطأ في التحديث',
        textAlign: TextAlign.right,
      ),
      content: Text(
        'حدث خطأ أثناء تحديث معلومات الحساب.',
        textAlign: TextAlign.right,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the error dialog
          },
          child: Text('موافق'),
        ),
      ],
    );
  },
);

    }
  }
}
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
                    '  الاسم',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل اسم',
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
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(255),
                    ],
                    style: customTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfile, // Call the updateProfile method here
                child: Text('تحديث'),
              ),
                            SizedBox(height: 20),
SizedBox(height: 20),

    // Button to disable the account temporarily
// Inside the _ProfileScreenState class
ElevatedButton(
  onPressed: () async {
    // Show a confirmation dialog before deactivating the account
    bool confirmDeactivation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تأكيد تعطيل الحساب',
            textAlign: TextAlign.right,
          ),
          content: Text(
            'هل أنت متأكد أنك تريد تعطيل الحساب؟',
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User doesn't confirm
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms
              },
              child: Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirmDeactivation == true) {
      // User confirmed, proceed with account deactivation
      await API.deactivateAccount(context);

      // Logout and clear cache
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout();
            Navigator.pushNamedAndRemoveUntil(
        context,
        '/screen1', // Replace '/home' with the route name of your home screen
        (Route<dynamic> route) => false,
      );

    }
  },
  child: Text('تعطيل الحساب مؤقتاً'),
),

    SizedBox(height: 20),

    // Button to delete the account permanently
    ElevatedButton(
  onPressed: () async {
    bool confirmDeletion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تأكيد حذف الحساب',
            textAlign: TextAlign.right,
          ),
          content: Text(
            'هل أنت متأكد أنك تريد حذف الحساب نهائياً؟',
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User doesn't confirm
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms
              },
              child: Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirmDeletion == true) {
      // User confirmed, proceed with account deletion
      await API.deleteAccount(context);

      // Logout and clear cache
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout();

      // Navigate to the home route screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/screen1', // Replace '/home' with the route name of your home screen
        (Route<dynamic> route) => false,
      );
    }
  },
  child: Text('حذف الحساب نهائياً'),
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
