// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cj_flutter_riverpod_instagram_clone/common/provider/user/display_user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/color.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/provider/image/add_images_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/routes/route_names.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/build_context_ext.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/icon_res.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/alert_dialog.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text_field.dart';
import 'package:cj_flutter_riverpod_instagram_clone/model/image/image_details.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/mobile/widgets/added_media_mobile_widget.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/provider/add_post_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/widgets/select_dialog_widget.dart';

class AddPostWidget extends ConsumerStatefulWidget {
  const AddPostWidget({super.key});

  @override
  ConsumerState<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends ConsumerState<AddPostWidget> {
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addPostProvider);
    _addPostListener();
    return InstaAppBar(
      appBarActions: [
        _buildPostButton(),
      ],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(InstaSpacing.small),
            child: state.mediaFileList?.isNotEmpty ?? false
                ? _buildDescription()
                : const _NoImageWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildPostButton() {
    final postState = ref.watch(addImagesProvider);
    return postState.maybeWhen(
      orElse: () => InkWell(
        onTap: _submit,
        child: InstaText(
          text: 'Post',
          color: applyColor[InstaColor.secondary],
        ),
      ),
      loading: () => CircularProgressIndicator(
        color: applyColor[InstaColor.secondary],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddedMediaMobileWidget(),
        const SizedBox(height: InstaSpacing.verySmall),
        InstaTextField(
          label: 'Write Something',
          maxLines: 4,
          controller: _descriptionController,
          onChanged: (value) {
            _descriptionController.text = value;
          },
        )
      ],
    );
  }

  void _addPostListener() {
    ref.listen<AsyncValue<void>>(
      addImagesProvider,
      (prev, next) {
        next.whenOrNull(
          data: (data) {
            context.goNamed(InstaRouteNames.home);
          },
          error: (e, st) {
            showAlertDialog(
              context,
              title: e.toString(),
              buttonCancelText: 'OK',
            );
          },
          loading: () => const CircularProgressIndicator(),
        );
      },
    );
  }

  void _submit() {
    final images = ref.watch(addPostProvider).mediaFileList;
    final userName =
        ref.watch(displayUserDetailsProvider).asData!.value?.userName;
    final path = <String>[];
    if (images?.isNotEmpty ?? false) {
      for (var i = 0; i < images!.length; i++) {
        path.add(images[i].path);
      }
    }

    ref.read(addImagesProvider.notifier).addImages(
          ImageDetails(
            userName: userName,
            images: path,
            location: 'Philippines',
            description: _descriptionController.text.trim(),
            comments: [
              'Hardcoded comments only!!! 0',
              'Hardcoded comments only!!! 1',
              'Hardcoded comments only!!! 2',
              'Hardcoded comments only!!! 3',
            ],
          ),
        );
  }
}

class _NoImageWidget extends StatelessWidget {
  const _NoImageWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSelectDialog(context, title: 'Select to upload'),
      child: Container(
        width: double.infinity,
        height: context.screenHeight / 2.5,
        color: applyColor[InstaColor.transparent],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconRes.emptyGallery,
              color: applyColor[InstaColor.disabled],
              scale: 0.9,
            ),
            const SizedBox(height: InstaSpacing.medium),
            InstaText(
              text: 'Pick an image or video',
              color: applyColor[InstaColor.disabled],
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
