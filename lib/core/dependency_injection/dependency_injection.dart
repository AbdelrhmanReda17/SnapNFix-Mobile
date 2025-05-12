import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/dio_factory.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import './dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
  
  await getIt<SharedPreferencesService>().init();
  await getIt<ApplicationConfigurations>().init();
  DioFactory.setVerificationTokenHeader(
    getIt<ApplicationConfigurations>().currentSession?.tokens.accessToken,
  );
  
  return getIt.allReady();
}
