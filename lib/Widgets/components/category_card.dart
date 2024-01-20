import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  const CategoryCard({super.key, required this.imgUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCircleImage(),
    );
  }

  Widget _buildCircleImage() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(100),
              image:
                  DecorationImage(fit: BoxFit.fill, image: AssetImage(imgUrl))),
        ),

        Text(
          this.name,
          overflow: TextOverflow.ellipsis,
          style: ThemeConstants.textStyleSmall,
        )
      ],
    );
  }
}
