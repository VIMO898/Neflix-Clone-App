import 'package:app/widgets/person_profile/skeletons/circular_icon_button_skeleton.dart';
import 'package:flutter/material.dart';

class PersonSocialMediaHandlesSkeleton extends StatelessWidget {
  const PersonSocialMediaHandlesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 12,
        children: [
          CircularIconButtonSkeleton(),
          CircularIconButtonSkeleton(),
          CircularIconButtonSkeleton(),
        ],
      ),
    );
  }
}
