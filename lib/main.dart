import 'package:ahiaa_web/bloc_providers.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter/foundation.dart';
// import 'package:ahiaa_web/firebase_options.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app.dart';

Future<void> main() async {
  // ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  // Initialize dependency injection
  configureDependencies();

  // Iniitialize Getx local storage
  GetStorage.init();
  // remove the # sign from url
  // setPathUrlStrategy();

  // initialize firebase & authentication repository
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  //     .then((value) => );
// Get.put(AuthenticationRepository());
  // run app
  // runApp(DevicePreview(builder: (context) => const App()));
  runApp(MultiBlocProvider(
    providers: AppBlocProviders.blocProviders,
    child: const App(),
  ));
}
