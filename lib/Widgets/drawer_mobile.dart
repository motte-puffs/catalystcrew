// drawer_mobile.dart

import 'package:flutter/material.dart';
import 'package:my_portfolio/Util/nav_page.dart';
import 'package:url_launcher/url_launcher.dart';  // Import url_launcher

class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key});

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Close button
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          // List of navigation items with URLs
          for (int i = 0; i < navItems.length; i++)
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 30),
              title: Text(navItems[i]['title']),
              onTap: () {
                // Launch URL when a menu item is tapped
                _launchURL(navItems[i]['url']);
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
        ],
      ),
    );
  }
}
