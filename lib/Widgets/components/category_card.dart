import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:next_food/DAO/category_dao.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Values/constants.dart';
import 'package:next_food/Widgets/pages/NavBar.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, required this.category}) : super(key: key) {
    this.imgUrl = category.imageURL;
    this.name = category.categoryName;
  }

  late String imgUrl;
  late String name;
  final CategoryDAO category;
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: (){
        WidgetKey.findkey.currentState?.fetchListFood(this.name);
        WidgetKey.navBarKey.currentState?.setPage(NavBarComponent.FIND_FOOD_TAB);
      },
      child: Container(
      child: _buildCircleImage(),
    ),
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
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    imgUrl,
                  ),
                  fit: BoxFit.fill)),
        ),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: ThemeConstants.textStyleSmall,
        )
      ],
    );
  }
}
