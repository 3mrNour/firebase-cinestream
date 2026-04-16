import 'dart:async';

import 'package:cinestream/screens/HomeScreen.dart';
import 'package:cinestream/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final bool isLogin = prefs.getBool('isLogin') ?? false;
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isLogin ? HomeScreen() : LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff291E40), Color(0xff413066), Color(0xff120D1D)],
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: .center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logo-white-en.png'),
                    width: 200,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Color(0xffFFCD30),
                  strokeWidth: 10,
                ),
              ],
            ),
            Positioned(
              bottom: -150,

              child: RotatedBox(
                quarterTurns: 3,
                child: Opacity(
                  opacity: 0.05,
                  child: Image(
                    image: AssetImage('assets/images/CineStream.png'),
                    width: 800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xff291E40),
    );
  }
}
