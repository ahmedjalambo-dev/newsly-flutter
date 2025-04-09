part of 'bookmark_cubit.dart';

class BookmarkState {
  final List<ArticleModel> bookmarks;

  BookmarkState({
    required this.bookmarks,
  });

  BookmarkState copyWith({
    List<ArticleModel>? bookmarks,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }
}
