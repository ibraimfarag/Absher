import 'package:Abshr/screens/imports.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Map<String, dynamic>? requestData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the arguments when the widget is created
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      // Replace "null" with "لايوجد" in the requestData
      args.forEach((key, value) {
        if (value == null) {
          args[key] = "لايوجد";
        }
      });

      // Set the requestData if arguments are not null
      setState(() {
        requestData = args;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align the row to the end
                children: [
                  Icon(
                    Icons.request_quote,
                    color: AppVariables.themeColor,
                    size: 30, // Set your desired icon size
                  ),
                  Text(
                    ' تفاصيل الطلب',
                    style: TextStyle(
                      fontFamily: AppVariables.serviceFontFamily,
                      fontSize: 25, // Set your desired font size
                      fontWeight: FontWeight.bold,
                      color: AppVariables.themeColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    if (requestData != null)
                      buildTextRow(
                          'اسم الخدمة: ', '${requestData?['servingName']}'),
                    if (requestData != null)
                      buildTextRow(' رقم الموبايل : ',
                          '${requestData?['client']['phone']}'),
                    if (requestData != null)
                      buildTextRow(' رقم الموبايل الاضافي: ',
                          '${requestData?['otherPhone']}'),
                    if (requestData != null)
                      buildTextRow('المدينة: ', '${requestData?['city']}'),
                    if (requestData != null)
                      buildTextRow('المنطقة: ', '${requestData?['district']}'),
                    if (requestData != null)
                      buildTextRow('العنوان: ',
                          '${requestData?['locationDescription']}'),
                    

                    if (requestData != null)
                      buildTextRow(
                          'الملاحظات: ', '${requestData?['comments']}'),
buildTextRow('حالة الطلب: ', requestData?['statusAR'] != null && requestData?['statusAR'].isNotEmpty
    ? '${requestData?['statusAR']}'
    : 'ليس هناك حالة محددة'),



                    if (requestData != null)
                      buildTextRow('تاريخ المعاينة: ',
                          '${formatDate(requestData?['date'])}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }

  Widget buildTextRow(String label, String value) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: AppVariables.serviceFontFamily,
                  color: AppVariables.themeColor,
                ),
                textAlign: TextAlign.right,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AppVariables.serviceFontFamily,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatDate(String dateString) {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);

    // Format the date using a custom function
    String formattedDate =
        " ${date.year}-${_twoDigits(date.month)}-${_twoDigits(date.day)} "
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
