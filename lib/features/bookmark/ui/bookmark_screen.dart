import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/widgets/circle_icon_button.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/core/widgets/news_tile.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /// Clear Bookmarks Button
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            child: BlurCircleIconButton(
              onPressed: () {
                context.read<BookmarkCubit>().resetBookmarksFlag();
                context.read<BookmarkCubit>().clearBookmarks();
              },
              icon: Icons.bookmark_remove_outlined,
            ),
          )
        ],
      ),
      body: BlocConsumer<BookmarkCubit, BookmarkState>(
        listener: (context, state) {
          if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMassage!),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final bookmarks = state.bookmarks;
            if (bookmarks!.isEmpty) {
              return const Center(
                child: Text(
                  'No Bookmarks Yet',
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = bookmarks[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(article: bookmark),
                      ),
                    ),
                    child: NewsTile(
                      article: bookmark,
                      index: index,
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
