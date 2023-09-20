import 'package:absherv2/screens/imports.dart';


class AuthProvider with ChangeNotifier {
  String? _token;
  String? _name;

  String? get token => _token;
  String? get name => _name;

  bool get isAuthenticated => _token != null;

  void login(String token, String name) {
    _token = token;
    _name = name;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _name = null;
    notifyListeners();
  }
}
