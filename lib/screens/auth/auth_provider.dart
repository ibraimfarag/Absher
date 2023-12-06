import 'dart:convert';

import 'package:absherv2/screens/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _id; // Add id, email, and phone fields
  String? _name;
  String? _email;
  String? _mobile;

  String? get token => _token;
  String? get id => _id; // Add getters for id, email, and phone
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;

  bool get isAuthenticated => _token != null;


  void login(String token, String id, String name, String email, String mobile) {
    _token = token;
    _id = id; // Store id, email, and phone
    _name = name;
    _email = email;
    _mobile = mobile;
    notifyListeners();
  }


 Future<String?> getCachedToken() async {
    return await API.getCachedUserToken();
  }
// Constructor to initialize AuthProvider
  AuthProvider() {
    loadCachedToken();
  }

  // Load cached token when the AuthProvider initializes
  Future<void> loadCachedToken() async {
    final String? cachedToken = await API.getCachedUserToken();
    if (cachedToken != null) {
      decodeAndSetToken(cachedToken);
    }
  }
void decodeAndSetToken(String token) {
  List<String> tokenParts = token.split('.');
  if (tokenParts.length == 3) {
    String payload = tokenParts[1];

    // Ensure the payload is properly padded
    while (payload.length % 4 != 0) {
      payload += '=';
    }

    Map<String, dynamic> decodedToken = json.decode(
      utf8.decode(
        base64Url.decode(payload),
      ),
    );

    String mobile = decodedToken['phone'];
    String name = decodedToken['name'];
    String id = decodedToken['id'];
    String email = decodedToken['email'];

    // Now, set these values in your AuthProvider
    _mobile = mobile;
    _name = name;
    _id = id;
    _email = email;
    _token = token;  // Set the token

    // Notify listeners and update authentication status
    notifyListeners();
  }
}
  // Clear cached token when logging out
  void clearCachedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
  }
 void logout() {
    _token = null;
    _id = null;
    _name = null;
    _email = null;
    _mobile = null;
        clearCachedToken();

    notifyListeners();
  }

  void updateToken(String newToken) {
  _token = newToken;
  notifyListeners();
}

}

