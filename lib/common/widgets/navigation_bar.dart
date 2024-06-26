// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cj_flutter_riverpod_instagram_clone/common/constants/spacing.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/enums/color.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/provider/user/display_user_details_provider.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'package:cj_flutter_riverpod_instagram_clone/common/constants/circle_avatar_size.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/utils/icon_res.dart';
import 'package:cj_flutter_riverpod_instagram_clone/common/widgets/circle_avatar.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InstaNavigationBar extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;
  const InstaNavigationBar({
    Key? key,
    this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('InstaNavigationBar'));

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('smallNavigationShell'),
              builder: (_) => SizedBox(
                child: navigationShell,
              ),
            ),
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('mediumAndUpNavigationShell'),
              builder: (_) => SizedBox(
                child: navigationShell,
              ),
            ),
          },
        ),
        bottomNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('smallBottomNavigation'),
              builder: (_) => _CustomBottomNavigation(navigationShell),
            ),
          },
        ),
        primaryNavigation: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('mediumAndUpNavigationRail'),
              builder: (_) => _CustomNavigationRail(navigationShell),
            ),
          },
        ));
  }
}

class _CustomBottomNavigation extends ConsumerWidget {
  final StatefulNavigationShell? navigationShell;
  const _CustomBottomNavigation(this.navigationShell);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell!.currentIndex,
      onTap: (index) => _onDestinationSelected(index, ref),
      selectedItemColor: applyColor[InstaColor.alert],
      unselectedItemColor: applyColor[InstaColor.disabled],
      items: _bottomNavigationList(context),
      selectedFontSize: 0,
      unselectedFontSize: 0,
      iconSize: 0,
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationList(BuildContext context) {
    return [
      BottomNavigationBarItem(icon: _icon(IconRes.home), label: ''),
      BottomNavigationBarItem(icon: _icon(IconRes.notification), label: ''),
      BottomNavigationBarItem(icon: _icon(IconRes.newPost), label: ''),
      BottomNavigationBarItem(icon: _icon(IconRes.search, 2.8), label: ''),
      const BottomNavigationBarItem(icon: _ProfileIconWidget(), label: ''),
    ];
  }

  Widget _icon(String assetName, [double? scale]) => Image.asset(assetName,
      color: applyColor[InstaColor.tertiary], scale: scale ?? 2.5);

  void _onDestinationSelected(int index, WidgetRef ref) {
    navigationShell!.goBranch(
      index,
      initialLocation: index == navigationShell!.currentIndex,
    );
  }
}

class _ProfileIconWidget extends ConsumerWidget {
  const _ProfileIconWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(displayUserDetailsProvider);

    return user.when(
      data: (data) {
        return InstaCircleAvatar(
          image: data?.imageUrl ?? IconRes.testOnly,
          radius: InstaCircleAvatarSize.verySmall,
        );
      },
      error: (error, stackTrace) => const Text('there is an error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _CustomNavigationRail extends ConsumerWidget {
  final StatefulNavigationShell? navigationShell;
  const _CustomNavigationRail(this.navigationShell);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicWidth(
      child: Row(
        children: [
          NavigationRail(
            destinations: _sideNavigationList(context),
            selectedIndex: navigationShell!.currentIndex,
            onDestinationSelected: (int index) => _onDestinationSelected(index),
            labelType: NavigationRailLabelType.all,
            useIndicator: false,
            leading: Padding(
              padding: const EdgeInsets.only(
                  top: InstaSpacing.large, bottom: InstaSpacing.veryLarge * 2),
              child: _instacloneIcon(context),
            ),
            trailing: _profileIcon(context, ref),
          ),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell!.goBranch(
      index,
      initialLocation: index == navigationShell!.currentIndex,
    );
  }

  List<NavigationRailDestination> _sideNavigationList(BuildContext context) {
    return [
      NavigationRailDestination(
        icon: _icon(IconRes.home),
        label: const SizedBox(),
      ),
      NavigationRailDestination(
        icon: _icon(IconRes.notification),
        label: const SizedBox(),
      ),
      NavigationRailDestination(
        icon: _icon(IconRes.newPost),
        label: const SizedBox(),
      ),
      NavigationRailDestination(
        icon: _icon(IconRes.search),
        label: const SizedBox(),
      ),
      const NavigationRailDestination(
        disabled: true,
        icon: SizedBox(),
        label: SizedBox(),
      ),
    ];
  }

  Widget _profileIcon(BuildContext context, WidgetRef ref) {
    return const Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: InstaSpacing.large),
          child: InstaCircleAvatar(
            image: IconRes.testOnly,
            radius: InstaCircleAvatarSize.verySmall,
          ),
        ),
      ),
    );
  }

  Widget _instacloneIcon(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(InstaRouteNames.home),
      child: _icon(IconRes.instagram),
    );
  }

  Widget _icon(String assetName) => Image.asset(assetName,
      color: applyColor[InstaColor.tertiary], scale: 2.3);
}
