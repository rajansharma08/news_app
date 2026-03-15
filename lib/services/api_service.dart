import 'package:dio/dio.dart';
import '../models/article.dart';

class ApiService {
  static const String _apiKey = 'YOUR_NEWSAPI_KEY_HERE';
  static const String _baseUrl = 'https://newsapi.org/v2';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Article>> fetchTopHeadlines({String country = 'us'}) async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'country': country,
          'apiKey': _apiKey,
          'pageSize': 20,
          'page': DateTime.now().millisecondsSinceEpoch % 5 + 1,
        },
      );
      final List data = response.data['articles'] ?? [];
      return data
          .map((json) => Article.fromJson(json))
          .where((a) =>
              a.title != '[Removed]' &&
              a.title.isNotEmpty &&
              a.urlToImage != null &&
              a.urlToImage!.isNotEmpty &&
              a.urlToImage!.startsWith('http'))
          .toList();
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}