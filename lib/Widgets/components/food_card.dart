
import 'package:flutter/material.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
class FoodInfoContainer extends StatelessWidget{
  final FoodDAO _info;
  const FoodInfoContainer(this._info, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text(_info.name,
                textAlign: TextAlign.start,
                style: ThemeConstants.cardTitleStyle),
            Text(_info.script,
              textAlign: TextAlign.start,
              style: ThemeConstants.cardSubtitleStyle,
            ),
          ],
        )
    );
  }

}


class FoodCard extends StatelessWidget{
  final FoodDAO _info;
  const FoodCard(this._info, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        children: <Widget>[
          Image.asset(_info.imgURL, fit: BoxFit.cover),


          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FoodInfoContainer(_info),
          ),
        ],
      ),
    );
  }

}