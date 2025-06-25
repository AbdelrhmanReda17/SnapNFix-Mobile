abstract class BaseTokenManager {
  String? get accessToken;
  String? get refreshToken;
  bool get isTokenExpired;

  Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    DateTime expiresAt,
  );
  Future<void> clearTokens();
  Future<String?> refreshAccessToken();
}
