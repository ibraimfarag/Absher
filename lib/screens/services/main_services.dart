import 'package:Absher/screens/imports.dart';

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
    return  Directionality(
        // Set the text direction for the app
        textDirection: TextDirection.rtl, // or TextDirection.rtl
        // textDirection: TextDirection.ltr, // or TextDirection.rtl
        child: Scaffold( appBar: MyAppBar(showBackButton: false),
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
              // height: 120,
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
  //           SizedBox(
  //               height: 200,
  //               child:  DynamicItemListGrid(
                  
  //   itemCount:9999,
  //   dynamicItemsFuture: fetchDynamicItems(), // Replace with your data fetching method
  //   navigator: Navigator.of(context),
  // ),),
            // Row 4


  Padding(
  padding: EdgeInsets.symmetric(vertical: 50.0), // Adjust the vertical padding as needed
  child: DynamicItemListGrid(
     itemCount:9999,
    dynamicItemsFuture: fetchDynamicItems(),
    navigator: Navigator.of(context),
  ),
)
          ],
        ),
      ),

               bottomNavigationBar: MyBottomNavigationBar(initialIndex: 1), // Add the bottom navigation bar here

        
         drawer: const CustomDrawer(),
    ),
    );
  }
}
