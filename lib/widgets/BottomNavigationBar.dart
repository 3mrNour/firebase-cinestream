import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';


class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      tabSize: 48,

      tabBarColor: Color.fromARGB(255, 48, 35, 77),
      labels: ["Home", "Search", "Watchlist", "Profile"],
      initialSelectedTab: "Home",
      tabIconColor: Color.fromARGB(255, 255, 255, 255),
      tabSelectedColor: Color.fromARGB(255, 255, 196, 0),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: .bold,
        
      ),
      tabIconSize: 22,
      tabIconSelectedSize: 24,
      onTabItemSelected: (int value) {
        print(value);
      },
      icons: const [
        CupertinoIcons.home,
        CupertinoIcons.search,
        CupertinoIcons.plus_app_fill,
        CupertinoIcons.person,
      ],
      labelAlwaysVisible: true,
      // useSafeArea: true,
      tabBarHeight: 60,
      tabIconSelectedColor: Colors.deepPurple,
    );
  }
}
