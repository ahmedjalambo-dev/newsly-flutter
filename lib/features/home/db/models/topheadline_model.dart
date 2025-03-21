import 'package:newsly/features/home/db/models/article_model.dart';

class TopheadlineModel {
  String? status;
  int? totalResults;
  List<ArticleModel>? articles;

  TopheadlineModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  TopheadlineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    articles = List<ArticleModel>.from(
        json['articles'].map((e) => ArticleModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles!.map((e) => e.toJson()).toList(),
      };
}
