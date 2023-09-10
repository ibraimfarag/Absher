import 'package:absherv2/screens/imports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0, // shadow split
      toolbarHeight: 100,
      backgroundColor: Colors.white,
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 40,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: AppVariables.themeColor, // Replace with your desired color
          ),
          onPressed: () {
            // Open the drawer when the menu icon is pressed
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      // actions: [],
    );
  }
}
