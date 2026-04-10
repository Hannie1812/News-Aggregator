import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/news_response.dart';

part 'news_api_service.g.dart'; // File tự động sinh

@RestApi(baseUrl: "https://newsapi.org/v2")
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET("/top-headlines")
  Future<NewsResponse> getTopHeadlines(
    @Query("country") String country,
    @Query("apiKey") String apiKey,
    @Query("page") int? page,
    @Query("pageSize") int? pageSize,
  );

  @GET("/everything")
  Future<NewsResponse> searchNews(
    @Query("q") String query,
    @Query("apiKey") String apiKey,
    @Query("language") String? language,
    @Query("sortBy") String? sortBy,
    @Query("page") int? page,
  );

  @GET("/top-headlines")
  Future<NewsResponse> getNewsByCategory(
    @Query("country") String country,
    @Query("category") String category,
    @Query("apiKey") String apiKey,
  );
}