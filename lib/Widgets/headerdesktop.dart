// header_desktop.dart

import 'package:flutter/material.dart';
import 'package:my_portfolio/Util/nav_page.dart';
import 'package:my_portfolio/Widgets/site_logo.dart';
import 'package:url_launcher/url_launcher.dart';  // Import url_launcher

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({super.key});

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
    return Container(
      child: SizedBox(
        height: 60,
        width: double.maxFinite,
        child: Row(
          children: [
            // Site logo
            SiteLogo(),

            Spacer(),

            // Navigation Buttons (using navItems)
            for (int i = 0; i < navItems.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    // Launch the URL when a button is pressed
                    _launchURL(navItems[i]['url']);
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(navItems[i]['title']),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
