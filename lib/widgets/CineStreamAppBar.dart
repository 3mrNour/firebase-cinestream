import 'package:cinestream/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CineStreamAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CineStreamAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      actionsPadding: .symmetric(horizontal: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset('assets/images/Logo_horizontal.png', width: 180),
      toolbarHeight: 100,
      actions: [
        Text('👋', style: TextStyle(fontSize: 28)),
        SizedBox(width: 5),
        Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Hi",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: .bold,
              ),
            ),
            SizedBox(width: 5),
            Text(
              (userProvider.userModel?.firstName.trim() ?? ''),
              style: TextStyle(
                fontSize: 22,
                color: Colors.amber,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
