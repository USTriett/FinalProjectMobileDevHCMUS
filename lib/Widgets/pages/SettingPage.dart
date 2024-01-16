

import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';

class SettingPage extends StatelessWidget{
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(

      child: Container(
        color: Colors.tealAccent,
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
            _buildHobbyTags([
              HobbyTag(tagName: "Phở gà"),
              HobbyTag(tagName: "Phở"),
            ]),


            Container(
              child: _buildButtonEdit("Sở thích", _hobbyEdit()),
            ),
            Container(
              child: _buildButtonEdit("Đăng xuất", _logout()),
            )
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
          color: Colors.white,
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

  _logout() {}

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

