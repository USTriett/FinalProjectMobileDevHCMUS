import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_food/Themes/theme_constants.dart';

Widget buttonItem(BuildContext context, String text, String icon, double size,
    void Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 60,
      child: Card(
        color: Color.fromARGB(255, 248, 218, 128),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        elevation: 8, // Shadow of the Card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: size,
              width: size,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                color: ThemeConstants.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
