import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/screens/FavouriteScreen.dart';
import 'package:cinestream/screens/MainScreen.dart';
import 'package:cinestream/screens/ProfileScreen.dart';
import 'package:cinestream/screens/SearchScreen.dart';
import 'package:cinestream/widgets/CrystalBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _appScreens = [
    const MainScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 29, 12, 68),
        body: Stack(
          children: [
            _appScreens[navProvider.selectedIndex],
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: const CrystalBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
