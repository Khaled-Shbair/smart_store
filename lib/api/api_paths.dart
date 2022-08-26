class ApiPath {
  static const String _baseUrl = 'https://smart-store.mr-dev.tech/api/';
  static const String login = '${_baseUrl}auth/login';
  static const String logout = '${_baseUrl}auth/logout';
  static const String activate = '${_baseUrl}auth/activate';
  static const String register = '${_baseUrl}auth/register';
  static const String refreshFcmToken = '${_baseUrl}auth/refresh-fcm-token';
  static const String updateProfile = '${_baseUrl}auth/update-profile';
  static const String changePassword = '${_baseUrl}auth/change-password';
  static const String forgetPassword = '${_baseUrl}auth/forget-password';
  static const String resetPassword = '${_baseUrl}auth/reset-password';
  static const String cities = '${_baseUrl}cities';
  static const String home = '${_baseUrl}home';
  static const String categories = '${_baseUrl}categories';
  static const String subCategories = '${_baseUrl}sub-categories/';
  static const String products = '${_baseUrl}products/';
  static const String favoriteProducts = '${_baseUrl}favorite-products';
}
