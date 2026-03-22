import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _tokenKey = 'access_token';
  static const String _roleKey = 'role';
  static const String _organizationIdKey = 'organization_id';

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

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
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
}
