import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloggerScreen extends StatefulWidget {
  const BloggerScreen({super.key});

  @override
  State<BloggerScreen> createState() => _BloggerScreenState();
}

class _BloggerScreenState extends State<BloggerScreen> {
  @override
  void initState() {
    super.initState();
    // Adding a small delay before launching Instagram
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), _launchInstagram);
    });
  }

  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse('https://flutterBangla.blogspot.com');

    if (await canLaunchUrl(url)) {
      // Launch Instagram externally
      await launchUrl(url, mode: LaunchMode.externalApplication);

      // Add delay before popping the screen
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted) {
            Navigator.pop(context); // Close the current screen
          }
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Blogger.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
