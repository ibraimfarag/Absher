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
  final int itemsPerRow; // Add this parameter to control items per row

  DynamicItemListGrid({
    Key? key,
    required this.itemCount,
    required this.dynamicItemsFuture, // Add this parameter
    required this.navigator, // Add this parameter
    this.itemsPerRow = 4, // Default to 3 items per row
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<DynamicItem>>(
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
              // Use min function to limit the number of items displayed
              final limitedItems = dynamicItems.take(itemCount).toList();
              return LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      (constraints.maxWidth - ((itemsPerRow - 1) * 30.0)) /
                          itemsPerRow;
                  return Wrap(
                    spacing: 20.0, // horizontal spacing between items
                    runSpacing: 8.0, // vertical spacing between rows
                    children: limitedItems.map((dynamicItem) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailsScreen(
                                id: dynamicItem.id,
                                subId: dynamicItem.subId,
                                name: dynamicItem.name,
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
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                height: itemWidth,
                                width: itemWidth,
                                color: AppVariables.themeColor,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    dynamicItem.imagePath,
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
                                fontSize: 14,
                                color: AppVariables.themeColor,
                                fontFamily: AppVariables.serviceFontFamily,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            }
          } else {
            return Text('No data available.');
          }
        },
      ),
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

class ServiceDetailsArguments {
  final int id;
  final int subId;
  final String name;
  final String imagePath;
  final String coverPath;
  final String bio;
  final String cost;
  final String costNotes;
  final String text;

  ServiceDetailsArguments({
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