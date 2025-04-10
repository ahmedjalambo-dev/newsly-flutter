part of 'bookmark_cubit.dart';

enum BookmarkStatus { loading, loaded, error }

extension BookmarkStatusX on BookmarkState {
  bool get isLoading => status == BookmarkStatus.loading;
  bool get isLoaded => status == BookmarkStatus.loaded;
  bool get isError => status == BookmarkStatus.error;
}

class BookmarkState {
  final BookmarkStatus status;
  final List<ArticleModel>? bookmarks;
  final String? errorMassage;
  BookmarkState({
    required this.status,
    this.bookmarks,
    this.errorMassage,
  });

  BookmarkState copyWith({
    BookmarkStatus? status,
    List<ArticleModel>? bookmarks,
    String? errorMassage,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  bool operator ==(covariant BookmarkState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.bookmarks, bookmarks) &&
        other.errorMassage == errorMassage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ bookmarks.hashCode ^ errorMassage.hashCode;
}
