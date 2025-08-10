import 'package:app/widgets/person_profile/skeletons/person_info_card_skeleton.dart';
import 'package:flutter/material.dart';

class PersonInfoCardGridViewSkeleton extends StatelessWidget {
  const PersonInfoCardGridViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 382,
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 175,
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 12),
        itemBuilder: (context, index) => PersonInfoCardSkeleton(),
      ),
    );
  }
}
