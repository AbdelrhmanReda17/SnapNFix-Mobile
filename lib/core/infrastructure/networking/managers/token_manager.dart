import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/managers/base_token_manager.dart';
import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';

class TokenManager implements BaseTokenManager {
  final ApplicationConfigurations _appConfig;
  final ApiService _apiService;

  TokenManager({
    required ApplicationConfigurations appConfig,
    required ApiService apiService,
  }) : _appConfig = appConfig,
       _apiService = apiService;

  @override
  String? get accessToken => _appConfig.currentSession?.tokens.accessToken;

  @override
  String? get refreshToken => _appConfig.currentSession?.tokens.refreshToken;

  @override
  bool get isTokenExpired {
    final tokens = _appConfig.currentSession?.tokens;
    if (tokens == null) return true;
    final bufferTime = DateTime.now().add(const Duration(minutes: 5));
    return tokens.expiresAt.isBefore(bufferTime);
  }

  @override
  Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    DateTime expiresAt,
  ) async {
    try {
      final currentSession = _appConfig.currentSession;
      if (currentSession != null) {
        final newTokens = TokensModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );
        await _appConfig.updateSessionTokens(newTokens);
        debugPrint('Tokens saved successfully');
      } else {
        debugPrint('No current session to update tokens');
      }
    } catch (e) {
      debugPrint('Failed to save tokens: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await _appConfig.logout();
      debugPrint('Tokens cleared successfully');
    } catch (e) {
      debugPrint('Failed to clear tokens: $e');
      rethrow;
    }
  }

  @override
  Future<String?> refreshAccessToken() async {
    final currentRefreshToken = refreshToken;

    if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
      debugPrint('No refresh token available');
      throw Exception('No refresh token available');
    }

    try {
      debugPrint('Attempting to refresh token...');

      final response = await _apiService.refreshToken({
        'refreshToken': currentRefreshToken,
      });

      // Check if response has error
      if (response.hasError) {
        final errorMessage = response.error?.message ?? 'Token refresh failed';
        debugPrint('Token refresh API error: $errorMessage');
        throw Exception(errorMessage);
      }

      final newTokens = response.data;
      if (newTokens == null) {
        debugPrint('Token refresh returned null data');
        throw Exception('Invalid token response - no data received');
      }

      // Validate the new tokens
      if (newTokens.accessToken.isEmpty) {
        debugPrint('Token refresh returned empty access token');
        throw Exception('Invalid token response - empty access token');
      }

      // Save the new tokens
      await saveTokens(
        newTokens.accessToken,
        newTokens.refreshToken,
        newTokens.expiresAt,
      );

      debugPrint('Token refresh successful');
      return newTokens.accessToken;
    } on Exception catch (e) {
      debugPrint('Token refresh failed with exception: $e');
      rethrow;
    } catch (e) {
      debugPrint('Token refresh failed with error: $e');
      throw Exception('Token refresh failed: $e');
    }
  }

  // Helper method to check if we have valid tokens
  bool get hasValidTokens {
    final tokens = _appConfig.currentSession?.tokens;
    return tokens != null &&
        tokens.accessToken.isNotEmpty &&
        tokens.refreshToken.isNotEmpty;
  }

  // Helper method to get token expiration info
  Duration? get timeUntilExpiration {
    final tokens = _appConfig.currentSession?.tokens;
    if (tokens == null) return null;

    final now = DateTime.now();
    if (tokens.expiresAt.isBefore(now)) return Duration.zero;

    return tokens.expiresAt.difference(now);
  }
}
