import 'package:cinestream/providers/navBar_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrystalBottomBar extends StatefulWidget {
  const CrystalBottomBar({super.key});

  @override
  State<CrystalBottomBar> createState() => _CrystalBottomBarState();
}

class _CrystalBottomBarState extends State<CrystalBottomBar> {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 5, right: 5),
      child: CrystalNavigationBar(
        borderRadius: 30,
        backgroundColor: const Color.fromARGB(96, 45, 22, 85),
        paddingR: .all(5),
        currentIndex: navProvider.selectedIndex,
        indicatorColor: Colors.amber,
        unselectedItemColor: Color(0x99FFFFFF),
        borderWidth: 1,
        outlineBorderColor: const Color.fromARGB(110, 255, 230, 0),
        onTap: (p0) => navProvider.changeIndex(p0),
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            selectedColor: Colors.amber,
          ),
          CrystalNavigationBarItem(
            icon: Icons.search,
            unselectedIcon: Icons.search_outlined,
            selectedColor: Colors.amber,
          ),
          CrystalNavigationBarItem(
            icon: Icons.favorite,
            unselectedIcon: Icons.favorite_border,
            selectedColor: Colors.amber,
          ),
          CrystalNavigationBarItem(
            icon: Icons.person,
            unselectedIcon: Icons.person_outline,
            selectedColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
