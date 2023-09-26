import 'package:absherv2/screens/imports.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
        // Access the AuthProvider using Provider.of
    final authProvider = Provider.of<AuthProvider>(context);
    bool isAuthenticated = authProvider.isAuthenticated;

    // Retrieve the user's name from the AuthProvider
    String? userName = authProvider.name;
    return Drawer(
      child: Directionality(
        // Set the text direction for the app
        textDirection: TextDirection.ltr, // or TextDirection.rtl
        // textDirection: TextDirection.ltr, // or TextDirection.rtl
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height-60 ,
                color: AppVariables().menuBackgroundColor,
                padding: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                child: Column(
                  children: [
                      if (isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.account_circle_outlined,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        ' $userName مرحبا ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
 onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainHomeScreen()),
    );
  },

                    ),
                    ListTile(
                      trailing: Icon(
                        Icons.home,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'الرئيسية',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
 onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainHomeScreen()),
    );
  },

                    ),
                        if (!isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.fingerprint,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'تسجيل الدخول',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                      onTap: () {
                         Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                      if (!isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.person,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'التسجيل',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                      onTap: () {
                             Navigator.pushReplacementNamed(context, '/register');
                      },
                    ),

                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.local_offer,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'العروض',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.shopping_bag,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'طلباتي',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                    //   if (isAuthenticated)
                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.account_balance_wallet,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'المحفظة',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.share,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'دعوة الاصدقاء',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                      if (isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.manage_accounts,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'الملف الشخصي',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                      onTap: () {
                             Navigator.pushReplacementNamed(context, '/profile');
                      },
                    ),
                      if (isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.password,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'تغير كلمة السر ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                      onTap: () {
                             Navigator.pushReplacementNamed(context, '/changePassword');
                      },
                    ),
                      if (isAuthenticated)
                    ListTile(
                      trailing: Icon(
                        Icons.logout_outlined,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'تسجيل الخروج',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                      onTap: () {
                       authProvider.logout();
                      },
                    ),
                    
                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.info,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'عن الشركة',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                    // ListTile(
                    //   trailing: Icon(
                    //     Icons.phone_enabled,
                    //     color: AppVariables().iconColor,
                    //     size: AppVariables().iconSize, // Set the icon size here
                    //   ),
                    //   title: Text(
                    //     'اتصل بنا',
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       color: AppVariables().titleColor,
                    //       fontSize: AppVariables().titleFontSize,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: AppVariables().titleFontFamily,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Handle menu item 1 click
                    //   },
                    // ),
                    ListTile(
                      trailing: Icon(
                        Icons.chat_bubble_outline,
                        color: AppVariables().iconColor,
                        size: AppVariables().iconSize, // Set the icon size here
                      ),
                      title: Text(
                        'الشكاوي و الأقترحات',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppVariables().titleColor,
                          fontSize: AppVariables().titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppVariables().titleFontFamily,
                        ),
                      ),
                     onTap: () async {
  final phoneNumber = '01001802203'; // Replace with the desired phone number
  final message = 'مرحبًا، أنا أود القدوم ببعض الاقتراحات/الشكاوي';

  final whatsappUrl = 'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeQueryComponent(message)}';

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    // Handle error - unable to launch WhatsApp
    print('Could not launch WhatsApp');
  }
},

                    ),
                    // Add more menu items as needed
                  ],
                ),
              ),              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  'assets/logo.png', // Replace with your image path
                  width: 500,
                  fit: BoxFit.contain,
                ),
              ),

            ],
          ),
          
        ),
        
      ),
  
    );
  }
}
