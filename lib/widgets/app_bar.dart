import 'package:flutter/material.dart';

class MyTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Recipe Book'),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
