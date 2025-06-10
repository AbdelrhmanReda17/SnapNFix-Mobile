class ApiConstants {
  static const String apiBaseUrl =
      "https://snapnfix-gcdhftfvccduhahv.uaenorth-01.azurewebsites.net/";
  static const String login = "api/auth/login";
  static const String completeProfile = "api/auth/register";
  static const String requestOTP = "api/auth/verify-phone/request-otp";
  static const String verifyOtp = "api/auth/verify-phone/verify-otp";
  static const String resendOtp = "api/auth/verify-phone/resend-otp";
  static const String forgotPassword = "api/auth/forget-password/request-otp";
  static const String verifyForgotPasswordOtp =
      "api/auth/forget-password/verify-otp";
  static const String verifyForgotPasswordOtpResend =
      "api/auth/forget-password/resend-otp";
  static const String resetPassword = "api/auth/forget-password/reset";
  static const String loginWithGoogle = "api/auth/google/login";
  static const String loginWithFacebook = "api/auth/facebook/login";
  static const String logout = "api/auth/logout";
  static const String changePassword = "api/auth/change-password";
  static const String editProfile = "api/auth/edit-profile";
  static const String createReport = "api/SnapReports/create";
  static const String userReports = "/api/SnapReports/my-reports";
  static const String refreshToken = "api/auth/refresh-token";
}
