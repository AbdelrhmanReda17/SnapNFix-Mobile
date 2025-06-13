class ApiEndpoints {
  static const String baseUrl =
      "https://snapnfix-gcdhftfvccduhahv.uaenorth-01.azurewebsites.net/";

  // Authentication endpoints
  static const String login = "api/auth/login";
  static const String register = "api/auth/register";
  static const String logout = "api/auth/logout";
  static const String editProfile = "/api/Citizen/profile";
  static const String refreshToken = "api/auth/refresh-token";

  // OTP endpoints
  static const String requestOtp = "api/auth/verify-phone/request-otp";
  static const String verifyOtp = "api/auth/verify-phone/verify-otp";
  static const String resendOtp = "api/auth/verify-phone/resend-otp";

  // Password reset endpoints
  static const String forgotPassword = "api/auth/forget-password/request-otp";
  static const String verifyForgotPasswordOtp =
      "api/auth/forget-password/verify-otp";
  static const String resendForgotPasswordOtp =
      "api/auth/forget-password/resend-otp";
  static const String resetPassword = "api/auth/forget-password/reset";

  // Social login endpoints
  static const String googleLogin = "api/auth/google/login";
  static const String facebookLogin = "api/auth/facebook/login";

  // Reports endpoints
  static const String createSnapReport = "api/SnapReports/create";
  static const String userReports = "api/SnapReports/my-reports";
  static const String createFastReport = "api/FastReports/create";

  // Issues endpoints
  static const String getNearbyIssues = "api/issue/get-nearby-issues";
  static const String getIssueById = "api/issue/{id}";
  static const String getUserIssues = "api/issue/get-user-issues";
}

/// Network configuration constants
class NetworkConfig {
  static const Duration connectionTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 60);

  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 1);
}
