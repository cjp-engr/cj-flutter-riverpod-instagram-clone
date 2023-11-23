import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/messaging_chat/widgets/status_details_widget.dart';

import 'package:flutter/material.dart';

class MessagingChatPage extends StatelessWidget {
  final String id;
  const MessagingChatPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return InstaAppBar(
      appBarTitle: const StatusDetailsWidget(),
      body: InstaText(text: 'Messaging Chat Body!!! - $id'),
    );
  }
}