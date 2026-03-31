import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/network/network_request_flags.dart';
import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
import 'package:mosahem/features/auth/data/models/login_response_model.dart';

class DioHelper {
  DioHelper._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {'Accept': 'application/json'},
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      ) {
    _authApiService = AuthApiService(_dio);
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(onRequest: _onRequest, onError: _onError),
    );
  }
  static const String _baseUrl = 'https://mosahemapi.runasp.net';
  static final DioHelper instance = DioHelper._internal();

  final Dio _dio;
  late final AuthApiService _authApiService;

  Future<LoginResponseModel?>? _refreshFuture;

  Dio get client => _dio;

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[kSkipAuth] == true) {
      options.headers.remove('Authorization');
      handler.next(options);
      return;
    }

    final token = await CacheHelper.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.remove('Authorization');
    }

    handler.next(options);
  }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = error.requestOptions;
    final isUnauthorized = error.response?.statusCode == 401;
    final shouldSkipRefresh = requestOptions.extra[kSkipRefresh] == true;
    final alreadyRetried = requestOptions.extra[kRetryRequest] == true;

    if (!isUnauthorized || shouldSkipRefresh || alreadyRetried) {
      handler.next(error);
      return;
    }

    final refreshedSession = await refreshSession();
    final newAccessToken = refreshedSession?.data.accessToken;

    if (newAccessToken == null || newAccessToken.isEmpty) {
      handler.next(error);
      return;
    }

    final retryHeaders = Map<String, dynamic>.from(requestOptions.headers);
    retryHeaders['Authorization'] = 'Bearer $newAccessToken';

    final retryExtra = Map<String, dynamic>.from(requestOptions.extra);
    retryExtra[kRetryRequest] = true;
    // print("🔥 ERROR 401 DETECTED");
    // print("skipRefresh: ${requestOptions.extra[kSkipRefresh]}");
   // print("alreadyRetried: ${requestOptions.extra[kRetryRequest]}");
    try {
      final response = await _dio.fetch(
        requestOptions.copyWith(headers: retryHeaders, extra: retryExtra),
      );
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    } catch (retryError) {
      handler.next(
        DioException(
          requestOptions: requestOptions,
          error: retryError,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  Future<bool> ensureValidSession() async {
    final token = await CacheHelper.getToken();
    final role = await CacheHelper.getRole();

    if (token == null || token.isEmpty || role == null || role.isEmpty) {
      return false;
    }

    final isExpired = await CacheHelper.isTokenExpired();
    if (!isExpired) {
      return true;
    }

    return (await refreshSession()) != null;
  }

  Future<LoginResponseModel?> refreshSession() async {
    final activeRefresh = _refreshFuture;
    if (activeRefresh != null) {
      return activeRefresh;
    }

    final refreshOperation = _performRefresh();
    _refreshFuture = refreshOperation;

    try {
      return await refreshOperation;
    } finally {
      if (identical(_refreshFuture, refreshOperation)) {
        _refreshFuture = null;
      }
    }
  }

  Future<LoginResponseModel?> _performRefresh() async {
    final accessToken = await CacheHelper.getToken();
    final refreshToken = await CacheHelper.getRefreshToken();
    final cachedRole = await CacheHelper.getRole();
    final cachedOrganizationId = await CacheHelper.getOrganizationId();

    if (accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty ||
        cachedRole == null ||
        cachedRole.isEmpty) {
      await CacheHelper.clearSession();
      return null;
    }
  //  print("🔁 REFRESH START");
   // print("AccessToken: $accessToken");
   // print("RefreshToken: $refreshToken");
    try {
      final response = await _authApiService.refreshToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      await CacheHelper.saveLoginSession(
        token: response.data.accessToken,
        refreshToken: response.data.refreshToken,
        role: response.data.role.isNotEmpty ? response.data.role : cachedRole,
        accessTokenExpiration: response.data.accessTokenExpiration,
        organizationId: response.data.id.isNotEmpty
            ? response.data.id
            : cachedOrganizationId,
      );
     // print("✅ REFRESH SUCCESS");
      return response;
    } catch (_) {
      await CacheHelper.clearSession();
    //  print("❌ REFRESH FAILED");
      return null;
    }
  }
}
