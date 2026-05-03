import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _userIdKey = 'user_id';
  static const String _tokenKey = 'access_token';
  static const String _roleKey = 'role';
  static const String _organizationIdKey = 'organization_id';
  static const String _accessTokenExpirationKey = 'access_token_expiration';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _appliedOpportunityIdsKey = 'applied_opportunity_ids';

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
    String? userId, // 👈 جديد
  }) async {
    await saveToken(token);
    await saveRefreshToken(refreshToken);
    await saveRole(role);
    await saveAccessTokenExpiration(accessTokenExpiration);

    if (organizationId != null && organizationId.isNotEmpty) {
      await saveOrganizationId(organizationId);
    }

    if (userId != null && userId.isNotEmpty) {
      await saveUserId(userId); // 👈 مهم جدًا
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
    await clearAppliedOpportunityIds();
  }

  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  static Future<String> _appliedOpportunityCacheKey() async {
    final userId = await getUserId();
    if (userId == null || userId.isEmpty) return _appliedOpportunityIdsKey;
    return '${_appliedOpportunityIdsKey}_$userId';
  }

  static Future<List<String>> getAppliedOpportunityIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(await _appliedOpportunityCacheKey()) ?? const [];
  }

  static Future<bool> isOpportunityApplied(String opportunityId) async {
    final ids = await getAppliedOpportunityIds();
    return ids.contains(opportunityId);
  }

  static Future<void> saveAppliedOpportunityId(String opportunityId) async {
    if (opportunityId.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final key = await _appliedOpportunityCacheKey();
    final ids = prefs.getStringList(key) ?? <String>[];

    if (!ids.contains(opportunityId)) {
      await prefs.setStringList(key, [...ids, opportunityId]);
    }
  }

  static Future<void> clearAppliedOpportunityIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(await _appliedOpportunityCacheKey());
  }
}
