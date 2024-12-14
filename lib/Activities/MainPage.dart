import 'package:fibro_pred/Activities/HistoricActivity.dart';
import 'package:fibro_pred/Activities/HomeActivity.dart';
import 'package:fibro_pred/Activities/MapActivity.dart';
import 'package:fibro_pred/Utils/AccessNavigator.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:fibro_pred/Utils/StorageService.dart';
import 'package:flutter/material.dart';

import 'LoginActivity.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int nowPage = 0;
  List<Widget> pages = [];

  void initPages() {
    pages = [Homeactivity(), HistoricActivity(), MapActivity()];
  }

  @override
  void initState() {
    initPages();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        nowPage = tabController.index;
        print("Change Tab $nowPage");
      });
    });
    super.initState();
  }

  void _logout() {
    StorageService().deleteData("sessionToken");
    // Add logout functionality here
    AccessNavigator.goToAndReplace(context, Loginactivity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 1) {
                  _logout();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Cerrar Sesión"),
                ),
              ],
            ),
          ],
          title: Center(
              child: Text("FibroPred",
                  style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.bold)))),
      body: pages[nowPage],
    );
  }
}
