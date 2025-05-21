import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sizendoapp/data/models/post.dart';  // pastikan import model kamu

class ApiService {
  static const String baseUrl = 'http://siberzendo.com/api_login.php'; // sesuaikan

  static Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/get_post.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
