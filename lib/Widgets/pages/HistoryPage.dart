// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:next_food/DAO/history_dao.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Service/local_storage.dart';
import 'package:next_food/Widgets/components/history_item.dart';
import 'package:next_food/Widgets/components/logo.dart';
import 'package:next_food/Widgets/pages/SignInPage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryDAO>? historyData;
  DataManager dataManager = DataManager();
  LocalStorage localStorage = LocalStorage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();

    localStorage.getUserId().then(
          (uid) => {
            print("==============================Truc Vy\n"),
            print(uid),
            if (uid != null)
              {
                dataManager.GetHistory(context, uid).then((value) => {
                      setState(() {
                        historyData = value;
                      })
                    })
              }
            else if (uid == null)
              {
                setState(() {
                  historyData = [];
                })
                // authClass.logout(context),
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (builder) => SignInPage()),
                //   (route) => false,
                // )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              AppLogoWidget(),
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return historyItem(historyData![index]);
                  },
                  itemCount: historyData!.length,
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
