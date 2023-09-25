import 'package:absherv2/screens/imports.dart';

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

  void logout() {
    _token = null;
    _id = null;
    _name = null;
    _email = null;
    _mobile = null;
    notifyListeners();
  }
}

