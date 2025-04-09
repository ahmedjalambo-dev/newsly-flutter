import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/home/cubit/home_cubit.dart';
import 'package:newsly/features/home/data/repos/news_repo.dart';
import 'package:newsly/features/home/data/services/news_service.dart';
import 'package:newsly/main_app.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BookmarkCubit(),
        ),
        BlocProvider(
          create: (_) =>
              HomeCubit(newsRepo: NewsRepo(newsService: NewsService()))
                ..fetchNews(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
