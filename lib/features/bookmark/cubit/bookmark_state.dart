part of 'bookmark_cubit.dart';

enum BookmarkStatus { loading, loaded, error }

extension BookmarkStatusX on BookmarkState {
  bool get isLoading => status == BookmarkStatus.loading;
  bool get isLoaded => status == BookmarkStatus.loaded;
  bool get isError => status == BookmarkStatus.error;
}

class BookmarkState {
  final BookmarkStatus status;
  final List<NewsModel>? bookmarks;
  final String? errorMessage;
  BookmarkState({
    required this.status,
    this.bookmarks,
    this.errorMessage,
  });

  BookmarkState copyWith({
    BookmarkStatus? status,
    List<NewsModel>? bookmarks,
    String? errorMessage,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'BookmarkState(status: $status, bookmarks: $bookmarks, errorMessage: $errorMessage)';

  @override
  bool operator ==(covariant BookmarkState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.bookmarks, bookmarks) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ bookmarks.hashCode ^ errorMessage.hashCode;
}
