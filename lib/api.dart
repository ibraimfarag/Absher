import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  // Define the base URL of your API
  static const String baseUrl = 'http://magamy-006-site4.ctempurl.com/api/';




  // Example method to fetch data from the API
static Future<List<Map<String, dynamic>>> fetchData(String endpoint) async {
  final response = await http.get(Uri.parse('$baseUrl$endpoint'));

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(json.decode(response.body));
    return data;
  } else {
    throw Exception('Failed to load data from the API');
  }
}
  // Example method to post data to the API
  static Future<void> postData(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post data to the API');
    }
  }

  // Add more API methods as needed
}
