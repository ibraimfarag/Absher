import 'package:absherv2/screens/imports.dart';

class MainHomeScreenService extends StatefulWidget {
  const MainHomeScreenService({super.key});

  @override
  State<MainHomeScreenService> createState() => _MainHomeScreenServiceState();
}

class _MainHomeScreenServiceState extends State<MainHomeScreenService> {
  final List<Testimonial> _testimonials = getTestimonials();
 late Future<List<DynamicItem>> dynamicItems;
 
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
                  // Add more asset image paths as needed
                ],
              ),
            ),
            // Row 2

            // Row 3
            Container(
              color: Colors.transparent,
              height: 120,
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
                            height: 80, // Adjust the height as needed
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
                height: MediaQuery.of(context).size.height,
                child:  DynamicItemListGrid(
    itemCount: 8,
    dynamicItemsFuture: fetchDynamicItems(), // Replace with your data fetching method
  ),),
            // Row 4

            Container(
              color: Colors.transparent,
              height: 120,
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
                'placeHolder services',
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
