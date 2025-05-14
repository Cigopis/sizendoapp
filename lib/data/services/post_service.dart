import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sizendoapp/data/models/post.dart';

class PostService {
  static const String _url = 'https://siberzendo.com/get_post.php';

  static Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PostModel.fromJson(data)).toList();
    } else {
      throw Exception('Gagal memuat data postingan');
    }
  }
}
