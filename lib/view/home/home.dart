import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/font_size.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/home/widgets/home_highlights.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/home/widgets/home_likes_comments.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/home/widgets/home_post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InstaAppBar(
      appBarTitle: const InstaText(
        text: 'Instaclone',
        fontWeight: FontWeight.w900,
        fontSize: InstaFontSize.veryLarge,
      ),
      body: TapRegion(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: InstaSpacing.verySmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHighlights(),
              SizedBox(height: InstaSpacing.medium),
              HomePost(),
              SizedBox(height: InstaSpacing.medium),
              HomeLikesComments(),
            ],
          ),
        ),
      ),
    );

    // return InstaAppBar(
    //   appBarTitle: const InstaText(
    //     text: 'Instaclone',
    //     fontWeight: FontWeight.w900,
    //     fontSize: InstaFontSize.veryLarge,
    //   ),
    //   body: TapRegion(
    //     onTapOutside: (event) => FocusScope.of(context).unfocus(),
    //     child: const Padding(
    //       padding: EdgeInsets.symmetric(horizontal: InstaSpacing.verySmall),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           HomeHighlights(),
    //           SizedBox(height: InstaSpacing.medium),
    //           HomePost(),
    //           SizedBox(height: InstaSpacing.medium),
    //           HomeLikesComments(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
