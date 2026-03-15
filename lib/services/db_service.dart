// lib/services/db_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/article.dart';

class DbService {
  static const _boxName = 'articles';

  Future<void> saveArticles(List<Article> articles) async {
    final box = Hive.box<Article>(_boxName);
    await box.clear();
    await box.addAll(articles);
  }

  List<Article> getCachedArticles() {
    return Hive.box<Article>(_boxName).values.toList();
  }
}