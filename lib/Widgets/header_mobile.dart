import 'package:flutter/material.dart';
import 'package:my_portfolio/Widgets/site_logo.dart';
import 'package:url_launcher/url_launcher.dart';  

class HeaderMobile extends StatelessWidget {
  const HeaderMobile({super.key, this.onMenuTap});
  final VoidCallback? onMenuTap;

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
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          SiteLogo(ontap: () {}),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: onMenuTap,
              icon: Icon(Icons.menu),
            ),
          ),
        ],
      ),
    );
  }
}
