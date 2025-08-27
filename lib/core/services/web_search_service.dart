import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/web_search_result_model.dart';
import 'api_service.dart'; // To reuse the headers

class WebSearchService {
  static Future<WebSearchResult> search(String query) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/v1/web'),
        headers: ApiService.headers, // Reuse headers from ApiService
        body: jsonEncode({
          'query': query,
          'max_results': 30, // As requested by user
        }),
      );

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          return WebSearchResult.fromJson(data);
        } catch (e) {
          // This is the specific parsing error case.
          print('Error parsing web search JSON: $e');
          print('Raw JSON response for debugging:\n${response.body}');
          return WebSearchResult(
            webPages: [],
            newsArticles: [],
            images: [],
            hasError: true,
            rawJson: response.body,
            errorMessage:
                'The web search service returned data in an unexpected format. This may be a temporary issue.',
          );
        }
      } else {
        // This is for non-200 responses.
        print(
            'Web search request failed with status: ${response.statusCode} ${response.reasonPhrase}');
        return WebSearchResult(
          webPages: [],
          newsArticles: [],
          images: [],
          hasError: true,
          rawJson: response.body, // The body might have useful error info
          errorMessage:
              'The web search service is temporarily unavailable (Error ${response.statusCode}). Please try again later.',
        );
      }
    } catch (e) {
      // This catches other errors, like network issues.
      print('An unexpected error occurred during web search: $e');
      return WebSearchResult(
        webPages: [],
        newsArticles: [],
        images: [],
        hasError: true,
        errorMessage:
            'A network error occurred while trying to search the web. Please check your connection and try again.',
        rawJson: '{"error": "A network or client-side error occurred: $e"}',
      );
    }
  }
}
