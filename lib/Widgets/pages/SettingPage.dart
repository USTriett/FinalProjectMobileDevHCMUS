

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/DAO/history_dao.dart';
import 'package:next_food/Data/sqlite_data.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/tutorial_swipe_component.dart';
import 'package:next_food/Widgets/pages/MapPage.dart';

import '../../Values/constants.dart';

class SettingPage extends StatefulWidget{
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Set<String> foodIDs = {};
    Set<String> restaurantAddresses = {};
    for(HistoryDAO h in DAO.history){
      foodIDs.add(h.foodID);
      if(h.restaurantAddress != null) {
        restaurantAddresses.add(h.restaurantAddress!);
      }
    }
    return SafeArea(

      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children:[
                Container(
                  color: Colors.amberAccent,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      _buildLogo(),
                      const Text(
                        "NEXT FOOD",
                        style: ThemeConstants.titleStyle,
                      )
                    ],
                  )
                ),
               ]
            ),

            Center(
              child: Container(
                height: 100,
                width: 240,
                // color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: SvgPicture.asset(
                              'assets/restaurantIcon.svg',
                              width: 40, // Adjust the width as needed
                              height: 40,
                              color: Colors.amber[700],// Adjust the height as needed
                            ),
                          ),
                          Text("${restaurantAddresses.length}", style: ThemeConstants.textStyleMedium)
                        ],
                      ),
                    ),
                    // Container(
                    //   width: 2,
                    //   height: 80,
                    //   color: Colors.black54,
                    // ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.fromLTRB(5,5,0,5),
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: SvgPicture.asset(
                              "assets/foodIcon.svg",
                              height: 40,
                              width: 40,
                              color: Colors.amber[700],
                            )
                          ),
                          Text("${foodIDs.length}", style: ThemeConstants.textStyleMedium)
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),

            Container(
              child: _ButtonEdit(
                callback: () async{
                  Set<FoodDAO> foods = {};
                  for(HistoryDAO h in DAO.history) {
                    FoodDAO dao = await SqliteData.getFoodByName(h.foodName);
                    foods.add(dao);
                  }

                  showDialog(
                      context: context,
                      builder: (context){
                        _dismissDialog() {
                          Navigator.pop(context);
                          setState(() {

                          });
                        }
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          content: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                // color: Colors.grey,
                                height: 500,
                                margin: EdgeInsets.fromLTRB(0, 60, 0, 60),
                                width: double.maxFinite,
                                child: _buildGridFood(
                                  foods: foods.toList(),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: _dismissDialog,
                              ),
                            ],
                          ),

                        );
                      }
                  );
                },
                text: "Danh sách món ăn đã chọn",
              ),
            ),
            Container(
              child: _ButtonEdit(
                callback: (){
                  AuthClass auth = AuthClass();
                  auth.logout(context);
                },
                text: "Đăng xuất",
              ),
            ),

          ],
        ),
      ),
    );
  }

  _buildButtonEdit(String text, callback){
    return Padding(
      padding: const EdgeInsets.fromLTRB(25,15,25,0),
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(25,0,25,0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                style: ThemeConstants.textStyleSmall,
              ),
              Icon(
                  Icons.navigate_next
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHobbyTags(List<HobbyTag>? tags) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Container(
        width: 1000,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),

        child: Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 16,
            runSpacing: 16,
            children: tags?.map((tag) => tag ?? Container()).toList() ?? [],
          ),
        ),
      ),
    );
  }

  _buildLogoutBtn() {
    return Container();
  }

  _buildLogo() {
    return Container(
      height: 150,
      width: 150,
      margin: EdgeInsets.fromLTRB(0,50, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            "assets/avatar.png"
          ),

          fit: BoxFit.fitHeight,
        ),
      )
    );
  }

  _hobbyEdit() {

  }

  Future<void> _logout() async {
    AuthClass auth = AuthClass();
    await auth.logout(context);

  }

  Widget _buildGridFood({required List<FoodDAO> foods}) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(foods.length, (index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => MapPage(food: foods[index])
                )
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  foods[index].imgURL
                ),
                fit: BoxFit.fill
              )
            ),
          ),
        );
      }),
    );
  }
}
class _ButtonEdit extends StatelessWidget {
  final Function _callback;
  final String _text;

  _ButtonEdit({required Function callback, required String text})
      : _callback = callback,
        _text = text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: GestureDetector(
        onTap: () {
          _callback();
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _text,
                style: ThemeConstants.textStyleSmall,
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
    );
  }
}


class HobbyTag extends StatelessWidget{
  final String tagName;

  const HobbyTag({super.key, required this.tagName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tagName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: ThemeConstants.textStyleSmall,
            ),
            Icon(
              Icons.cancel_outlined
            ),
          ],
        ),
      ),
    );
  }
}

