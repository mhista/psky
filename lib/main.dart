import 'package:ahiaa_web/data/repositories/auth_repo/authentication_repository.dart';
import 'package:ahiaa_web/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

Future<void> main() async {
  // ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Iniitialize Getx local storage
  GetStorage.init();
  // remove the # sign from url
  setPathUrlStrategy();

  // initialize firebase & authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  // run app
  runApp(DevicePreview(builder: (context) => const App()));
  // runApp(const App());
}
