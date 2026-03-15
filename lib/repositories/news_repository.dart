// lib/repositories/news_repository.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';
import '../models/article.dart';

class NewsRepository {
  final _api = ApiService();
  final _db = DbService();

  Future<List<Article>> getHeadlines() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  final bool isOnline = connectivityResult != ConnectivityResult.none;

  if (isOnline) {
    try {
      final articles = await _api.fetchTopHeadlines();
      
      // Only cache articles that have valid images to save space and ensure quality
      final filtered = articles
          .where((a) => a.urlToImage != null && a.urlToImage!.isNotEmpty)
          .toList();
      
      await _db.saveArticles(filtered);
      return filtered;
    } catch (_) {
      // fall through to cache
    }
  }

  final cached = _db.getCachedArticles();
  if (cached.isEmpty) {
    throw Exception('No internet connection and no cached articles available.');
  }
  return cached;
}
}