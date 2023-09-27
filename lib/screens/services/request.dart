import 'package:absherv2/screens/imports.dart';

class RequestOrderScreen extends StatefulWidget {
  @override
  State<RequestOrderScreen> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen> {
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
        body:  SingleChildScrollView( // Wrap your content in SingleChildScrollView
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
 controller: phoneController , 
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
 controller: emailController  , 

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
                   keyboardType: TextInputType.emailAddress, // Use TextInputType.emailAddress
  inputFormatters: <TextInputFormatter>[
    LengthLimitingTextInputFormatter(255), // Limit the length to a reasonable email length (255 characters)
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
 controller: passwordController   , 

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
             
              SizedBox(height: 10),
              Text(
                "ان كان لديك حساب",
                style: TextStyle(
                  fontFamily: AppVariables.serviceFontFamily,
                ),
              ),
               GestureDetector( // Wrap the text with GestureDetector
                onTap: () {
                   Navigator.pushReplacementNamed(context, '/login');
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
  onPressed: () async {
    // Call the registration method here
    try {
      await API.registerUser(
        nameController.text,
        phoneController.text,
        emailController.text,
        passwordController.text,
      );

      // Registration successful, navigate to VerifyScreen with the phone number
      Navigator.pushReplacementNamed(
        context,
        '/verify',
        arguments: {'phone': phoneController.text}, // Pass the phone number
      );
    } catch (e) {
      // Handle registration error here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ في التسجيل', textAlign: TextAlign.right),
            content: Text(
              e.toString(),
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
