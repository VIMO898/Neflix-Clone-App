import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/detailed_media/media_heading_content_skeleton.dart';
import 'package:app/widgets/detailed_media/skeletons/sypnosis_skeleton.dart';
import 'package:flutter/material.dart';

import '../../widgets/detailed_media/skeletons/media_action_buttons_skeleton.dart';
import '../../widgets/detailed_media/skeletons/wrapped_outlined_genres_skeleton.dart';

class DetailedMediaScreenSkeleton extends StatelessWidget {
  const DetailedMediaScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavHelper.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MediaHeadingContentSkeleton(),
            WrappedOutlinedGenresSkeleton(),
            MediaActionButtonsSkeleton(),
            SypnosisSkeleton(),
          ],
        ),
      ),
    );
  }
}
