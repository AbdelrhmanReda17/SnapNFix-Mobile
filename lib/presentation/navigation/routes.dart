class Routes {
  // Auth Routes
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String completeProfile = '/complete-profile';

  // Main App Routes
  static const String home = '/home';
  static const String map = '/map';
  static const String userReports = '/user-reports';
  static const String userIssues = '/user-issues/:issueId';
  static const String settings = '/settings';
  static const String submitReport = '/submit-report';
  static const String areaIssuesChat = '/area-issues-chat';
  // static const String userIssues = '/user-issues/';
  static const String issueDetails = '/issue-details/:issueId';

  // Settings Routes
  static const String changePassword = '/settings/change-password';
  static const String editProfile = '/settings/edit-profile';
  static const String support = '/settings/support';
  static const String termsAndConditions = '/settings/terms-and-conditions';
  static const String privacyPolicy = '/settings/privacy-policy';
  static const String about = '/settings/about';
 
}
