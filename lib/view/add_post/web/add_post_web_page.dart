import 'package:cj_flutter_riverpod_instagram_clone/common/constants/font_size.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/provider/add_post_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/web/widgets/added_media_web_widget.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/web/widgets/no_added_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPostWebPage extends ConsumerWidget {
  const AddPostWebPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaFileList = ref.watch(addPostProvider).mediaFileList;
    final droppedFiles = ref.watch(addPostProvider).droppedImages;
    return InstaAppBar(
        appBarTitle: Breakpoints.mediumAndUp.isActive(context)
            ? const SizedBox()
            : InstaText(
                text: AppLocalizations.of(context)!.appTitle,
                fontSize: InstaFontSize.veryLarge,
                fontWeight: FontWeight.bold,
              ),
        body: mediaFileList != null || droppedFiles != null
            ? const AddedMediaWebWidget()
            : const NoAddedMediaWidget());
  }
}
