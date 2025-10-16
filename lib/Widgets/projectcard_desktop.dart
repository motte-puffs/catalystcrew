import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/Util/colors.dart';

class DesktopProjectSection extends StatelessWidget {
  final List<Map<String, dynamic>> projects;

  const DesktopProjectSection({super.key, required this.projects});

  // Function to launch the URL
  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      throw 'URL is null or empty';
    }
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);  // Correct launch method
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.scaffoldBg,
      padding: const EdgeInsets.only(top: 10, bottom: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: projects
            .map(
              (project) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProjectCard(
                  title: project['title'],
                  description: project['description'],
                  tags: List<String>.from(project['tags']),
                  url: project['url'],  // Passing the URL
                  launchURL: _launchURL,  // Passing the _launchURL callback
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String? url;  // Nullable URL
  final Future<void> Function(String?) launchURL;  // Nullable URL callback

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.url,
    required this.launchURL,  // Accept the callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Only attempt to launch if URL is not null or empty
        if (url != null && url!.isNotEmpty) {
          launchURL(url);  // Call the passed callback with the nullable URL
        } else {
          print("No URL provided for $title");
        }
      },
      child: Container(
        width: 450,
        height: 190,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'monospace',
                  height: 1.4,
                  fontSize: 15,
                ),
              ),
            ),

            // Divider
            Container(
              height: 1,
              color: Colors.white12,
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),

            // Tags
            Wrap(
              spacing: 8,
              children: tags
                  .map(
                    (tag) => Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
