import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/icon_text.dart';

Widget historyItem(Map historyItemData) {
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
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            // navigate to map with search key = food name
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
                    image: AssetImage(historyItemData['food_image']))),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // navigate to map with restaurant location
                  },
                  child: Text(
                    historyItemData['restaurant_name'],
                    style: ThemeConstants.storeTitleStyle,
                  ),
                ),
                Text(
                  historyItemData['food_name'],
                  style: ThemeConstants.storeSubtitleStyle,
                ),
                IconText(
                  icon: Icons.location_on,
                  content: historyItemData['restaurant_address'],
                ),
                IconText(
                  icon: Icons.access_time,
                  content: historyItemData['time'],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
