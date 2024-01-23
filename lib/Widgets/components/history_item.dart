import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/DAO/history_dao.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/icon_text.dart';
import 'package:next_food/Widgets/pages/MapPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Values/constants.dart';
void openGoogleMapsDirections(String addressDestination) async {
  final url =
      'google.navigation:q=$addressDestination';
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
Widget historyItem(HistoryDAO historyDAO, BuildContext context) {
  // historyItemData = {
  //     'food_id': 1,
  //     'food_name': 'Bún Mắm',
  //     'food_image': 'assets/bun_rieu.jpg',
  //     'restaurant_id': 1,
  //     'restaurant_name': 'Nhà hàng A',
  //     'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
  //     'time': '2021-10-10 10:10:10',
  //   },

  return Card(
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
    child: Container(
      // color: Colors.red,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // navigate to map with search key = food name
              for(FoodDAO f in DAO.foods){
                if(f.id == historyDAO.foodID){
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder:(context)=>MapPage(food: f)
                    )
                  );
                  break;
                }

              }

            },
            child: Container(
              // margin: EdgeInsets.all(5),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        historyDAO.foodImage
                      )
                  )
              ),
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // navigate to google map with restaurant location
                    openGoogleMapsDirections(historyDAO.restaurantAddress??historyDAO.restaurantName);
                  },
                  child: Text(
                    historyDAO.restaurantName,
                    style: ThemeConstants.storeTitleStyle,
                  ),
                ),
                Text(
                  historyDAO.foodName,
                  style: ThemeConstants.storeSubtitleStyle,
                ),
                Row(

                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(historyDAO.restaurantAddress!.replaceAll("${historyDAO.restaurantName},", "")??'',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                        Icons.access_time,

                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(historyDAO.timeStamp.toIso8601String().substring(0, 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                // IconText(
                //   icon: Icons.location_on,
                //   content: historyDAO.restaurantAddress??'',
                // ),
                // IconText(
                //   icon: Icons.access_time,
                //   content: historyDAO.timeStamp.toIso8601String(),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
