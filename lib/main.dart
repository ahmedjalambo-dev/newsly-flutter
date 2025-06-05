import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<SharedPrefsHelper>().init();
  // runApp(const MainApp());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      backgroundColor: Colors.white,
      isToolbarVisible: false,
      builder: (context) => const MainApp(), // Wrap your app
    ),
  );
}
