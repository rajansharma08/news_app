import 'package:flutter/material.dart';
import '../models/article.dart';
import '../repositories/news_repository.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsProvider extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

  List<Article> articles = [];
  NewsStatus status = NewsStatus.initial;
  String errorMessage = '';

  Future<void> fetchHeadlines() async {
    status = NewsStatus.loading;
    errorMessage = '';
    notifyListeners();

    try {
      final fetched = await _repository.getHeadlines();
      fetched.shuffle();
      articles = fetched;
      status = NewsStatus.loaded;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      status = NewsStatus.error;
    }

    notifyListeners();
  }
}