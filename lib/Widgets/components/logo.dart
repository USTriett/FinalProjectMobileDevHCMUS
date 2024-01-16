import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // Đặt kích thước hoặc cách căn chỉnh theo nhu cầu của bạn
        width: 300.0,
        height: 300.0,
        // Thay thế AssetImage bằng Image.network hoặc các widget hình ảnh khác tùy thuộc vào nguồn ảnh của bạn
        child: Image.asset('assets/logo.png'),
        // Các thuộc tính khác như padding, margin có thể được thêm vào tùy thuộc vào yêu cầu của bạn
      ),
    );
  }
}
