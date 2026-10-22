import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../viewmodels/post_view_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final PostViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PostViewModel(PostService());
    _viewModel.loadPosts();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài viết'),
        actions: [
          IconButton(
            tooltip: 'Tải lại dữ liệu',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _viewModel.loadPosts();
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          if (_viewModel.status == LoadStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.status == LoadStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_viewModel.errorMessage),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      _viewModel.loadPosts();
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (_viewModel.posts.isEmpty) {
            return const Center(child: Text('Không có dữ liệu.'));
          }

          return ListView.builder(
            itemCount: _viewModel.posts.length,
            itemBuilder: (context, index) {
              final post = _viewModel.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
      ),
    );
  }
}
