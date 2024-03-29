import 'package:cj_flutter_riverpod_instagram_clone/common/enums/color.dart';
import 'package:flutter/material.dart';

class ContentTaggedWidget extends StatelessWidget {
  const ContentTaggedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContentTagged();
  }

  Widget _buildContentTagged() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: applyColor[InstaColor.alert],
          alignment: Alignment.center,
          child: Text('Item $index'),
        );
      },
    );
  }
}
