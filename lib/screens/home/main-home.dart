import 'package:absherv2/screens/imports.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final List<Testimonial> _testimonials = getTestimonials();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row 1
            Container(
              color: Colors.transparent,
              height: 200,
              child: const ImageSlider(
                assetImagePaths: [
                  'assets/banner1.png',
                  'assets/banner2.png',
                  'assets/banner3.png',
                  // Add more asset image paths as needed
                ],
              ),
            ),
            // Row 2
            Container(
              // height: 150, // Adjust the height of the slider
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/banner4.png', // Replace with your logo image path
                    width: 460, // Adjust the logo height as needed
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
             SizedBox(
  height: 200,
  child: DynamicItemListGrid(
    itemCount: 8,
    dynamicItemsFuture: fetchDynamicItems(), // Replace with your data fetching method
  ),
),
            // Row 4
            Container(
              color: Colors.transparent,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  // _currentIndex = 1;
                },
                child: const Center(
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppVariables.fontSizesmail,
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
            Container(
              color: AppVariables.themeColor,
              height: 50,
              child: const Center(
                  child: Text(
                'placeHolder',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppVariables.fontSizesmail,
                  color: AppVariables.textcolor, // Set your desired text color
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
