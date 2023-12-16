import 'package:Abshr/screens/imports.dart';







class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final List<Testimonial> _testimonials = getTestimonials();
  // int _currentIndex = 0;
  

  @override
  Widget build(BuildContext context) {

    return  Directionality(
        // Set the text direction for the app
        textDirection: TextDirection.rtl, // or TextDirection.rtl
        // textDirection: TextDirection.ltr, // or TextDirection.rtl
        child:  Scaffold(
           appBar: MyAppBar(showBackButton: false),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row 1
            Container(
              color: Colors.transparent,
              height: 200,
              width: 400,
              child:  const ImageSlider(assetImagePaths: [], ),
            ),
            // Row 2
            Container(
  padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
  child: Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: API.fetchSettings(), // Assuming fetchSettings returns the list of settings
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No settings available');
          } else {
            // Find the setting with ID 3 (or the desired ID)
            final setting = snapshot.data!.firstWhere(
              (setting) => setting['name'] == 'Planner One', // Change this to the desired ID
              orElse: () => Map<String, dynamic>(), // Default to an empty map if not found
            );

            // Check if the setting was found
            if (setting.isNotEmpty && setting['type'] == 'file') {
              final imageUrl = setting['value'];
              return Image.network(
                imageUrl,
                width: 460,
              );
            } else {
              return Text('Image setting not found or not of type "file"');
            }
          }
        },
      ),
    ),
  ),
),

            // Row 3
            Container(
              color: Colors.transparent,
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Adjust the padding as needed
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0), // Adjust the padding as needed
                          child: Image.asset(
                            'assets/services_logo_ar.png', // Replace with your image asset path
                            height: 60, // Adjust the height as needed
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add your grid list view below
                ],
              ),
            ),
//              SizedBox(
//   height: 200,
//   child: DynamicItemListGrid(
    
//     itemCount: 8,
//     dynamicItemsFuture: fetchDynamicItems(), // Replace with your data fetching method
//     navigator: Navigator.of(context),
//   ),
// ),
        Container(
          // height: 200,  // Set a fixed height or use other sizing constraints as needed
          child: DynamicItemListGrid(
            itemCount: 8,
            dynamicItemsFuture: fetchDynamicItems(),
            navigator: Navigator.of(context),
          ),
        ),

            // Row 4
            Container(
              color: Colors.transparent,
              height: 50,
              child: GestureDetector(
                onTap: () {
                                          Navigator.pushReplacementNamed(context, '/screen2');

                },
                child: const Center(
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppVariables.fontSizesmail,
                                                      fontFamily: AppVariables.serviceFontFamily,

                      color: AppVariables
                          .themeColor, // Set your desired text color
                    ),
                  ),
                ),
              ),
            ),SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.transparent,
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0), // Adjust the padding as needed
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 0.0), // Adjust the padding as needed
                          child: Image.asset(
                            'assets/reviews_ar.png', // Replace with your image asset path
                            height: 50, // Adjust the height as needed
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add your grid list view below
                ],
              ),
            ),
            // Row 5
            Container(
                color: Colors.transparent,
                height: 280,
                child: TestimonialList(
                  testimonials: _testimonials,
                )),
            // Row 6
    
          ],
        ),
      ),
                 bottomNavigationBar: MyBottomNavigationBar(initialIndex: 0), // Add the bottom navigation bar here


          drawer: const CustomDrawer(),
    ),
    
    );
  
  }
}
