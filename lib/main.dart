// ignore_for_file: unused_local_variable

import 'package:absherv2/screens/imports.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String? cachedToken = await API.getCachedUserToken();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MainApp(),

    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final authProvider = Provider.of<AuthProvider>(context);

    // Removed the unused themeColor variable
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppVariables.customPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  MainHomeScreen() , // Set MainHomeScreen as the initial screen
        // body: authProvider.isAuthenticated ? MainHomeScreen() : LoginScreen(), // Set MainHomeScreen as the initial screen
      ),
       routes: {
    '/screen1': (context) => MainHomeScreen(), // Replace MainHomeScreen with your home screen
    '/screen2': (context) => MainHomeScreenService(), // Define a route for Screen 1
    '/login': (context) => LoginScreen(), // Define a route for login
    '/register': (context) => RegisterScreen(), // Define a route for rigster
    '/verify': (context) => VerifyScreen(), // Define a route for verify
    '/profile': (context) => ProfileScreen(), // Define a route for update ProfileScreen
    '/changePassword': (context) => ChangePasswordScreen(), // Define a route for ChangePasswordScreen
    '/RequestOrder': (context) => RequestOrderScreen(), // Define a route for ChangePasswordScreen

  },
    );
  }
}
