import 'package:flutter/material.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';

import '../components/category_card.dart';
import '../components/logo.dart';
import 'SignUpPage.dart';

class LocationCard extends StatefulWidget{
  const LocationCard({super.key});

  @override
  State<StatefulWidget> createState() => LocationCardState();

}

class LocationCardState extends State<LocationCard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(20),
      height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
        ),
        child: Card()
    );
  }

}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: LocationCard()
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: AppLogoWidget(),
            ),

            FoodCard(
                    FoodDAO("bún riêu", [false, true, false, true], "assets/bun_rieu.jpg", 0, "Bún mắm gất ngon")
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 8), // Adjust the spacing between the icon and text
                  Text(
                    "Popular Food",
                    style: ThemeConstants.buttonStyle,
                  ),
                ],
              ),
            ),
            // Row(
            //   children:[
            //     CategoryCard(imgUrl: "assets/bun_rieu.jpg"),
            //     CategoryCard(imgUrl: "assets/bun_rieu.jpg"),
            //   ]
            // ),
          ],

        ),
      )

    );
  }
}


