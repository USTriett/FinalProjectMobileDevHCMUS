import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String content;
  const IconText({super.key, required this.icon, required this.content});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15),
        SizedBox(
          width: 5,
        ),
        Text(
          content,
          style: ThemeConstants.storeInforStyle,
        ),
      ],
    );
  }
}
