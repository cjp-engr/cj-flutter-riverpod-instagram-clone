import 'package:cj_flutter_riverpod_instagram_clone/common/constants/font_size.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/color.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/provider/auth/auth_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/provider/user/display_user_details_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/routes/route_names.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/icon_res.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/app_bar.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/buttons.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/alert_dialog.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    _settingsListener(context, ref);
    return InstaAppBar(
      appBarTitle: const _AppBarWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Column(
            children: [
              _buildSignOut(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignOut() {
    final signOutState = ref.watch(authProvider);
    return signOutState.isLoading
        ? const CircularProgressIndicator()
        : PrimaryButton(
            color: InstaColor.primary,
            text: 'Log out',
            onPressed: () {
              signOutState.maybeWhen(
                orElse: () => _submit(ref),
                loading: null,
              );
            },
          );
  }

  void _submit(WidgetRef ref) {
    ref.invalidate(displayUserDetailsProvider);
    ref.read(authProvider.notifier).signout();
  }

  void _settingsListener(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      authProvider,
      (prev, next) {
        next.whenOrNull(
          skipLoadingOnRefresh: false,
          error: (e, st) {
            showAlertDialog(
              context,
              title: e.toString(),
              buttonCancelText: 'OK',
            );
          },
        );
      },
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SecondaryButton(
          assetName: IconRes.back,
          scale: 4,
          onPressed: () => context.goNamed(InstaRouteNames.profile),
        ),
        const SizedBox(width: InstaSpacing.verySmall),
        const InstaText(
          text: 'Settings',
          fontSize: InstaFontSize.large,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
