
// ============================================================================
// 1. FIXED MAIN.DART - Timezone for Web
// ============================================================================

import 'package:ahiaa_web/bloc_providers.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';

// ✅ FIX: Import timezone differently for web vs mobile
import 'package:timezone/timezone.dart' as tz;
// For web, use data_latest instead of browser
import 'package:timezone/data/latest.dart' as tz_data;

Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  
  // Initialize dependency injection
  await configureDependencies();
  await getIt<LocalStorageService>().initialize();

  // Initialize Getx local storage
  await GetStorage.init();

  // ✅ FIXED: Initialize timezone properly for web
  try {
    if (kIsWeb) {
      // For web, use data/latest
      tz_data.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Africa/Lagos'));
    } else {
      // For mobile, you can use flutter_native_timezone package
      tz_data.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Africa/Lagos'));
      
    }
  } catch (e) {
    debugPrint('Timezone initialization error: $e');
    // Fallback to UTC if Lagos timezone fails
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.UTC);
  }

  // Run app
  runApp(MultiBlocProvider(
    providers: AppBlocProviders.blocProviders,
    child: const App(),
  ));
}
