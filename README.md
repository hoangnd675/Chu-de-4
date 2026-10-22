# CHỦ ĐỀ 04 - Flutter MVVM và quản lý trạng thái

## 1. Chức năng

Ứng dụng đọc 10 bài viết từ REST API công khai:  
`https://jsonplaceholder.typicode.com/posts?_limit=10`

- **Loading:** hiện `CircularProgressIndicator` khi đang tải.
- **Success:** hiện danh sách bài viết khi nhận dữ liệu.
- **Error:** hiện thông báo lỗi và nút **Thử lại** nếu tải thất bại.
- Có nút tải lại trên thanh ứng dụng.

## 2. Cấu trúc

```text
lib/
├── main.dart
├── models/
│   └── post.dart
├── services/
│   └── post_service.dart
├── viewmodels/
│   └── post_view_model.dart
└── views/
    └── post_page.dart
test/
└── post_test.dart
pubspec.yaml
```

**Model** chỉ chứa dữ liệu và hàm `fromJson`.

**Service** thực hiện HTTP GET, kiểm tra status code và parse JSON.

**ViewModel** gọi service, giữ danh sách dữ liệu, trạng thái và thông báo lỗi; sau đó gọi `notifyListeners()`.

**View** chỉ xây dựng giao diện và gọi phương thức `loadPosts()` trên ViewModel. View không chứa `http.get` hay `jsonDecode`.

## 3. Cách chạy

Yêu cầu: Flutter SDK đã cài và chạy `flutter doctor` không còn vấn đề ảnh hưởng nền tảng dự định dùng.

Do gói nộp chỉ bao gồm **mã nguồn ứng dụng**, hãy tạo các thư mục nền tảng bằng Flutter CLI:

```bash
cd chu_de_04_flutter_mvvm
flutter create .
flutter pub get
flutter run
```

`flutter create .` bổ sung thư mục `android/`, `ios/`, v.v. nếu chưa có. Không dùng lệnh `flutter create --overwrite .` để tránh ghi đè mã nguồn đang có.

Nếu chạy Android bản release, cần khai báo quyền truy cập Internet trong `android/app/src/main/AndroidManifest.xml` khi chưa có:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Để chạy kiểm thử Model:

```bash
flutter test
```

## 4. Kịch bản demo trên lớp

1. Mở ứng dụng: hiển thị vòng tròn tải (Loading).
2. Khi API trả về dữ liệu: hiển thị danh sách 10 bài viết (Success).
3. Ngắt kết nối mạng, bấm biểu tượng tải lại; sau thời gian timeout sẽ hiện lỗi (Error).
4. Bật lại mạng và bấm **Thử lại** để tải thành công.
5. Mở mã nguồn để chỉ ra `views/post_page.dart` KHÔNG chứa lệnh gọi HTTP hoặc `jsonDecode`.

## 5. Kiến thức từ giáo trình và phần bổ sung bắt buộc

- **Chương 1:** Flutter / ứng dụng đa nền tảng.
- **Chương 2:** biến, `List`, `Map`, thư viện `http`, `try-catch`, `throw`, `import`.
- **Chương 3:** `class`, constructor có tên `fromJson`, đóng gói, `enum`.
- **Chương 4:** `Future`, `async`, `await`, xử lý lỗi bất đồng bộ và `timeout`.
- **Chưa được dạy trực tiếp trong 4 chương nhưng ĐỀ BÀI yêu cầu:** MVVM, giao diện Flutter với `StatelessWidget`/`StatefulWidget`, `ChangeNotifier`, `ListenableBuilder`, `notifyListeners`. Chỉ dùng các API Flutter tối thiểu để hoàn thành đề, không thêm Provider/Riverpod/Bloc.

## 6. Ghi chú

- API JSONPlaceholder là dịch vụ công khai bên ngoài, cần Internet và có thể không truy cập được trong môi trường mạng bị chặn.
- Không đưa `http.get`/`jsonDecode` vào View.
- Mã nguồn được viết theo hướng đơn giản, phù hợp trình độ sinh viên.
- Tại đây không có bộ Flutter SDK nên **chưa thể chạy ứng dụng trên giả lập và chạy `flutter analyze` thực tế**; cần xác nhận lại trên máy có Flutter.
