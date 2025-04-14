import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';
import 'package:newsly/features/home/data/services/news_service.dart';
import 'package:newsly/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<SharedPrefsHelper>().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BookmarkCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(
            newsRepo: NewsRepo(
              newsService: NewsService(),
            ),
          )..fetchHomeNews(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
