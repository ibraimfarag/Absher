import 'package:absherv2/screens/imports.dart';

class ImageSlider extends StatelessWidget {
  final List<String>
      assetImagePaths; // List of asset image paths for the slider

  const ImageSlider({super.key, required this.assetImagePaths});

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
                height: 150, // Adjust the height of the slider
                child: CarouselSlider(
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
                  items: [
                    'assets/banner1.png',
                    'assets/banner2.png',
                    'assets/banner3.png',
                  ]
                      .map((imageUrl) => Container(
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.fromLTRB(100, 0, 10, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
