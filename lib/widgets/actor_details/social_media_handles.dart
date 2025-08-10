import 'package:app/models/general/external_links_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../general/label_icon_button.dart';
import '../general/text_heading_medium.dart';

class SocialMediaHandles extends StatelessWidget {
  final ExternalLinksModel socialMediaHandles;
  const SocialMediaHandles({required this.socialMediaHandles, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextHeadingMedium('Social Media'),
          const SizedBox(height: 8),
          LabelIconButton(
              label: 'Facebook', icon: Icons.facebook, onTap: () {}),
          LabelIconButton(
              label: 'Instagram',
              icon: FontAwesomeIcons.instagram,
              onTap: () {}),
          LabelIconButton(
              label: 'Tiktok', icon: FontAwesomeIcons.tiktok, onTap: () {}),
          LabelIconButton(
              label: 'Twitter', icon: FontAwesomeIcons.twitter, onTap: () {}),
          LabelIconButton(
              label: 'Youtube', icon: FontAwesomeIcons.youtube, onTap: () {}),
          LabelIconButton(
              label: 'IMDB', icon: FontAwesomeIcons.imdb, onTap: () {}),
        ],
      ),
    );
  }
}
