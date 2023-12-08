import 'package:Abshr/screens/imports.dart';
import 'package:provider/provider.dart';

class MyRequestsScreen extends StatefulWidget {
  @override
  _MyRequestsScreenState createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  List<Map<String, dynamic>> ownRequests = [];

  @override
  void initState() {
    super.initState();
    // Call the API to fetch own requests when the screen initializes
    fetchOwnRequests();
  }

  Future<void> fetchOwnRequests() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? token = authProvider.token;

      if (token != null) {
        List<Map<String, dynamic>> requests = await API.getOwnRequests(token);
        setState(() {
          ownRequests = requests;
        });
      }
    } catch (e) {
      print('Error fetching own requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                
                  Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align the row to the end
        children: [
           Icon(
            Icons.request_quote,
            color: AppVariables.themeColor,
            size: 30, // Set your desired icon size
          ),
          Text(
            ' الطلبات السابقة',
            textAlign: TextAlign.right,
            style: TextStyle(
                                  fontFamily: AppVariables.serviceFontFamily,

              fontSize: 25, // Set your desired font size
              fontWeight: FontWeight.bold,
              color: AppVariables.themeColor,
            ),
          ),
         
        ],
      ),
                // Use a Column to display each request
                for (int index = 0; index < ownRequests.length; index++)
                  buildRequestCard(ownRequests[index]),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }
Widget buildRequestCard(Map<String, dynamic> request) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241), // Set your desired background color
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${request['servingName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppVariables.fontSizesmail,
                    fontFamily: AppVariables.serviceFontFamily,
                    color: AppVariables.themeColor,
                  ),
                ),
                Text(
                  ' ${formatDate(request['date'])}',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    GestureDetector(
      onTap: () {
     Navigator.pushNamed(
      context,
      '/request',
      arguments: request, // Pass the selected request as arguments
    );

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Align the row to the end
        children: [
          Text(
            ' تفاصيل',
            textAlign: TextAlign.right,
            style: TextStyle(
                                  fontFamily: AppVariables.serviceFontFamily,

              fontSize: 16, // Set your desired font size
              color: AppVariables.themeColor,
            ),
          ),
          Icon(
            Icons.arrow_forward,
            color: AppVariables.themeColor,
            size: 18, // Set your desired icon size
          ),
        ],
      ),
    ),
  ],
),

          ],
        ),
      ),
    
  );
}

   String formatDate(String dateString) {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);

    // Format the date using a custom function
    String formattedDate = " ${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)} "
        " الساعة : ${_twoDigits(date.hour)}:${_twoDigits(date.minute)} ${_getPeriod(date.hour)}";

    return formattedDate;
  }

  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  String _getPeriod(int hour) {
    return hour >= 12 ? 'PM' : 'AM';
  }
}
