import 'package:cinestream/firebase_options.dart';
import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/providers/search_provider.dart';
import 'package:cinestream/providers/favourite_provider.dart';
import 'package:cinestream/providers/user_provider.dart';
import 'package:cinestream/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cine Stream',
        theme: ThemeData(fontFamily: 'IBMPlexSansArabic'),
        home: SplashScreen(),
      ),
    );
  }
}
