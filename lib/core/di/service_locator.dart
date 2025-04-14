import 'package:get_it/get_it.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/discover/data/repos/discover_repos.dart';
import 'package:newsly/features/discover/data/services/discover_service.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';
import 'package:newsly/features/home/data/services/news_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<SharedPrefsHelper>(SharedPrefsHelper());
  // Register services
  getIt.registerLazySingleton(() => HomeService());
  getIt.registerLazySingleton(() => DiscoverService());

  // Register repositories
  getIt
      .registerLazySingleton(() => HomeRepo(homeService: getIt<HomeService>()));
  getIt.registerLazySingleton(
      () => DiscoverRepo(discoverService: getIt<DiscoverService>()));

  // Register cubits
  getIt.registerLazySingleton(() => BookmarkCubit());
  getIt.registerLazySingleton(
      () => HomeCubit(newsRepo: getIt<HomeRepo>())..fetchHomeNews());
}
