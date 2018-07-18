import 'package:flutter/material.dart';
import 'package:ryozanpark/screens/dryerScreen.dart';
import 'package:ryozanpark/screens/laundryScreen.dart';
import 'package:ryozanpark/screens/mainScreen.dart';
import 'package:ryozanpark/screens/profileScreen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          new LaundryScreen(),
          new DryerScreen(),
          new ProfileScreen(),
        ],
      ),
      bottomNavigationBar: new Material(
        type: MaterialType.card,
        color: Colors.blue[200],
        child: new TabBar(
          isScrollable: false,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(
                Icons.local_laundry_service,
                color: Colors.white,
              ),
              text: 'ランドリー',
            ),
            new Tab(
              icon: new Icon(
                Icons.brightness_5,
                color: Colors.white,
              ),
              text: '乾燥機',
            ),
            new Tab(
              icon: new Icon(
                Icons.music_note,
                color: Colors.white,
              ),
              text: 'Music Room',
            ),
          ],
        ),
      ),
    );
  }
}
