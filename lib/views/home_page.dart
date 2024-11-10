import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/news_service.dart';
import '../widgets/category_card.dart';
import '../widgets/news_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> categories = [
    {'imagePath': 'assets/images/tech.png', 'text': 'Technology'},
    {'imagePath': 'assets/images/sports.avif', 'text': 'Sports'},
    {'imagePath': 'assets/images/health.png', 'text': 'Health'},
    {'imagePath': 'assets/images/general.avif', 'text': 'Science'},
    {'imagePath': 'assets/images/business.jpg', 'text': 'Business'},
  ];

  final NewsSerivce newsService = NewsSerivce(Dio());
  final ScrollController _scrollController = ScrollController();

  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String _currentCategory = "general";

  @override
  void initState() {
    super.initState();
    _fetchArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchArticles({bool loadMore = false}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      List<ArticleModel> newArticles = await newsService
          .getNewsByCategory(_currentCategory, page: _currentPage);

      setState(() {
        if (newArticles.isEmpty) {
          _hasMore = false; // No more articles to load
        } else {
          if (loadMore) {
            _articles.addAll(newArticles);
          } else {
            _articles = newArticles;
          }
          _currentPage++;
        }
      });
    } catch (e) {
      print('Error loading articles: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMore && !_isLoading) {
        _fetchArticles(loadMore: true);
      }
    }
  }

  void _fetchCategoryNews(String category) {
    setState(() {
      _currentCategory = category.toLowerCase();
      _currentPage = 1;
      _hasMore = true;
      _articles.clear(); // Clear existing articles for new category
    });
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'sans-serif',
            ),
            children: [
              TextSpan(text: 'News'),
              TextSpan(
                text: 'Cloud',
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    imagePath: categories[index]['imagePath']!,
                    text: categories[index]['text']!,
                    onTap: () => _fetchCategoryNews(categories[index]['text']!),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 8);
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _articles.isEmpty && !_isLoading
                  ? Center(child: Text('No articles available'))
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _articles.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _articles.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        ArticleModel article = _articles[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: NewsTile(
                            imagePath: article.image ??
                                'assets/images/placeholder.png',
                            title: article.title,
                            desc:
                                article.subTitle ?? 'No description available.',
                          ),
                        );
                      },
                    ),
            ),
            if (_isLoading && _articles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
