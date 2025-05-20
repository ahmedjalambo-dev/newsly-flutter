import 'package:get_it/get_it.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/categories/cubit/category_cubit.dart';
import 'package:newsly/features/categories/data/category_repo.dart';
import 'package:newsly/features/categories/data/category_service.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/home_repo.dart';
import 'package:newsly/features/home/data/home_service.dart';
import 'package:newsly/features/search/cubit/search_cubit.dart';
import 'package:newsly/features/search/data/search_repo.dart';
import 'package:newsly/features/search/data/search_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<SharedPrefsHelper>(SharedPrefsHelper());
  // Register services
  getIt.registerLazySingleton(() => HomeService());
  getIt.registerLazySingleton(() => CategoryService());
  getIt.registerLazySingleton(() => SearchService());

  // Register repositories
  getIt
      .registerLazySingleton(() => HomeRepo(homeService: getIt<HomeService>()));
  getIt.registerLazySingleton(
      () => SearchRepo(searchService: getIt<SearchService>()));
  getIt.registerLazySingleton(
      () => CategoryRepo(categoryService: getIt<CategoryService>()));

  // Register cubits
  getIt.registerLazySingleton(() => BookmarkCubit());
  getIt.registerLazySingleton(
      () => HomeCubit(newsRepo: getIt<HomeRepo>())..fetchHomeNews());
  getIt.registerLazySingleton(
      () => SearchCubit(searchRepo: getIt<SearchRepo>()));
  getIt.registerFactoryParam<CategoryCubit, String, void>(
      (category, _) => CategoryCubit(
            categoryRepo: getIt<CategoryRepo>(),
            category: category,
          ));
}
