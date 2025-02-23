import 'package:flutter/material.dart';

import '../constants/colors_resources.dart';

class SideberMenuWidget extends StatelessWidget {
  const SideberMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: ColorRes.title,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dart & Flutter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                 ],
              ),
            ),
          ),
          ListTile(
            title: const Text('About Us'),
            leading: const Icon(Icons.person_outline_rounded),
            onTap: () {
              //Get.to(() => const AboutScreen());
            },
          ),
          ListTile(
            title: const Text('Rate Our App'),
            leading: const Icon(Icons.star_rate_outlined),
            onTap: () {
              //Get.to(() => const CommitteeScreen());
            },
          ),
          ListTile(
            title: const Text('Send Feedback'),
            leading: const Icon(Icons.comment_bank_outlined),
            onTap: () {
              //Get.to(() => MemberScreen());
            },
          ),
          ListTile(
            title: const Text('Share Your Friends'),
            leading: const Icon(Icons.share_outlined),
            onTap: () {
              //Get.to(() => const GalleryScreen());
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            leading: const Icon(Icons.location_history_rounded),
            onTap: () {
              //Get.to(() => const ContactUsScreen());
            },
          ),
          const SizedBox(height: 5),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 1)),
            ),
            padding: const EdgeInsets.only(top: 5),
            child: const Text(
              'www.DartFlutter.com',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: const DrawerSocialMediaIconWidget(),
          // ),
        ],
      ),
    );
  }
}
