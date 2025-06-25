import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/firebase_options.dart';
import 'package:snapnfix/snapnfix_application.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => debugPrint('✅ Firebase initialized successfully'))
      .catchError(
        (error) => debugPrint('❌ Error initializing Firebase: $error'),
      );
  await configureDependencies();
  await ScreenUtil.ensureScreenSize();
  runApp(
    DevicePreview(enabled: true, builder: (context) => SnapNFixApplication()),
  );
}
