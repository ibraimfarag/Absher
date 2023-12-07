import 'package:Abshr/screens/imports.dart';
import 'package:provider/provider.dart';
class ServiceDetailsScreen extends StatefulWidget {
  final int id;
  final int subId;
  final String name;
  final String imagePath;
  final String coverPath;
  final String bio;
  final String cost;
  final String costNotes;
  final String text;

  ServiceDetailsScreen({
    required this.id,
    required this.subId,
    required this.name,
    required this.imagePath,
    required this.coverPath,
    required this.bio,
    required this.cost,
    required this.costNotes,
    required this.text,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         appBar: MyAppBar(showBackButton: true), // To show the back button
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Network Image
              Image.network(
                widget.coverPath,
                width: double.infinity, // Full width
                fit: BoxFit.cover,
              ),
              // Service Name or Details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                                                fontFamily: AppVariables.serviceFontFamily,

                  ),
                  textAlign: TextAlign.right,
                ),
              ),

              // Bio
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.bio,
                  textAlign: TextAlign.right,
                  style: TextStyle(                            fontFamily: AppVariables.serviceFontFamily,
),
                ),
              ),

              // Preview Cost
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '  ${widget.cost} ',
                  textAlign: TextAlign.center,
                  style: TextStyle(                            fontFamily: AppVariables.serviceFontFamily,
)
                ),
              ),

              // Cost Notes
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  ' ${widget.costNotes} ',
                  textAlign: TextAlign.center,
                  style: TextStyle(                            fontFamily: AppVariables.serviceFontFamily,
),
                ),
              ),

              // Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:ElevatedButton(
  onPressed: () {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
       // User is authenticated, perform the action here
      // Pass the service data and navigate to RequestOrderScreen
         Navigator.pushNamed(
        context,
        '/RequestOrder',
        arguments: ServiceDetailsArguments(
          id: widget.id,
          subId: widget.subId,
          name: widget.name,
          imagePath: widget.imagePath,
          coverPath: widget.coverPath,
          bio: widget.bio,
          cost: widget.cost,
          costNotes: widget.costNotes,
          text: widget.text,
        ),
      );
    } else {
      // User is not authenticated, show an alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'تنبيه',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
            ),
            content: Text(
              'لا يمكنك القيام بهذا الإجراء بدون تسجيل الدخول.',
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
            ),
            actions: [
      
              TextButton(
                onPressed: () {
                 Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
                ),
              ),
              TextButton(
                onPressed: () {
                   
                     Navigator.pushReplacementNamed(context, '/register');

                },
                child: Text(
                  'التسجيل',
                  style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
                ),
              ),
                      TextButton(
                onPressed: () {
                 

                },
                child: Text(
                  'موافق',
                  style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
                ),
              ),
            ],
          );
        },
      );
    }
  },
  child: Text(
    'مـعـايـنـة',
    style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
  ),
),



              ),
            ],
          ),
        ),
         bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1), // Add the bottom navigation bar here

        
         drawer: const CustomDrawer(),
      ),
    );
  }
}
