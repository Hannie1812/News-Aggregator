import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider()..loadTopHeadlines(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Aggregator'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _showSearchDialog(context),
            ),
          ],
        ),
        body: Consumer<NewsProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.articles.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            
            if (provider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${provider.errorMessage}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.refresh(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            
            if (provider.articles.isEmpty) {
              return Center(child: Text('No articles found'));
            }
            
            return RefreshIndicator(
              onRefresh: provider.refresh,
              child: ListView.builder(
                itemCount: provider.articles.length,
                itemBuilder: (context, index) {
                  return NewsCard(article: provider.articles[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return AlertDialog(
          title: Text('Search News'),
          content: TextField(
            onChanged: (value) => query = value,
            decoration: InputDecoration(hintText: 'Enter keywords...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<NewsProvider>().searchNews(query);
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}