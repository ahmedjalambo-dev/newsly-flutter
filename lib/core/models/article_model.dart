import 'package:newsly/core/models/source_model.dart';

class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  SourceModel? source;
  bool isBookmark = false;

  ArticleModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
    this.isBookmark = false,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
    source =
        json['source'] != null ? SourceModel.fromJson(json['source']) : null;
    isBookmark = json['isBookmark'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'source': source?.toJson(),
      'isBookmark': isBookmark,
    };
  }

  ArticleModel copyWith({
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    SourceModel? source,
    bool isBookmark = false,
  }) {
    return ArticleModel(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      source: source ?? this.source,
      isBookmark: isBookmark,
    );
  }

  @override
  String toString() {
    return 'ArticleModel(author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content, source: $source)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.content == content &&
        other.source == source;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        content.hashCode ^
        source.hashCode;
  }
}
