import 'package:bloc/bloc.dart';
import 'package:newsly/features/home/data/models/article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState(bookmarks: []));

  void addToBookmarks(ArticleModel article) {
    final updatedList = List<ArticleModel>.from(state.bookmarks)..add(article);
    emit(BookmarkState(bookmarks: updatedList));
  }

  void removeFromBookmarks(ArticleModel product) {
    final updatedList = List<ArticleModel>.from(state.bookmarks)
      ..remove(product);
    emit(BookmarkState(bookmarks: updatedList));
  }

  void clearBookmarks() {
    emit(BookmarkState(bookmarks: []));
  }
}

// class BookmarkCubit extends Cubit<BookmarkState> {
//   BookmarkCubit() : super(BookmarkState(status: BookmarkStatus.loading));

//   void loadBookmarks(List<NewsModel> bookmarks) {
//     if (bookmarks.isEmpty) {
//       emit(state.copyWith(status: BookmarkStatus.empty));
//     } else {
//       emit(state.copyWith(status: BookmarkStatus.loaded, bookmarks: bookmarks));
//     }
//   }

//   void addBookmark(NewsModel bookmark) {
//     final updatedBookmarks = List<NewsModel>.from(state.bookmarks ?? [])
//       ..add(bookmark);
//     emit(state.copyWith(
//         status: BookmarkStatus.loaded, bookmarks: updatedBookmarks));
//   }

//   void removeBookmark(NewsModel bookmark) {
//     final updatedBookmarks = List<NewsModel>.from(state.bookmarks ?? [])
//       ..remove(bookmark);
//     emit(state.copyWith(
//         status: BookmarkStatus.loaded, bookmarks: updatedBookmarks));
//   }

//   void setError(String errorMessage) {
//     emit(state.copyWith(
//         status: BookmarkStatus.error, errorMessage: errorMessage));
//   }
// }
