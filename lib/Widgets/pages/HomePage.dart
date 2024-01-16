import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';

import '../components/category_card.dart';
import '../components/logo.dart';
import 'SignUpPage.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<StatefulWidget> createState() => LocationCardState();
}

class LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/location.svg',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
            ),
            _getCurrentAddress()
          ],
        ));
  }

  Widget _getCurrentAddress() {
    return FutureBuilder<Placemark>(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Text('Current Address: ${snapshot.data}');
        } else {
          return Text('No data available.');
        }
      },
    );
  }

  Future<Placemark> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return placemark;
    } else {
      throw Exception('No address found for the current location.');
    }
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
      child: Expanded(
          child: ListView(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: LocationCard()),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: AppLogoWidget(),
          ),
          FoodCard(FoodDAO("bún riêu", [false, true, false, true],
              "assets/bun_rieu.jpg", 0, "Bún mắm gất ngon")),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                SizedBox(
                    width: 8), // Adjust the spacing between the icon and text
                Text(
                  "Categories",
                  style: ThemeConstants.buttonStyle,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(children: [
              CategoryCard(imgUrl: "assets/bun_rieu.jpg", name: "đồ chay"),
              CategoryCard(imgUrl: "assets/bun_rieu.jpg", name: "món nước"),
            ]),
          ),
        ],
      )),
    ));
  }
}
