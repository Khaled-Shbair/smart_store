import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

enum PrefKeys { id, token, password, phone, login, name }

class PrefController {
  static final PrefController _prefController = PrefController._();
  late SharedPreferences _sharedPreferences;

  PrefController._();

  factory PrefController() => _prefController;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async {
    await _sharedPreferences.setBool(PrefKeys.login.toString(), true);
    await _sharedPreferences.setString(PrefKeys.phone.toString(), user.mobile);
    await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ${user.token}');
  }

  bool get login =>
      _sharedPreferences.getBool(PrefKeys.login.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';
}
