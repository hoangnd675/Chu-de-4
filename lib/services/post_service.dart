import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  // API công khai, không cần đăng nhập.
  final String apiUrl =
      'https://jsonplaceholder.typicode.com/posts?_limit=10';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl)).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 200) {
      throw Exception('Lỗi máy chủ: ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    final List<Post> posts = [];

    for (final item in data) {
      posts.add(Post.fromJson(item as Map<String, dynamic>));
    }

    return posts;
  }
}
