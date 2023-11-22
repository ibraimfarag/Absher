
import 'package:absherv2/screens/imports.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';






class RequestOrderScreen extends StatefulWidget {

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
  bool isLoading = false;

DateTime? selectedDate;
TimeOfDay? selectedTime;
List<Asset> selectedImages = [];

  // Define TextEditingController for each TextFormField
  TextEditingController _locationLinkController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _notesController = TextEditingController();


String? TheTime;




void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(), // Show the loading indicator
            SizedBox(height: 16),
            Text("يرجى الانتظار..."), // Add a message to inform the user
          ],
        ),
      );
    },
  );
}


Future<void> _pickImages() async {
  List<Asset> resultList = <Asset>[];
  try {
    resultList = await MultipleImagesPicker.pickImages(
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
    var serviceID = args?.id;
    var serviceNAME = args?.name;
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
                    '  تم اختيار خدمة : $serviceNAME ',
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
                     controller: _mobileController , // Assign the controller
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
                     controller: _cityController , // Assign the controller
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
                     controller: _areaController , // Assign the controller
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
                    controller: _addressController, // Assign the controller
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


 Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
 Text(
                    '  رابط العنوان',
                    style: customTextStyle,
                  ),
              TextFormField(
  controller: _locationLinkController,
  onChanged: (value) {
    // Print the value when it changes
    print('TextFormField value: $value');
  },
  readOnly: false, // Make it read-only
),

                  SizedBox(height: 20),

                  // "Select on Map" button
ElevatedButton(
  onPressed: () async {
    final locationLink = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapSelectionScreen(),
      ),
    );

    // Update the TextFormField with the received locationLink
    if (locationLink != null) {
      setState(() {
        // Update the TextFormField's value with the received locationLink
        _locationLinkController.text = locationLink;
      });
    }
  },
  child: Text(
    'حدد على الخريطة',
    style: TextStyle(fontFamily: AppVariables.serviceFontFamily),
  ),
)




      // Other TextFormFields
    ],
  ),

                 


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
                    controller: _notesController, // Assign the controller
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

          // Update TheTime
        
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
Builder(
  builder: (BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        TheTime = selectedDate != null && selectedTime != null
            ? '${selectedDate!.toLocal().toString().split(' ')[0]}T${selectedTime!.hour}:${selectedTime!.minute}'
            : '';
        print(TheTime);
        setState(() {
          isLoading = true; // Start loading
        });

        // Show the loading dialog
        _showLoadingDialog(context);

        // Prepare the request data based on your requirements
        Map<String, dynamic> requestData = {
          'LocationDescription': _addressController.text,
          'ServingId': serviceID,
          'City': _cityController.text,
          'District': _areaController.text,
          'Date': TheTime,
          'LocationLink': _locationLinkController.text,
          'Comments': _notesController.text,
          'OtherPhone': _mobileController.text,
        };

        try {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          final token = authProvider.token; // Retrieve the token from your AuthProvider

          if (token != null) {
            await API.postRequestWithImages(token, requestData, selectedImages);

            // Request successful, close the loading dialog and show a success dialog
            Navigator.of(context, rootNavigator: true).pop(); // Close the loading dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'شكرًا!',
                    textAlign: TextAlign.right,
                  ),
                  content: Text(
                    'تم إرسال الطلب بنجاح مع الصور.',
                    textAlign: TextAlign.right,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the success dialog
                        Navigator.of(context).pushReplacementNamed('/screen1'); // Navigate to the main screen
                      },
                      child: Text('موافق'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Handle the case where the token is null (user is not authenticated)
            // ...
          }
          setState(() {
            isLoading = false; // Stop loading
          });
        } catch (e) {
          // Handle errors here
          print('Error posting request with images: $e');
          // Show an error message to the user or handle the error appropriately
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Text('ارسال الطلب', style: TextStyle(fontFamily: AppVariables.serviceFontFamily)),
    );
  },
),



            ],
          ),
        ),
        bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1),
        drawer: const CustomDrawer(),
      ),
    );
  }

 
}




