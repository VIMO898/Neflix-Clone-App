import 'package:app/widgets/person_profile/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/enums.dart';
import '../../models/general/external_links_model.dart';
import '../../utils/snackbar_helper.dart';

class PersonSocialMediaHandles extends StatelessWidget {
  final ExternalLinksModel socialMediaHandles;
  const PersonSocialMediaHandles({super.key, required this.socialMediaHandles});

  String getUrl(SocialPlatform platform, String id) {
    switch (platform) {
      case SocialPlatform.freebaseMid:
        return 'https://freebase.com/m/$id';
      case SocialPlatform.freebaseId:
        return 'https://freebase.com/$id';
      case SocialPlatform.imdb:
        return 'https://www.imdb.com/title/$id/';
      case SocialPlatform.tvrage:
        return 'https://www.tvmaze.com/shows/$id';
      case SocialPlatform.wikidata:
        return 'https://www.wikidata.org/wiki/$id';
      case SocialPlatform.facebook:
        return 'https://www.facebook.com/$id';
      case SocialPlatform.instagram:
        return 'https://www.instagram.com/$id';
      case SocialPlatform.tiktok:
        return 'https://www.tiktok.com/@$id';
      case SocialPlatform.twitter:
        return 'https://twitter.com/$id';
      case SocialPlatform.youtube:
        return 'https://www.youtube.com/$id';
    }
  }

  Future<void> _launchSocialSite(
    BuildContext context, {
    required SocialPlatform socialPlatform,
    required String id,
    required String errorMessage,
  }) async {
    final url = getUrl(socialPlatform, id);
    final uri = Uri.parse(url);
    final unableToLauch = !await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (unableToLauch) {
      SnackBarHelper.show(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        spacing: 12,
        children: [
          if (socialMediaHandles.facebookId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.facebook,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.facebook,
                id: socialMediaHandles.facebookId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
          if (socialMediaHandles.instagramId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.instagram,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.instagram,
                id: socialMediaHandles.instagramId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
          if (socialMediaHandles.twitterId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.x,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.twitter,
                id: socialMediaHandles.twitterId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
          if (socialMediaHandles.tiktokId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.tiktok,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.tiktok,
                id: socialMediaHandles.tiktokId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
          if (socialMediaHandles.youtubeId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.youtube,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.youtube,
                id: socialMediaHandles.youtubeId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
          if (socialMediaHandles.wikidataId != null)
            CircularIconButton(
              icon: FontAwesomeIcons.wikipediaW,
              onTap: () => _launchSocialSite(
                context,
                socialPlatform: SocialPlatform.wikidata,
                id: socialMediaHandles.wikidataId!,
                errorMessage: 'Unable to launch this url',
              ),
            ),
        ],
      ),
    );
  }
}
