import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/snapnfix_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.clearAllSecuredData();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await getIt<ApplicationConfigurations>().init();
  runApp(SnapNFixApplication());
}
