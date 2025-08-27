import 'package:flutter/foundation.dart';

class WebSearchResult {
  final List<WebPageResult> webPages;
  final List<NewsArticleResult> newsArticles;
  final List<ImageResult> images;
  final String? rawJson; // For debugging
  final bool hasError;
  final String? errorMessage;

  WebSearchResult({
    required this.webPages,
    required this.newsArticles,
    required this.images,
    this.rawJson,
    this.hasError = false,
    this.errorMessage,
  });

  factory WebSearchResult.fromJson(Map<String, dynamic> json) {
    // Safely extract results from a nested structure like json['web']['results']
    List<dynamic> getResults(String key) {
      if (json.containsKey(key) &&
          json[key] is Map &&
          json[key].containsKey('results') &&
          json[key]['results'] is List) {
        return json[key]['results'];
      }
      return [];
    }

    return WebSearchResult(
      webPages:
          getResults('web').map((item) => WebPageResult.fromJson(item)).toList(),
      newsArticles: getResults('news')
          .map((item) => NewsArticleResult.fromJson(item))
          .toList(),
      images: getResults('images')
          .map((item) => ImageResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'web': webPages.map((e) => e.toJson()).toList(),
      'news': newsArticles.map((e) => e.toJson()).toList(),
      'images': images.map((e) => e.toJson()).toList(),
    };
  }
}

class WebPageResult {
  final String title;
  final String link;
  final String snippet;
  final String? thumbnailUrl;

  WebPageResult({
    required this.title,
    required this.link,
    required this.snippet,
    this.thumbnailUrl,
  });

  factory WebPageResult.fromJson(Map<String, dynamic> json) {
    return WebPageResult(
      title: json['title'] ?? '',
      link: json['url'] ?? '', // Match the new API response
      snippet: json['description'] ?? '', // Match the new API response
      thumbnailUrl: json['thumbnail']?['src'], // Safely access nested value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': link,
      'description': snippet,
      'thumbnail': {'src': thumbnailUrl},
    };
  }
}

class NewsArticleResult {
  final String title;
  final String link;
  final String source;
  final String imageUrl;

  NewsArticleResult({
    required this.title,
    required this.link,
    required this.source,
    required this.imageUrl,
  });

  factory NewsArticleResult.fromJson(Map<String, dynamic> json) {
    return NewsArticleResult(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      source: json['source'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'source': source,
      'imageUrl': imageUrl,
    };
  }
}

class ImageResult {
  final String link;
  final String imageUrl;

  ImageResult({
    required this.link,
    required this.imageUrl,
  });

  factory ImageResult.fromJson(Map<String, dynamic> json) {
    return ImageResult(
      link: json['link'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'imageUrl': imageUrl,
    };
  }
}
