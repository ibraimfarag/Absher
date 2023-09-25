import 'package:absherv2/screens/imports.dart';
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

    // Access the AuthProvider and get the user's name and email from the token
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? userName = authProvider.name;
    String? userEmail = authProvider.email;

    // Set the initial values of the name and email TextFormFields
    nameController.text = userName ?? ''; // Use '' if userName is null
    emailController.text = userEmail ?? ''; // Use '' if userEmail is null
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
           appBar: MyAppBar(showBackButton: false),

      body:    SingleChildScrollView( // Wrap your content in SingleChildScrollView
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
 controller: nameController, // Use the name controller here
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'ادخل اسم ',
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
               
                ],
              ),
             
              SizedBox(height: 10),
            
             ElevatedButton(
  onPressed: () async {




  },
  child: Text('تحديث'),
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
