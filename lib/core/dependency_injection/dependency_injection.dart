// Complete dependency_injection.dart with all fixes
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/http_client_factory.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_local_data_source.dart';

import 'package:snapnfix/modules/index.dart';

import './dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  try {
    debugPrint('🔧 Configuring dependency injection...');

    // Setup HydratedStorage first
    await _setupHydratedStorageDirectory();
    debugPrint('✅ HydratedStorage directory set up successfully');

    // Initialize DI container (this will now handle DeviceInfoService properly)
    await getIt.init();

    // Initialize services that need async setup
    await _initializeServices();

    // Setup HTTP client after services are initialized
    _setupHttpClient();

    // Wait for all async singletons to be ready
    await getIt.allReady();

    debugPrint('✅ Dependency injection configured successfully');
  } catch (e, stackTrace) {
    debugPrint('❌ Error configuring dependencies: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}

Future<void> _setupHydratedStorageDirectory() async {
  try {
    
    final path = (await getTemporaryDirectory()).path;
    debugPrint('Setting up HydratedStorage at: $path');
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(path),
    );
  } catch (e) {
    debugPrint('❌ Error initializing HydratedStorage: $e');
    rethrow;
  }
}

Future<void> _initializeServices() async {
  try {
    // Initialize SharedPreferences service
    if (getIt.isRegistered<SharedPreferencesService>()) {
      final sharedPrefsService = getIt<SharedPreferencesService>();
      await sharedPrefsService.init();
      debugPrint('✅ SharedPreferences initialized');
    }

    // Initialize ApplicationConfigurations
    if (getIt.isRegistered<ApplicationConfigurations>()) {
      final appConfig = getIt<ApplicationConfigurations>();
      await appConfig.init();
      debugPrint('✅ ApplicationConfigurations initialized');
    }

    // Initialize Report local data source if registered
    if (getIt.isRegistered<BaseReportLocalDataSource>()) {
      final reportLocalDataSource = getIt<BaseReportLocalDataSource>();
      await reportLocalDataSource.initialize();
      debugPrint('✅ Report local data source initialized');
    }
  } catch (e) {
    debugPrint('❌ Error initializing services: $e');
    rethrow;
  }
}

void _setupHttpClient() {
  try {
    if (getIt.isRegistered<ApplicationConfigurations>()) {
      final appConfig = getIt<ApplicationConfigurations>();
      final token = appConfig.currentSession?.tokens.accessToken ?? '';

      if (token.isNotEmpty) {
        HttpClientFactory.setAuthToken(token);
        debugPrint('✅ HTTP client configured with auth token');
      } else {
        debugPrint(
          '⚠️ No auth token available, HTTP client configured without token',
        );
      }
    }
  } catch (e) {
    debugPrint('❌ Error setting up HTTP client: $e');
  }
}

Future<void> resetDependencies() async {
  try {
    await getIt.reset();
    debugPrint('✅ Dependencies reset successfully');
  } catch (e) {
    debugPrint('❌ Error resetting dependencies: $e');
    rethrow;
  }
}
