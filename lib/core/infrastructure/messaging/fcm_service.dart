import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapnfix/presentation/navigation/navigation_service.dart';
import 'dart:convert';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  String? _cachedToken;
  static const String _fcmTokenKey = 'fcm_token';

  /// Initialize FCM and local notifications
  Future<Result<String?, ApiError>> initialize() async {
    try {
      // Initialize local notifications
      await _initializeLocalNotifications();

      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Get and cache the token
        final tokenResult = await _getAndCacheToken();

        // Configure message handlers
        configureForegroundMessages();
        configureBackgroundMessages();
        _configureNotificationTaps();

        // Listen for token refresh
        _listenForTokenRefresh();

        return tokenResult;
      } else {
        debugPrint('User declined or has not accepted permission');
        return Result.failure(
          ApiError(message: 'Permission denied for notifications'),
        );
      }
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
      return Result.failure(
        ApiError(message: 'Failed to initialize FCM: ${e.toString()}'),
      );
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    debugPrint(
      'Notification tapped: ${response.notificationResponseType} ${response.id} ${response.notificationResponseType.name} ${response.toString()}  ${response.notificationResponseType.index} ${response.data} ${response.data}',
    );
    _handleNotificationNavigation(response.payload);
  }

  /// Configure foreground message handling with local notification display
  void configureForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      debugPrint(
        'Message notification:${message.notification?.toString()} ${message.notification?.body}  ${message.notification?.title}  ${message.notification?.bodyLocArgs}',
      );
      if (message.notification != null) {
        debugPrint(
          'Message notification:${message.notification?.toString()} ${message.notification?.body}  ${message.notification?.title}  ${message.notification?.bodyLocArgs}',
        );
        await _showLocalNotification(message);
      }
    });
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'snapnfix_channel',
          'SnapNFix Notifications',
          channelDescription: 'SnapNFix app notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'SnapNFix',
      message.notification?.body ?? 'You have a new notification',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  void _configureNotificationTaps() {
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        debugPrint(
          'App opened from terminated state by notification: ${message.messageId}',
        );
        _handleNotificationNavigation(message.data.toString());
      }
    });

    // Handle notification opened from background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        'App opened from background by notification: ${message.messageId}',
      );
      _handleNotificationNavigation(message.data.toString());
    });
  }

  /// Handle navigation based on notification data
  void _handleNotificationNavigation(String? payload) {
    getIt<NavigationService>().handleNotificationNavigation({});

    if (payload != null && payload != '{}' && payload.isNotEmpty) {
      debugPrint('Handling notification navigation with payload: $payload');
      try {
        final Map<String, dynamic> data = Map<String, dynamic>.from(
          jsonDecode(payload),
        );
        getIt<NavigationService>().handleNotificationNavigation(data);
      } catch (e) {
        debugPrint('Failed to parse notification payload: $e');
      }
    } else {
      debugPrint('No payload to handle for notification navigation.');
    }
  }

  /// Get the current device FCM token
  Future<Result<String?, ApiError>> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      return Result.success(token);
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return Result.failure(
        ApiError(message: 'Failed to get FCM token: ${e.toString()}'),
      );
    }
  }

  Future<String?> getCachedToken() async {
    if (_cachedToken != null) {
      return _cachedToken;
    }

    // Try to get from shared preferences
    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString(_fcmTokenKey);

    if (_cachedToken != null) {
      return _cachedToken;
    }

    // If not cached, get fresh token
    final result = await _getAndCacheToken();

    result.when(
      success: (token) {
        _cachedToken = token;
        debugPrint('Cached FCM Token: $token');
        return token;
      },
      failure: (error) {
        debugPrint('Error getting cached token: ${error.message}');
      },
    );
    return _cachedToken;
  }

  /// Get fresh token from Firebase and cache it
  Future<Result<String?, ApiError>> _getAndCacheToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $token');

      // Cache the token
      _cachedToken = token;
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_fcmTokenKey, token);
      }

      return Result.success(token);
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return Result.failure(
        ApiError(message: 'Failed to get FCM token: ${e.toString()}'),
      );
    }
  }

  /// Listen for token refresh and update cache
  void _listenForTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      debugPrint('FCM Token refreshed: $token');
      _cachedToken = token;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(_fcmTokenKey, token);
      });
    });
  }

  /// Configure background message handling
  void configureBackgroundMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Clear cached token
  Future<void> clearToken() async {
    _cachedToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
    await _firebaseMessaging.deleteToken();
  }
}

/// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  await getIt.allReady();
  final fcmService = getIt<FCMService>();
  fcmService._handleNotificationNavigation(message.data.toString());
}
