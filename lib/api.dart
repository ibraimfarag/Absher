import 'dart:convert';
import 'package:Abshr/screens/auth/auth_provider.dart';
import 'package:Abshr/screens/imports.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // Cache user token
  static Future<void> cacheUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  // Retrieve cached user token
  static Future<String?> getCachedUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
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
      await cacheUserToken(token);
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

if (response.statusCode == 200) {    
  final Map<String, dynamic> responseBody = json.decode(response.body);
    final String token = responseBody['token'];
    await cacheUserToken(token);
}else{
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
      title: Text(
        'عملية ناجحه',
        textAlign: TextAlign.right,
      ),
      content: Text(
        'تم تحديث البيانات بنجاح.',
        textAlign: TextAlign.right,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('موافق'),
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


static Future<void> updatePassword(String token, String newPassword, String confirmPassword) async {
  final Map<String, dynamic> requestData = {
    'password': newPassword,
    'confirmPassword': confirmPassword,
  };

  final response = await http.patch(
    Uri.parse('$baseUrl/Clients/ChangePassword'),
    headers: <String, String>{
      'accept': 'text/plain',
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    // Password updated successfully
  } else {
    // Handle error cases
  }
}

static Future<void> postRequestWithImages(String token, Map<String, dynamic> requestData, List<Asset> selectedImages) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrl/Requests'),
  );

  // Set headers including the authorization header
  request.headers['accept'] = 'text/plain';
  request.headers['Authorization'] = 'bearer $token';

  // Add fields to the request
  requestData.forEach((key, value) {
    request.fields[key] = value.toString();
  });

  // Add images to the request
  for (int i = 0; i < selectedImages.length; i++) {
    final byteData = await selectedImages[i].getByteData();
    final buffer = byteData.buffer.asUint8List();

    final multipartFile = http.MultipartFile.fromBytes(
      'files',
      buffer,
      filename: 'image$i.jpg',
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(multipartFile);
  }

  try {
    final response = await request.send();

    if (response.statusCode != 200) {
      final responseBody = await response.stream.bytesToString();
      print('Error response code: ${response.statusCode}');
      print('Error response body: $responseBody');
      throw Exception('Failed to post data to the API');
    }
  } catch (e) {
    // Handle errors here
    print('Error posting request with images: $e');
    // Show an error message to the user or handle the error appropriately
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

  static Future<void> sendVerificationCode(String email) async {
    final Map<String, dynamic> requestData = {
      'email': email,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/Clients/SendCode'),
      headers: <String, String>{
        'accept': 'text/plain',
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

static Future<String?> resetPassword(String email, String code, String password, String confirmPassword) async {
  final url = Uri.parse('$baseUrl/Clients/resetPassword');
  final requestBody = {
    'email': email,
    'code': code,
    'password': password,
    'confirmPassword': confirmPassword,
  };

  print('Request Body: ${jsonEncode(requestBody)}');

  final response = await http.patch(
    url,
    headers: {
      'accept': 'text/plain',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    final String token = responseBody['token'];
        await cacheUserToken(token);
    print('Token: $token');
    return token;
  } else {
    throw Exception('Failed to reset password');
  }
}

static Future<List<Map<String, dynamic>>> getOwnRequests(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/Requests/own'),
    headers: <String, String>{
      'accept': 'text/plain',
      'Authorization': 'bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);

    // Transform the response data to match the desired structure
    final List<Map<String, dynamic>> ownRequests = responseData.map((request) {
      return {
        'id': request['id'],
        'otherPhone': request['otherPhone'],
        'servingId': request['servingId'],
        'servingName': request['servingName'],
        'clientId': request['clientId'],
        'client': {
          'id': request['client']['id'],
          'name': request['client']['name'],
          'phone': request['client']['phone'],
          'email': request['client']['email'],
        },
        'city': request['city'],
        'district': request['district'],
        'locationDescription': request['locationDescription'],
        'locationLink': request['locationLink'],
        'comments': request['comments'],
        'date': request['date'],
        'requestFiles': request['requestFiles'],
      };
    }).toList();

    return ownRequests;
  } else {
    throw Exception('Failed to load own requests from the API');
  }
}

static Future<void> deactivateAccount(BuildContext context) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final String? token = authProvider.token;

  if (token != null) {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/Clients/own/deactivate'),
        headers: <String, String>{
          'accept': 'text/plain',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Account deactivated successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'تم تعطيل الحساب',
                textAlign: TextAlign.right,
              ),
              content: Text(
                'تم تعطيل الحساب بنجاح.',
                textAlign: TextAlign.right,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the success dialog
                    // You may want to navigate the user to the login screen or take other actions
                  },
                  child: Text('موافق'),
                ),
              ],
            );
          },
        );
      } else {
        print('Error during account deactivation. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Account deactivation failed.');
      }
    } catch (e) {
      print('Error during account deactivation: $e');
      throw e;
    }
  } else {
    throw Exception('Token is null. User is not authenticated.');
  }
}
static Future<void> deleteAccount(BuildContext context) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final String? token = authProvider.token;

  if (token != null) {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/Clients/own/delete'),
        headers: <String, String>{
          'accept': 'text/plain',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
 if (response.statusCode == 200) {
        // Account deactivated successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'تم حذف الحساب',
                textAlign: TextAlign.right,
              ),
              content: Text(
                'تم حذف الحساب بنجاح.',
                textAlign: TextAlign.right,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the success dialog
                    // You may want to navigate the user to the login screen or take other actions
                  },
                  child: Text('موافق'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle error cases
        print('Error during account deletion. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Account deletion failed.');
      }
    } catch (e) {
      print('Error during account deletion: $e');
      throw e;
    }
  } else {
    throw Exception('Token is null. User is not authenticated.');
  }
}

}
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() {
    return message;
  }
}
class ApiResponse {
  final int statusCode;
  final String message;

  ApiResponse({required this.statusCode, required this.message});
}