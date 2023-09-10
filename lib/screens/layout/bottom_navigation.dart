import 'package:absherv2/screens/imports.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;

  const MyBottomNavigationBar({super.key, 
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'الخدمات',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'العروض',
        // )
      ],
    );
  }
}
