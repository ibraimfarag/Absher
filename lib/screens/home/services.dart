import 'package:absherv2/screens/imports.dart';

class DynamicItem {
  final int id;
  final int subId;
  final String name;
  final String imagePath;
  final String coverPath;
  final String bio;
  final String cost;
  final String costNotes;
  final String text;

  DynamicItem({
    required this.id,
    required this.subId,
    required this.name,
    required this.imagePath,
    required this.coverPath,
    required this.bio,
    required this.cost,
    required this.costNotes,
    required this.text,
  });
}

class DynamicItemListGrid extends StatelessWidget {
  final int itemCount; // Add a parameter to accept the itemCount
  final Future<List<DynamicItem>> dynamicItemsFuture; // Add this parameter
  final NavigatorState navigator; // Add this parameter

  const DynamicItemListGrid({
    Key? key,
    required this.itemCount,
    required this.dynamicItemsFuture, // Add this parameter
    required this.navigator, // Add this parameter

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
            return Text('No items available.');
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
                  return GestureDetector(
                      onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceDetailsScreen(
          id: dynamicItem.id, // Pass the 'id' parameter
          subId: dynamicItem.subId, // Pass the 'subId' parameter
          name: dynamicItem.name, // Pass the 'name' parameter
          imagePath: dynamicItem.imagePath,
          coverPath: dynamicItem.coverPath,
          bio: dynamicItem.bio,
          cost: dynamicItem.cost,
          costNotes: dynamicItem.costNotes,
          text: dynamicItem.text,
        ),
      ),
    );
  },
                    child: Column(
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
                            fontSize: 10,
                            color: AppVariables.themeColor,
                            fontFamily: AppVariables.serviceFontFamily,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return Text('No data available.');
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
        id: itemData['id'] as int,
        subId: itemData['subId'] as int,
        name: itemData['name'] as String,
        imagePath: itemData['iconUrl'] as String,
        coverPath: itemData['coverUrl'] as String,
        bio: itemData['bio'] as String,
        cost: itemData['cost'] as String,
        costNotes: itemData['costNotes'] as String, // You can use the 'name' field as text
        text: itemData['name'] as String, // You can use the 'name' field as text
      );
    }).toList();

    return dynamicItems;
  } catch (e) {
    // Handle any errors that occurred during the API call
    throw Exception('Failed to fetch dynamic items: $e');
  }
}