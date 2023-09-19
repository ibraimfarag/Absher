// ignore_for_file: unused_local_variable

import 'package:absherv2/screens/imports.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    // Removed the unused themeColor variable
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppVariables.customPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MainHomeScreen(), // Set MainHomeScreen as the initial screen
      ),
       routes: {
    '/screen1': (context) => MainHomeScreen(), // Replace MainHomeScreen with your home screen
    '/screen2': (context) => MainHomeScreenService(), // Define a route for Screen 1
    '/login': (context) => LoginScreen(), // Define a route for Screen 1

  },
    );
  }
}
