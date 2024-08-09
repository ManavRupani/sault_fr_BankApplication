import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://json-storage-api.p.rapidapi.com/datalake';
  static const String _apiKey = 'YOUR_API_KEY';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'x-rapidapi-key': _apiKey,
    'x-rapidapi-host': 'json-storage-api.p.rapidapi.com',
  };

  Future<http.Response> postData(Map<String, dynamic> body) async {
    final url = Uri.parse(_baseUrl);
    final response = await http.post(url, headers: _headers, body: jsonEncode(body));
    return response;
  }

  Future<http.Response> searchData(Map<String, dynamic> filter) async {
    final body = {
      "@context": [],
      "@type": "SearchAction",
      "Object": {
        "@type": "Filter",
        "FilterItem": filter,
      }
    };
    return postData(body);
  }

  // Add more methods for different types of requests if needed
}
