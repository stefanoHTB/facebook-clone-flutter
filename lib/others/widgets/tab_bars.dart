import 'package:facebook_clone/features/reels/screens/reels_screen.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:flutter/material.dart';

class TabBars extends StatefulWidget {
  const TabBars({Key? key}) : super(key: key);

  @override
  State<TabBars> createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: SizedBox(
          height: 300,
          child: Scaffold(
            body: Column(
              children: const [
                TabBar(
                  indicatorColor: Colors.blue,
                  tabs: <Widget>[
                    Tab(
                      text: 'Stories',
                      //icon: Icon(Icons.cloud_outlined),
                    ),
                    Tab(
                      text: 'Reels',

                      // icon: Icon(Icons.beach_access_sharp),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Center(
                        child: Text("It's cloudy here"),
                      ),
                      ReelsScreen()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
