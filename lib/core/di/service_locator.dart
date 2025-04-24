import 'package:get_it/get_it.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/categories/cubit/category_cubit.dart';
import 'package:newsly/features/categories/data/repos/category_repos.dart';
import 'package:newsly/features/categories/data/services/category_service.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/home_repo.dart';
import 'package:newsly/features/home/data/home_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<SharedPrefsHelper>(SharedPrefsHelper());
  // Register services
  getIt.registerLazySingleton(() => HomeService());
  getIt.registerLazySingleton(() => CategoryService());

  // Register repositories
  getIt
      .registerLazySingleton(() => HomeRepo(homeService: getIt<HomeService>()));
  getIt.registerLazySingleton(
      () => CategoryRepo(categoryService: getIt<CategoryService>()));

  // Register cubits
  getIt.registerLazySingleton(() => BookmarkCubit());
  getIt.registerLazySingleton(
      () => HomeCubit(newsRepo: getIt<HomeRepo>())..fetchHomeNews());
  getIt.registerFactoryParam<CategoryCubit, String, void>(
      (category, _) => CategoryCubit(
            categoryRepo: getIt<CategoryRepo>(),
            category: category,
          ));
}
