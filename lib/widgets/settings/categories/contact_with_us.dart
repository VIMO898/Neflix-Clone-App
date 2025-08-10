import 'package:app/utils/snackbar_helper.dart';
import 'package:app/widgets/settings/categorized_settings.dart';
import 'package:app/widgets/settings/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({super.key});

  Future<void> _launchSocialSite(
      BuildContext context, String url, String errorMessage) async {
    final uri = Uri.parse(url);
    final unableToLauch =
        !await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (unableToLauch) {
      SnackBarHelper.show(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CategorizedSettings(title: 'Follow Us On', tiles: [
      SettingTile(
          leadingIcon: FontAwesomeIcons.facebook,
          title: 'Facebook',
          onTap: () => _launchSocialSite(
              context,
              'https://www.facebook.com/flutterdev',
              'Unable to open our Facebook page')),
      SettingTile(
          leadingIcon: FontAwesomeIcons.instagram,
          title: 'Instagram',
          onTap: () => _launchSocialSite(
              context,
              'https://www.instagram.com/flutter.dev',
              'Unable to open our Instagram account')),
      SettingTile(
          leadingIcon: FontAwesomeIcons.x,
          title: 'Twitter/X',
          onTap: () => _launchSocialSite(
              context,
              'https://twitter.com/flutterdev',
              'Unable to open our X account')),
    ]);
  }
}
