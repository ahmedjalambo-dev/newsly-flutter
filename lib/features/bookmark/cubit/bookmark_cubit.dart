import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/features/home/data/models/news_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState(status: BookmarkStatus.loading)) {
    loadInitialBookmarks();
  }

  final List<NewsModel> _bookmarks = [];

  Future<void> loadInitialBookmarks() async {
    try {
      emit(state.copyWith(status: BookmarkStatus.loading));
      // Simulate loading from storage or API
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(
        status: BookmarkStatus.loaded,
        bookmarks: List.from(_bookmarks),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.error,
        errorMessage: 'Failed to load bookmarks',
      ));
    }
  }

  void addBookmark(NewsModel news) {
    if (_bookmarks.contains(news)) return;

    _bookmarks.add(news);
    emit(state.copyWith(
      status: BookmarkStatus.loaded,
      bookmarks: List.from(_bookmarks),
    ));
  }

  void removeBookmark(NewsModel news) {
    _bookmarks.remove(news);
    emit(state.copyWith(
      status: BookmarkStatus.loaded,
      bookmarks: List.from(_bookmarks),
    ));
  }

  bool isBookmarked(NewsModel news) {
    return _bookmarks.contains(news);
  }
}
