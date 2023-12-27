import 'package:Absher/screens/imports.dart';

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
      style: TextStyle(
        fontFamily: AppVariables.serviceFontFamily,
        fontSize: 20,
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/screen1');
              break;
          
            case 1:
              // Handle the new button for sending a message on WhatsApp
              final phoneNumber = AppVariables().phoneNumber;
              final message = "Your custom message here";
              final whatsappUrl = Platform.isIOS
                  ? 'whatsapp://wa.me/$phoneNumber/?text=${Uri.encodeQueryComponent(message)}'
                  : 'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeQueryComponent(message)}';

              launchWhatsApp(whatsappUrl);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.send), // Use the appropriate icon for sending on WhatsApp
            label: 'إرسال على واتساب',
          ),
        ],
      ),
    );
  }

  // Helper method to launch WhatsApp
  Future<void> launchWhatsApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error - unable to launch WhatsApp
      print('Could not launch WhatsApp');
    }
  }
}
