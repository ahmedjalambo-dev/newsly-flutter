import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/main_app.dart';

void main() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<SharedPrefsHelper>().init();
  runApp(const MainApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     backgroundColor: Colors.white,
  //     isToolbarVisible: false,
  //     builder: (context) => const MainApp(), // Wrap your app
  //   ),
  // );
}
