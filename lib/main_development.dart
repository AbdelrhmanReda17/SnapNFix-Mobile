import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/helpers/constants.dart';
import 'package:snapnfix/core/helpers/extensions.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/routing/app_router.dart';
import 'package:snapnfix/snapnfix_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  runApp(SnapNFixApplication(appRouter: AppRouter()));
}
checkIfLoggedInUser ()async{
  String? userToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if(!userToken.isNullOrEmpty()){
    isLoggedInUser = true;
  }
  else{
    isLoggedInUser = false;
  }
}