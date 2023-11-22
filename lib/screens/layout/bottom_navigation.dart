import 'package:absherv2/screens/imports.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  MyBottomNavigationBar({required this.initialIndex});

  @override
  _MyBottomNavigationBarState createState() =>
      _MyBottomNavigationBarState(initialIndex);
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex;

  _MyBottomNavigationBarState(this._currentIndex);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      // Set the default text style for the entire BottomNavigationBar
      style: TextStyle(
        fontFamily: AppVariables.serviceFontFamily, // Use the font family you defined in pubspec.yaml
        fontSize: 20, // Adjust the font size as needed
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle tab tap
          setState(() {
            _currentIndex = index;
          });

          // Navigate to the corresponding screen
          switch (index) {
            case 0:
              // Navigate to Screen 1
              Navigator.pushReplacementNamed(context, '/screen1');
              break;
            case 1:
              // Navigate to Screen 2
              Navigator.pushReplacementNamed(context, '/screen2');
              break;
            
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'الخدمات',
          ),
         
        ],
      ),
    );
  }
}