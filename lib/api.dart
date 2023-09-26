import 'dart:convert';
import 'package:absherv2/screens/auth/auth_provider.dart';
import 'package:absherv2/screens/imports.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
       print('$token');
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
static Future<void> updateProfile(BuildContext context, Map<String, dynamic> data) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final String? token = authProvider.token;

  if (token != null) {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/Clients'),
        headers: <String, String>{
          'accept': 'text/plain',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Extract the new token from the response
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String newToken = responseBody['token'];
        
        // Update the token in the AuthProvider
        authProvider.updateToken(newToken);

        // Now, let's decode and set the new token's data
        authProvider.decodeAndSetToken(newToken);

        print('Profile updated successfully.');

        // Show a success alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your profile has been updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('$token');
        print('Error during profile update. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Profile update failed.');
      }
    } catch (e) {
      print('Error during profile update: $e');
      throw e;
    }
  } else {
    throw Exception('Token is null. User is not authenticated.');
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