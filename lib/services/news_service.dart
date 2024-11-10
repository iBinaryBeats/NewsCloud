import 'package:dio/dio.dart';

import '../models/article_model.dart';

class NewsSerivce {
  late Dio dio;

  NewsSerivce(this.dio);

  Future<List<ArticleModel>> getNewsByCategory(String category, {int page = 1}) async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=cd8279ac107b4591b4bb24cb9df022c2&category=$category&page=$page&pageSize=20';

    try {
      Response res = await dio.get(url);
      Map<String, dynamic> jsonData = res.data;

      List<dynamic> articles = jsonData['articles'];
      List<ArticleModel> articleList = [];

      for (var article in articles) {
        if (article['urlToImage'] == null) continue;
        ArticleModel articleModel = ArticleModel(
          image: article['urlToImage'],
          title: article['title'],
          subTitle: article['description'],
        );
        articleList.add(articleModel);
      }

      return articleList;
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
