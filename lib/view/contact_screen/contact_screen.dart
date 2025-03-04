import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/constants/images.dart';
import '../../model/model.dart';
import '../../global/widget/global_app_bar.dart';
import '../../global/widget/global_text.dart';
import '../custom_drawer_screen.dart';
import 'components/contact_widget.dart';
import 'components/social_media_widget.dart';
import '../social_media_screen/blogger_screen.dart';
import '../social_media_screen/facebook_screen.dart';
import '../social_media_screen/instagram_screen.dart';
import '../social_media_screen/linkedin_screen.dart';
import '../social_media_screen/pinterest_screen.dart';
import '../social_media_screen/threads_screen.dart';
import '../social_media_screen/tiktok_screen.dart';
import '../social_media_screen/tumblr_screen.dart';
import '../social_media_screen/twitter_screen.dart';
import '../social_media_screen/youtube_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.bloggerInc, text: 'Blogger'),
    GlobalMenuModel(img: Images.facebookInc, text: 'Facebook'),
    GlobalMenuModel(img: Images.linkedInInc, text: 'Linkedin'),
    GlobalMenuModel(img: Images.instagramInc, text: 'Instagram'),
    GlobalMenuModel(img: Images.threadsInc, text: 'Threads'),
    GlobalMenuModel(img: Images.twitterInc, text: 'Twitter'),
    GlobalMenuModel(img: Images.tikTokInc, text: 'TikTok'),
    GlobalMenuModel(img: Images.youTubeInc, text: 'YouTube'),
    GlobalMenuModel(img: Images.pinterestInc, text: 'Pinterest'),
    GlobalMenuModel(img: Images.tumblrInc, text: 'Tumblr'),
    // GlobalMenuModel(img: Images.vimeoInc, text: 'Vimeo'),
    // GlobalMenuModel(img: Images.googleInc, text: 'Business'),
    // GlobalMenuModel(img: Images.whatsAppInc, text: 'WhatsApp'),
    // GlobalMenuModel(img: Images.telegramInc, text: 'Telegram'),
    // GlobalMenuModel(img: Images.weChatInc, text: 'WeChat'),
    // GlobalMenuModel(img: Images.redditInc, text: 'Reddit'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: GlobalAppBar(
          title: 'Dart & Flutter Tutorial',
          notiOnTap: () {},
        ),
      ),
      key: drawerKey,
      drawer: const CustomDrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              //const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorRes.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorRes.primaryColor, width: .3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ContactDetailsWidget(
                      name: "Dart & Flutter Tutorial",
                      address: "Dhaka, Bangladesh.",
                      email: "info@flutterBangla.com",
                      phone: "+88 01738 00 00 00",
                      call: "Call",
                      sms: "SMS",
                      mail: "e-Mail",
                      map: "Map",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const GlobalText(
                str: "Don’t Miss Out – Follow Us for Updates",
                color: ColorRes.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),

              GridView.builder(
                  itemCount: menuItem.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 55),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const BloggerScreen());
                            break;
                          case 1:
                            Get.to(() => const FacebookScreen());
                            break;
                          case 2:
                            Get.to(() => const LinkedInScreen());
                            break;
                          case 3:
                            Get.to(() => const InstagramScreen());
                            break;
                          case 4:
                            Get.to(() => const ThreadsScreen());
                            break;
                          case 5:
                            Get.to(() => const TwitterScreen());
                            break;
                          case 6:
                            Get.to(() => const TikTokScreen());
                            break;
                          case 7:
                            Get.to(() => const YouTubeScreen());
                            break;
                          case 8:
                            Get.to(() => const PinterestScreen());
                            break;
                          case 9:
                            Get.to(() => const TumblrScreen());
                            break;
                          // case 10:
                          //   Get.to(() => const GoogleScreen());
                          //   break;
                          // case 7:
                          //   Get.to(() => const VimeoScreen());
                          //   break;
                          // case 12:
                          //   Get.to(() => const WhatsAppScreen());
                          //   break;
                          // case 13:
                          //   Get.to(() => const TelegramScreen());
                          //   break;
                          //   case 14:
                          //     Get.to(() => const WeChatScreen());
                          //     break;
                          // case 15:
                          //   Get.to(() => const RedditScreen());
                          //   break;
                        }
                      },
                      child: SocialMediaWidget(
                        height: 24,
                        width: 24,
                        imagePath: menuItem[index].img,
                        text: menuItem[index].text,
                      ),
                    );
                  }),

              //const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
