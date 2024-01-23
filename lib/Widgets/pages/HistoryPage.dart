// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:next_food/Values/constants.dart';
import 'package:next_food/Widgets/components/history_item.dart';
import 'package:next_food/Widgets/components/logo.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final historyData = DAO.history;
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún bò Huế',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún Riêu',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún Mắm',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún bò Huế',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún Riêu',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },
    // {
    //   'food_id': 1,
    //   'food_name': 'Bún Mắm',
    //   'food_image': 'assets/bun_rieu.jpg',
    //   'restaurant_id': 1,
    //   'restaurant_name': 'Nhà hàng A',
    //   'restaurant_address': '343 Tô Hiến Thành, Q.10, TP.HCM',
    //   'time': '2021-10-10 10:10:10',
    // },


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            AppLogoWidget(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return historyItem(historyData[index], context);
                },
                itemCount: historyData.length,
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
