// ignore_for_file: avoid_unnecessary_containers

import 'package:absherv2/screens/imports.dart';



class DynamicItem {
  final String imagePath;
  final String text;

  DynamicItem({
    required this.imagePath,
    required this.text,
  });
}


class DynamicItemListGrid extends StatelessWidget {
  final int itemCount; // Add a parameter to accept the itemCount
  final Future<List<DynamicItem>> dynamicItemsFuture; // Add this parameter


  const DynamicItemListGrid({
    Key? key,
    required this.itemCount,
    required this.dynamicItemsFuture, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DynamicItem>>(
      future: dynamicItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final dynamicItems = snapshot.data!;
          if (dynamicItems.isEmpty) {
            return const Text('No items available.');
          } else {
            return Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: dynamicItems.length,
                itemBuilder: (context, index) {
                  final dynamicItem = dynamicItems[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: 60,
                          width: 60,
                          color: AppVariables.themeColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                          child: Image.network(
  dynamicItem.imagePath, // Replace with the URL of the image
  width: 10,
  fit: BoxFit.cover,
),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dynamicItem.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppVariables.themeColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}
Future<List<DynamicItem>> fetchDynamicItems() async {
  try {
    // Make an API call to fetch data from the specified endpoint
    final List<dynamic> responseData = await API.fetchData('Servings');

    // Convert the response data list into a list of DynamicItem objects
    final List<DynamicItem> dynamicItems = responseData.map((data) {
      final Map<String, dynamic> itemData = data as Map<String, dynamic>;
      return DynamicItem(
        imagePath: itemData['iconUrl'] as String,
        text: itemData['name'] as String,
      );
    }).toList();

    return dynamicItems;
  } catch (e) {
    // Handle any errors that occurred during the API call
    throw Exception('Failed to fetch dynamic items: $e');
  }
}
