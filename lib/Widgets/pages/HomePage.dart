import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:next_food/Bloc/Events/navbar_events/navbar_events.dart';
import 'package:next_food/Bloc/navbar_bloc.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Data/sqlite_data.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/pages/MapPage.dart';
import 'package:next_food/Widgets/pages/NavBar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../Values/constants.dart';
import '../components/category_card.dart';
import '../components/logo.dart';
import 'SignUpPage.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<StatefulWidget> createState() => LocationCardState();
}

class LocationCardState extends State<LocationCard> {
  bool isLoad = false;

  String city = '';

  String district='';

  String country ='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _requestLocationPermission();
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
    if(isLoad)
      {
        return Container(
            alignment: Alignment.center,
            height: 60,
            width: 280,
            child: Text(
              '$district, $city\n$country',
              overflow: TextOverflow.visible,
              style: ThemeConstants.textStyleSmall,
            )
        );
      }
    return FutureBuilder<Placemark>(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Expanded(child: Text('...'));
        } else if (snapshot.hasData) {
          Placemark placemark = snapshot.data!;
          city = placemark.administrativeArea ?? '';
          district = placemark.subAdministrativeArea ?? '';
          country = placemark.country ?? '';
          String street = placemark.street ?? '';
          isLoad = true;
          return Container(
              alignment: Alignment.center,
              height: 60,
              width: 280,
              child: Text(
                '$district, $city\n$country',
                overflow: TextOverflow.visible,
                style: ThemeConstants.textStyleSmall,
              )
          );
        } else {
          return Text('No data available.');
        }
      },
    );
  }

  Future<Placemark>? _getCurrentLocation() async {
    bool isAccepted = await _requestLocationPermission();
    if(!isAccepted) {
      return Placemark(country: "NO PERMISSION");
    }
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
  Future<bool> _requestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    return permissionStatus == PermissionStatus.granted;
  }

}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodDAO> cards = DAO.foods;
  //sap xep thu tu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: ListView(
                    children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: LocationCard()),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 20, 20),
              alignment: Alignment.center,
              child: AppLogoWidget(),
            ),
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16/9,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              itemCount: 5,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                GestureDetector(
                  onTap: (){
                    // CurvedNavigationBarState? navBarState =
                    //     WidgetKey.bottomNavigationKey.currentState;
                    // navBarState?.setPage(NavBarComponent.RANDOM_PAGE_TAB);
                    //
                    // WidgetKey.navBarKey?.currentState?.setPage(NavBarComponent.RANDOM_PAGE_TAB);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage(food: cards[itemIndex]))
                    );
                  },
                  child: FoodCard(cards[itemIndex])
                )

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
                  ),
          )),
    ));
  }
}
