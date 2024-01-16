import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  const CategoryCard({super.key, required this.imgUrl});
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
          height: 350,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(

                  fit: BoxFit.fill,
                  image: AssetImage(imgUrl)
              )
          ),

        ),

      ],
    );
  }
}
