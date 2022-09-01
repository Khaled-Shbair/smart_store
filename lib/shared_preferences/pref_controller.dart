import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

enum PrefKeys { id, token, image, password, phone, login, name, city, language }

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
    await _sharedPreferences.setString(PrefKeys.city.toString(), user.cityId);
    await _sharedPreferences.setString(
        PrefKeys.image.toString(), user.store!.image.toString());
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ${user.token}');
  }

  Future<bool> changeLanguage({required String language}) async {
    return await _sharedPreferences.setString(
        PrefKeys.language.toString(), language);
  }

  String get language =>
      _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';

  bool get login =>
      _sharedPreferences.getBool(PrefKeys.login.toString()) ?? false;

  //set login(bool login) =>
  //    _sharedPreferences.setBool(PrefKeys.login.toString(), login);

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  //set token(String token) =>
  //    _sharedPreferences.setString(PrefKeys.token.toString(), token);

  String get phone =>
      _sharedPreferences.getString(PrefKeys.phone.toString()) ?? '';

  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';

  set name(String name) =>
      _sharedPreferences.setString(PrefKeys.name.toString(), name);

  String get mobile =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';

  set mobile(String mobile) =>
      _sharedPreferences.setString(PrefKeys.phone.toString(), mobile);

  String get image =>
      _sharedPreferences.getString(PrefKeys.image.toString()) ?? '';

  set cityId(String cityId) =>
      _sharedPreferences.setString(PrefKeys.city.toString(), cityId);

  String get cityId =>
      _sharedPreferences.getString(PrefKeys.city.toString()) ?? '';

  Future<bool> remove({required dynamic key}) async {
    if (_sharedPreferences.containsKey(key)) {
      return await _sharedPreferences.remove(key);
    }
    return false;
  }

//Future<bool> clear() async => await _sharedPreferences.clear();
}
