import 'package:flutter/material.dart';
import '../repositories/news_repository.dart';
import '../models/article.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();
  
  List<Article> _articles = [];
  List<Article> get articles => _articles;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Load top headlines
  Future<void> loadTopHeadlines({String country = 'us'}) async {
    _setLoading(true);
    _errorMessage = null;
    
    try {
      _articles = await _repository.getTopHeadlines(country: country);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _articles = [];
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Search news
  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      await loadTopHeadlines();
      return;
    }
    
    _setLoading(true);
    _errorMessage = null;
    
    try {
      _articles = await _repository.searchNews(query: query);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _articles = [];
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Load by category
  Future<void> loadNewsByCategory(String category) async {
    _setLoading(true);
    _errorMessage = null;
    
    try {
      _articles = await _repository.getNewsByCategory(category: category);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _articles = [];
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  // Refresh data
  Future<void> refresh() async {
    await loadTopHeadlines();
  }
}