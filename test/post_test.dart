import 'package:flutter_test/flutter_test.dart';
import 'package:chu_de_04_flutter_mvvm/models/post.dart';

void main() {
  test('Post.fromJson chuyen JSON thanh Post', () {
    final post = Post.fromJson({
      'id': 1,
      'title': 'Bai viet 1',
      'body': 'Noi dung mau',
    });

    expect(post.id, 1);
    expect(post.title, 'Bai viet 1');
    expect(post.body, 'Noi dung mau');
  });
}
