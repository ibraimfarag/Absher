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

static Future<String> login(String phone, String password) async {
  final Map<String, String> requestData = {
    'phone': phone,
    'password': password,
  };

  final response = await http.post(
    Uri.parse('$baseUrl/Clients/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    final String token = responseBody['token'];
    return token;
  } else {
final Map<String, dynamic> responseBody = json.decode(response.body);
  final String error = responseBody['message'];
  throw ApiException(error); // Throw your custom ApiException
  }
}


static Future<void> registerUser(String name, String phone, String email, String password) async {
  final Map<String, dynamic> requestData = {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
  };

  final response = await http.post(
    Uri.parse('$baseUrl/Clients/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode != 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    final String error = responseBody['message'];
    throw ApiException(error); // Throw your custom ApiException
  }
}
// API function to verify the account
static Future<String?> verifyAccount(String phoneNumber, String code) async {
  final Map<String, dynamic> requestData = {
    'phone': phoneNumber,
    'code': code,
  };

  final response = await http.post(
    Uri.parse('$baseUrl/Clients/active'),
    headers: <String, String>{
      'accept': 'text/plain',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    final String token = responseBody['token'];
    return token;
  } else {
    // Verification unsuccessful
     final Map<String, dynamic> responseBody = json.decode(response.body);
     final String error = responseBody['message'];
    throw ApiException(error); // Throw your custom ApiException
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
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return message;
  }
}