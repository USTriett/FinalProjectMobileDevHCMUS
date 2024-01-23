import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';

class FoodInfoContainer extends StatelessWidget {
  final FoodDAO _info;
  const FoodInfoContainer(this._info, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 8.0)),
            Text(_info.name.toUpperCase(),
                textAlign: TextAlign.start, style: ThemeConstants.titleStyle),
            // Text(_info.script,
            //   textAlign: TextAlign.start,
            //   style: ThemeConstants.cardSubtitleStyle,
            // ),
          ],
        ));
  }
}

class FoodCard extends StatelessWidget {
  final FoodDAO _info;
  const FoodCard(this._info, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("image URL${_info.imgURL}");
    return Container(
      height: 400,
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Stack(children: [
        Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        _info.imgURL,

                      ),
                    fit: BoxFit.fill
                  )
              ),
            ),
            Container(
              height: 50,
              color: Colors.transparent,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: FoodInfoContainer(_info),
          ),
        )
      ]),
    );
  }
}
