import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/home/ui/widgets/news_tile.dart';

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
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<BookmarkCubit>().clearBookmarks();
            },
            icon: const Icon(Icons.bookmark_remove),
          ),
        ],
      ),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state.bookmarks.isEmpty) {
            return const Center(
              child: Text(
                'No bookmarks yet',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (state.bookmarks.isNotEmpty) {
            return ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = state.bookmarks[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(
                        article: bookmark,
                      ),
                    ),
                  ),
                  child: NewsTile(
                      article: bookmark,
                      validArticles: state.bookmarks,
                      index: index),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
