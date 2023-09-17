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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color themeColor = AppVariables().primaryColor; // Example theme color

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppVariables.customPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        // Set the text direction for the app
        textDirection: TextDirection.rtl, // or TextDirection.rtl
        // textDirection: TextDirection.ltr, // or TextDirection.rtl
        child: Scaffold(
          appBar: const MyAppBar(),
       body: Builder(
  builder: (BuildContext context) {
    return _getBodyWidget(_currentIndex, Navigator.of(context));
  },
), // Pass the Navigator
          bottomNavigationBar: MyBottomNavigationBar(
            currentIndex: _currentIndex,
            onTabTapped: (index) {
              // Update the current index to change the body content
              setState(() {
                _currentIndex = index;
              });
            },
          ),

          drawer: const CustomDrawer(),
        ),
      ),
    );
  }

  Widget _getBodyWidget(int index, NavigatorState navigator) {
    switch (index) {
      case 0:
        return const MainHomeScreen();
      case 1:
        return const MainHomeScreenService();
      case 2:
 return DynamicItemListGrid(
          itemCount: 8,
          dynamicItemsFuture: fetchDynamicItems(),
          navigator: navigator, // Pass the Navigator
        );      // Add more cases for other screens
      default:
        return Container();
    }
  }
}
