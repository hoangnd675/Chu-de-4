import 'package:flutter/foundation.dart';
import '../models/post.dart';
import '../services/post_service.dart';

// Ba trạng thái yêu cầu trong đề bài.
enum LoadStatus { loading, success, error }

class PostViewModel extends ChangeNotifier {
  final PostService _postService;

  PostViewModel(this._postService);

  LoadStatus _status = LoadStatus.loading;
  List<Post> _posts = [];
  String _errorMessage = '';

  LoadStatus get status => _status;
  List<Post> get posts => _posts;
  String get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    _status = LoadStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _posts = await _postService.fetchPosts();
      _status = LoadStatus.success;
    } catch (_) {
      _errorMessage = 'Không thể tải dữ liệu. Vui lòng thử lại.';
      _status = LoadStatus.error;
    }

    notifyListeners();
  }
}
