import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

enum PrefKeys {
  language,
  mode,
  token,
  image,
  phone,
  login,
  name,
  cityAr,
  cityEn,
  gender,
  cityId,
}

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
    await _sharedPreferences.setString(PrefKeys.gender.toString(), user.gender);
    await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
    await _sharedPreferences.setString(PrefKeys.cityId.toString(), user.cityId);
    await _sharedPreferences.setString(
        PrefKeys.cityEn.toString(), user.city!.nameEn.toString());
    await _sharedPreferences.setString(
        PrefKeys.cityAr.toString(), user.city!.nameAr.toString());
    await _sharedPreferences.setString(
        PrefKeys.image.toString(), user.store!.image.toString());
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ${user.token}');
  }

  Future<void> saveDarkThemeMode(bool isDarkTheme) async {
    await _sharedPreferences.setBool(PrefKeys.mode.toString(), isDarkTheme);
  }

  Future<bool> changeLanguage({required String language}) async {
    return await _sharedPreferences.setString(
        PrefKeys.language.toString(), language);
  }

  set login(bool login) =>
      _sharedPreferences.setBool(PrefKeys.login.toString(), login);

  set token(String token) =>
      _sharedPreferences.setString(PrefKeys.token.toString(), token);

  set phone(String phone) =>
      _sharedPreferences.setString(PrefKeys.phone.toString(), phone);

  set image(String image) =>
      _sharedPreferences.setString(PrefKeys.image.toString(), image);

  set name(String name) =>
      _sharedPreferences.setString(PrefKeys.name.toString(), name);

  set gender(String gender) =>
      _sharedPreferences.setString(PrefKeys.gender.toString(), gender);

  set cityEn(String cityEn) =>
      _sharedPreferences.setString(PrefKeys.cityEn.toString(), cityEn);

  set cityAr(String cityAr) =>
      _sharedPreferences.setString(PrefKeys.cityEn.toString(), cityAr);

  set cityId(String cityId) =>
      _sharedPreferences.setString(PrefKeys.cityId.toString(), cityId);

  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';

  String get gender =>
      _sharedPreferences.getString(PrefKeys.gender.toString()) ?? '';

  String get phone =>
      _sharedPreferences.getString(PrefKeys.phone.toString()) ?? '';

  String get image =>
      _sharedPreferences.getString(PrefKeys.image.toString()) ?? '';

  String get cityEn =>
      _sharedPreferences.getString(PrefKeys.cityEn.toString()) ?? '';

  String get cityAr =>
      _sharedPreferences.getString(PrefKeys.cityAr.toString()) ?? '';

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  String get language =>
      _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';

  String get cityId =>
      _sharedPreferences.getString(PrefKeys.cityId.toString()) ?? '1';

  bool get login =>
      _sharedPreferences.getBool(PrefKeys.login.toString()) ?? false;

  bool get mode =>
      _sharedPreferences.getBool(PrefKeys.mode.toString()) ?? false;
}
