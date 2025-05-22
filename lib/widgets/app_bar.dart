import 'package:flutter/material.dart';

class MyTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Recipe Book'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu_book),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('This is some random snackbar')));
          },
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
