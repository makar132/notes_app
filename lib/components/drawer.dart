import 'package:flutter/material.dart';
import 'package:notes_app/components/drawer_tile.dart';
import 'package:notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: Image.asset(
              "assets/note.png",
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 25,
          ),

          //notes
          DrawerTile(
            title: "Notes",
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          //settings
          DrawerTile(
            title: "Settings",
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
