
import 'package:absherv2/screens/imports.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:multi_image_picker/multi_image_picker.dart';






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
DateTime? selectedDate;
TimeOfDay? selectedTime;
List<Asset> selectedImages = [];

Future<void> _pickImages() async {
  List<Asset> resultList = <Asset>[];
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 10, // Set the maximum number of images to pick
      enableCamera: true, // Enable camera option
    );
  } on Exception catch (e) {
    // Handle exceptions if necessary
  }

  if (!mounted) return;

  setState(() {
    selectedImages = resultList;
  });
}



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
    // Retrieve the arguments
     // Retrieve the arguments passed from ServiceDetailsScreen
    final ServiceDetailsArguments? args =
        ModalRoute.of(context)!.settings.arguments as ServiceDetailsArguments?;

    if (args != null) {
      // You can access the arguments like this:
      // args.id, args.subId, args.name, args.imagePath, etc.

      // Use the arguments in your UI or logic as needed.
    }
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
                    '  تم اختيار خدمة : ${args?.id} ',
                    style: customTextStyle,
                  ),
                   Text(
                    '  رقم الخدمة: ${args?.name}',
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

Align(
  alignment: Alignment.centerRight,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '  حدد التاريخ و الساعة   ',
        style: customTextStyle,
      ),
      ElevatedButton(
        onPressed: () async {
          // Show Date Picker
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null && pickedDate != selectedDate) {
            setState(() {
              selectedDate = pickedDate;
            });
          }

          // Show Time Picker
          final pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null && pickedTime != selectedTime) {
            setState(() {
              selectedTime = pickedTime;
            });
          }
        },
        child: Text(
          'اختر التاريخ و الساعه',
          style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
        ),
      ),
      // Display selected date and time in the custom format
      if (selectedDate != null && selectedTime != null)
        Text(
          'لقد اخترت موعد الزيارة يوم ${selectedDate!.toLocal().toString().split(' ')[0]} في الساعة ${selectedTime!.format(context)} بنجاح',
          style: customTextStyle,
        ),
    ],
  ),
),





     SizedBox(height: 20),
Align(
  alignment: Alignment.centerRight,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ... Your existing form fields ...

      // Add a button to pick multiple images
      ElevatedButton(
        onPressed: _pickImages,
        child: Text(
          'اختر صور',
          style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
        ),
      ),

      // Display the selected images if available
      if (selectedImages.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الصور المختارة:',
              style: customTextStyle,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(selectedImages.length, (index) {
                return Stack(
                  children: [
                    AssetThumb(
                      asset: selectedImages[index],
                      width: 100,
                      height: 100,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImages.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
    ],
  ),
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




