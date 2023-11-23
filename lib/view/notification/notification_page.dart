import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/font_size.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/notification/widgets/list_widget.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/notification/widgets/suggested_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InstaAppBar(
      appBarTitle: const InstaText(
        text: 'Notifications',
        fontSize: InstaFontSize.large,
        fontWeight: FontWeight.bold,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: InstaSpacing.verySmall),
        child: Column(
          children: [
            ListWidget(),
            SizedBox(height: InstaSpacing.medium),
            SuggestedWidget(),
          ],
        ),
      ),
    );
  }
}