import '../services/news_api_service.dart';
import '../services/dio_client.dart';
import '../models/news_response.dart';
import '../models/article.dart';

class NewsRepository {
  late NewsApiService _newsApiService;
  final String apiKey = DioClient.apiKey;

  NewsRepository() {
    final dioClient = DioClient();
    _newsApiService = NewsApiService(dioClient.dio);
  }

  // Lấy tin tức nổi bật theo quốc gia
  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    int? page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _newsApiService.getTopHeadlines(
        country,
        apiKey,
        page,
        pageSize,
      );
      
      if (response.status == 'ok') {
        return response.articles ?? [];
      } else {
        throw Exception(response.status ?? 'Unknown error');
      }
    } catch (e) {
      throw Exception('Failed to load top headlines: $e');
    }
  }

  // Tìm kiếm tin tức
  Future<List<Article>> searchNews({
    required String query,
    String? language = 'en',
    String? sortBy = 'publishedAt',
    int? page = 1,
  }) async {
    if (query.isEmpty) {
      return [];
    }
    
    try {
      final response = await _newsApiService.searchNews(
        query,
        apiKey,
        language,
        sortBy,
        page,
      );
      
      if (response.status == 'ok') {
        return response.articles ?? [];
      } else {
        throw Exception(response.status ?? 'Search failed');
      }
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }

  // Lấy tin theo danh mục
  Future<List<Article>> getNewsByCategory({
    required String category,
    String country = 'us',
  }) async {
    try {
      final response = await _newsApiService.getNewsByCategory(
        country,
        category,
        apiKey,
      );
      
      if (response.status == 'ok') {
        return response.articles ?? [];
      } else {
        throw Exception(response.status ?? 'Failed to load category');
      }
    } catch (e) {
      throw Exception('Failed to load $category news: $e');
    }
  }
}