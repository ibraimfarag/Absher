import 'package:Absher/screens/imports.dart';

class ImageSlider extends StatelessWidget {
  final List<String> assetImagePaths; // Add this line to accept assetImagePaths

  const ImageSlider({Key? key, required this.assetImagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              height: 200,
            ),
            Expanded(
              child: SizedBox(
                height: 150,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: API.fetchPlanners(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No planners available');
                    } else {
                      final planners = snapshot.data!;
                      return CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          autoPlayInterval: const Duration(seconds: 30),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.9,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        ),
                        items: planners
                            .map((planner) => Container(
                                  margin: const EdgeInsets.all(3.0),
                                  padding: const EdgeInsets.fromLTRB(100, 0, 10, 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage(planner['fileUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
