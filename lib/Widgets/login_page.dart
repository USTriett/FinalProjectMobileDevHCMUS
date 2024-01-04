import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/constants.dart';

import '../FireBaseController/Authenication.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier userCredential = ValueNotifier("");
    return Scaffold(
      body: Theme(
        data: ThemeManager.getThemeData(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            Container(
              margin: const EdgeInsets.all(ThemeConstants.defaultMargin),
              child: ElevatedButton(
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        AppImagePath.facebook,
                        width: 24,
                        height: 24,
                      ),
                      const Text("Đăng nhập với Facebook"),
                    ],
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.all(ThemeConstants.defaultMargin),
              child: ElevatedButton(
                  onPressed: () async {
                    userCredential.value = await signInWithGoogle();
                    if (userCredential.value != null)
                      print(userCredential.value.user!.email);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        AppImagePath.google,
                        width: 24,
                        height: 24,
                      ),
                      const Text("Đăng nhập với Google"),
                    ],
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.all(ThemeConstants.defaultMargin),
              child: const ElevatedButton(
                  onPressed: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Đăng nhập bằng số điện thoại"),
                    ],
                  )
              ),
            ),
            TextButton(
              onPressed: () { },
              child: const Text('Tiếp tục với tư cách Guest'),
            )

          ],
        ),
      ),
    );
  }

}