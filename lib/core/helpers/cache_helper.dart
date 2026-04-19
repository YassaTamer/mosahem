import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _tokenKey = 'access_token';
  static const String _roleKey = 'role';
  static const String _organizationIdKey = 'organization_id';
  static const String _accessTokenExpirationKey = 'access_token_expiration';
  static const String _refreshTokenKey = 'refresh_token';

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> clearRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refreshTokenKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveAccessTokenExpiration(String expiration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenExpirationKey, expiration);
  }

  static Future<String?> getAccessTokenExpiration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenExpirationKey);
  }

  static Future<void> clearAccessTokenExpiration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenExpirationKey);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  static Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
  }

  static Future<void> saveOrganizationId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_organizationIdKey, id);
  }

  static Future<String?> getOrganizationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_organizationIdKey);
  }

  static Future<void> clearOrganizationId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_organizationIdKey);
  }

  static Future<void> saveLoginSession({
    required String token,
    required String refreshToken,
    required String role,
    required String accessTokenExpiration,
    String? organizationId,
  }) async {
    await saveToken(token);
    await saveRefreshToken(refreshToken);
    await saveRole(role);
    await saveAccessTokenExpiration(accessTokenExpiration);
    if (organizationId != null && organizationId.isNotEmpty) {
      await saveOrganizationId(organizationId);
    }
  }

  static Future<bool> isTokenExpired() async {
    final expiration = await getAccessTokenExpiration();
    if (expiration == null || expiration.isEmpty) {
      return false;
    }

    final expirationDate = DateTime.tryParse(expiration);
    if (expirationDate == null) {
      return true;
    }

    return DateTime.now().toUtc().isAfter(expirationDate.toUtc());
  }

  static Future<bool> hasValidSession() async {
    final token = await getToken();
    final role = await getRole();

    if (token == null || token.isEmpty || role == null || role.isEmpty) {
      return false;
    }

    return !(await isTokenExpired());
  }

  static Future<void> clearSession() async {
    await clearToken();
    await clearRefreshToken();
    await clearRole();
    await clearOrganizationId();
    await clearAccessTokenExpiration();
  }
}
