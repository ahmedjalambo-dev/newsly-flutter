import 'dart:convert';

import 'package:newsly/features/home/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  late SharedPreferences _sharedPreferences;

  /// Initialize the cache
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save data to the cache using a key
  Future<bool> saveData<T>({required String key, required T value}) async {
    try {
      if (value is bool) {
        return await _sharedPreferences.setBool(key, value);
      } else if (value is String) {
        return await _sharedPreferences.setString(key, value);
      } else if (value is int) {
        return await _sharedPreferences.setInt(key, value);
      } else if (value is double) {
        return await _sharedPreferences.setDouble(key, value);
      } else if (value is List<String>) {
        return await _sharedPreferences.setStringList(key, value);
      } else {
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
      }
    } catch (e) {
      throw Exception('Error saving data to cache: e');
    }
  }

  /// Get data from the cache using a key
  T? getData<T>({required String key}) {
    try {
      if (T == bool) {
        return _sharedPreferences.getBool(key) as T?;
      } else if (T == String) {
        return _sharedPreferences.getString(key) as T?;
      } else if (T == int) {
        return _sharedPreferences.getInt(key) as T?;
      } else if (T == double) {
        return _sharedPreferences.getDouble(key) as T?;
      } else if (T == List<String>) {
        return _sharedPreferences.getStringList(key) as T?;
      } else {
        throw ArgumentError('Unsupported type: T');
      }
    } catch (e) {
      throw Exception('Error retrieving data from cache: e');
    }
  }

  /// Save a list of articles to the cache using a key
  Future<bool> saveArticleList(String key, List<ArticleModel> articles) async {
    final stringList =
        articles.map((article) => json.encode(article.toJson())).toList();
    return await _sharedPreferences.setStringList(key, stringList);
  }

  /// Get a list of articles from the cache using a key
  List<ArticleModel> getArticleList(String key) {
    final stringList = _sharedPreferences.getStringList(key);
    if (stringList == null) return [];
    return stringList.map((jsonStr) {
      final map = json.decode(jsonStr);
      return ArticleModel.fromJson(map);
    }).toList();
  }



  /// Remove data from the cache using a key
  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  /// Check if the cache contains a specific key
  bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }

  /// Clear all data from the cache
  Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}
