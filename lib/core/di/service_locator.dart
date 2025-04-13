import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<SharedPrefsHelper>(SharedPrefsHelper());
  getIt.registerSingleton<Dio>(Dio());
}
