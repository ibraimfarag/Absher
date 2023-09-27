import 'package:absherv2/screens/imports.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestOrderScreen extends StatefulWidget {
  final String? locationLink; // Location link received from MapSelectionScreen

  RequestOrderScreen({this.locationLink});

  @override
  State<RequestOrderScreen> createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen> {
   TextStyle customTextStyle = TextStyle(
    fontFamily: AppVariables.serviceFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  
Future<LocationPermission> _requestLocationPermission() async {
  final status = await Permission.location.request();
  if (status.isGranted) {
    return LocationPermission.always; // or LocationPermission.whileInUse
  } else {
    return LocationPermission.denied;
  }
}

//  late GoogleMapController mapController;

//    final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: MyAppBar(showBackButton: false),
        body:  SingleChildScrollView( // Wrap your content in SingleChildScrollView
          padding: const EdgeInsets.all(16.0),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                   Text(
                    '  تم اختيار خدمة :  ',
                    style: customTextStyle,
                  ),
                   Text(
                    '  رقم الخدمة:  ',
                    style: customTextStyle,
                  ),
                 Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  رقم الموبيل اضافي "اختياري" ',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: ' ادخل رقم موبيل اخر',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: customTextStyle,
                  ),
                ],
              ),
            SizedBox(height: 20),
 Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  المدينة',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: '  ادخل اسم المدينة ',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                    ),
                     // Change keyboardType to TextInputType.text for entering a username
  keyboardType: TextInputType.text,
  // Remove the inputFormatters for username, or you can add specific formatters as needed
  // Example: You can add a LengthLimitingTextInputFormatter if you want to limit the length
  // inputFormatters: <TextInputFormatter>[
  //   LengthLimitingTextInputFormatter(30), // Adjust the limit as needed
  // ],
                 
                    style: customTextStyle,
                  ),
                ],
              ),
            SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  المنطقة',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: '  ادخل اسم االمنطقة او الحي ',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                    ),
                     // Change keyboardType to TextInputType.text for entering a username
  keyboardType: TextInputType.text,
  // Remove the inputFormatters for username, or you can add specific formatters as needed
  // Example: You can add a LengthLimitingTextInputFormatter if you want to limit the length
  // inputFormatters: <TextInputFormatter>[
  //   LengthLimitingTextInputFormatter(30), // Adjust the limit as needed
  // ],
                 
                    style: customTextStyle,
                  ),
                ],
              ),
            SizedBox(height: 20),

             

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  العنوان التفصيلي',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: '   مثال : 5 ش مراد ,الجيزة',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                    ),
                     // Change keyboardType to TextInputType.text for entering a username
  keyboardType: TextInputType.text,
  // Remove the inputFormatters for username, or you can add specific formatters as needed
  // Example: You can add a LengthLimitingTextInputFormatter if you want to limit the length
  // inputFormatters: <TextInputFormatter>[
  //   LengthLimitingTextInputFormatter(30), // Adjust the limit as needed
  // ],
                 
                    style: customTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),

              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  العنوان التفصيلي',
                    style: customTextStyle,
                  ),
                  TextFormField(
                                  initialValue: widget.locationLink ?? '', // Display the location link

                    // ... (other TextFormFie
                    //ld properties)

                                  readOnly: false, // Make it read-only

                  ),
                  SizedBox(height: 20),

                  // "Select on Map" button
ElevatedButton(
  onPressed: () async {
    final permissionStatus = await _requestLocationPermission();
    if (permissionStatus == LocationPermission.always || permissionStatus == LocationPermission.whileInUse) {
      final selectedLocation = await Navigator.push<LatLng>(
        context,
        MaterialPageRoute(
          builder: (context) => MapSelectionScreen(),
        ),
      );

      // Handle the selectedLocation here, it will be a LatLng object
      if (selectedLocation != null) {
        // Use the selected location as needed
      }
    } else {
      print('Location permission denied');
    }
  },
  child: Text(
    'حدد على الخريطة',
    style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
  ),
)



                ],
              ),
              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  ملاحظات',
                    style: customTextStyle,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: '   اضف ملاحظات فنية او شرح ',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 240, 240),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 218, 217, 217),
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 240, 240),
                          width: 2.0,
                        ),
                      ),
                    ),
                     // Change keyboardType to TextInputType.text for entering a username
  keyboardType: TextInputType.text,
  // Remove the inputFormatters for username, or you can add specific formatters as needed
  // Example: You can add a LengthLimitingTextInputFormatter if you want to limit the length
  // inputFormatters: <TextInputFormatter>[
  //   LengthLimitingTextInputFormatter(30), // Adjust the limit as needed
  // ],
                 
                    style: customTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 20),
          
             
             
             ElevatedButton(
  onPressed: () async {
  },
  child: Text('ارسال الطلب',    style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
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

    // Function to show the map
  void _showMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Select Location on Maps'),
          ),
          body: MapSelectionScreen()

        ),
      ),
    );
  }
}
