import 'package:app/widgets/person_profile/skeletons/person_info_card_grid_view_skeleton.dart';
import 'package:app/widgets/person_profile/skeletons/person_profile_header_skeleton.dart';
import 'package:flutter/material.dart';

import '../../utils/navigator_shortcuts.dart';

class PersonProfileScreenSkeleton extends StatelessWidget {
  const PersonProfileScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavHelper.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
        child: Column(
          children: [
            PersonProfileHeaderSkeleton(),
            PersonInfoCardGridViewSkeleton(),
          ],
        ),
      ),
    );
  }
}
