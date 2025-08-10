import 'package:app/screens/faq_screen.dart';
import 'package:app/screens/feedback_screen.dart';
import 'package:app/screens/privacy_policy_screen.dart';
import 'package:app/screens/terms_of_service_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/settings/categorized_settings.dart';
import 'package:app/widgets/settings/setting_tile.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  void _navigateToFAQsScreen(BuildContext context) {
    NavHelper.push(context, FaqScreen());
  }

  void _navigateToPrivacyPolicyScreen(BuildContext context) {
    NavHelper.push(context, PrivacyPolicyScreen());
  }

  void _navigateToTermsOfServiceScreen(BuildContext context) {
    NavHelper.push(context, TermsOfServiceScreen());
  }

  void _navigateToFeedbackScreen(BuildContext context) {
    NavHelper.push(context, FeedbackScreen());
  }

  @override
  Widget build(BuildContext context) {
    return CategorizedSettings(title: 'Help & Support', tiles: [
      SettingTile(
          leadingIcon: Icons.help_outline,
          title: 'FAQs',
          onTap: () => _navigateToFAQsScreen(context)),
      SettingTile(
          leadingIcon: Icons.policy_outlined,
          title: 'Privacy Policy',
          onTap: () => _navigateToPrivacyPolicyScreen(context)),
      SettingTile(
          leadingIcon: Icons.gavel_outlined,
          title: 'Terms of Service',
          onTap: () => _navigateToTermsOfServiceScreen(context)),
      SettingTile(
          leadingIcon: Icons.feedback_outlined,
          title: 'Feedback',
          onTap: () => _navigateToFeedbackScreen(context)),
    ]);
  }
}
