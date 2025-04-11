import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/core/cache/shared_prefs_helper.dart';
import 'package:newsly/core/di/service_locator.dart';
import 'package:newsly/features/home/data/models/article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState(status: BookmarkStatus.loading)) {
    getBookmarks();
  }

  final SharedPrefsHelper _prefsHelper = getIt<SharedPrefsHelper>();
  final String _cacheKey = 'bookmarks';

  /// This method is used to get the list of bookmarks from the cache.
  void getBookmarks() {
    try {
      emit(state.copyWith(status: BookmarkStatus.loading));
      final bookmarks = _prefsHelper.getArticleList(_cacheKey);
      emit(state.copyWith(
        status: BookmarkStatus.loaded,
        bookmarks: bookmarks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.error,
        errorMassage: 'Failed to get Bookmark: $e',
      ));
    }
  }

  /// This method is used to add a bookmark to the list of bookmarks.
  void addBookmark(ArticleModel article) {
    try {
      article.isBookmark = true;
      final updatedList = List<ArticleModel>.from(state.bookmarks ?? [])
        ..add(article);
      _prefsHelper.saveArticleList(_cacheKey, updatedList);
      emit(state.copyWith(
        status: BookmarkStatus.loaded,
        bookmarks: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.error,
        errorMassage: 'Failed to add Bookmark: $e',
      ));
    }
  }

  /// This method is used to remove a bookmark from the list of bookmarks.
  void removeBookmark(ArticleModel article) {
    try {
      article.isBookmark = false;
      final updatedList = List<ArticleModel>.from(state.bookmarks ?? [])
        ..removeWhere((e) => e.title == article.title);
      _prefsHelper.saveArticleList(_cacheKey, updatedList);
      emit(state.copyWith(
        status: BookmarkStatus.loaded,
        bookmarks: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.error,
        errorMassage: 'Failed to remove Bookmark: $e',
      ));
    }
  }

  /// This method is used to reset the bookmarks flag for all articles in the list.
  void resetBookmarksFlag() {
    final updatedList = List<ArticleModel>.from(state.bookmarks ?? []);
    for (var article in updatedList) {
      article.isBookmark = false;
    }
  }

  /// This method clears all bookmarks from the cache and updates the state.
  void clearBookmarks() {
    try {
      _prefsHelper.removeData(key: _cacheKey);
      emit(state.copyWith(
        status: BookmarkStatus.loaded,
        bookmarks: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.error,
        errorMassage: 'Failed to clear Bookmarks:  $e',
      ));
    }
  }
}
