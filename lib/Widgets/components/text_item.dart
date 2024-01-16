// obsureText is used to hide the password.
import 'package:flutter/material.dart';

Widget textItem(BuildContext context, String labelText,
    TextEditingController controller, bool obscureText) {
  return Container(
    width: MediaQuery.of(context).size.width - 70,
    height: 55,
    child: TextFormField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.amber,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    ),
  );
}
