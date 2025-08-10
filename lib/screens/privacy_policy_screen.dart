import 'package:flutter/material.dart';

import '../widgets/legal_doc_texts/bullet_point.dart';
import '../widgets/legal_doc_texts/paragraph.dart';
import '../widgets/legal_doc_texts/section_header.dart';
import '../widgets/legal_doc_texts/section_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy & Policy')),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SectionTitle('Effective Date: 20, 10, 2024'),
            SizedBox(height: 16),
            Paragraph(
                'Thank you for choosing our app. We are committed to protecting your privacy and providing a safe user experience. This Privacy Policy describes how we collect, use, and safeguard your information when you use our application.'),
            SizedBox(height: 24),
            SectionHeader('1. Information We Collect'),
            Paragraph('We prioritize your privacy. Here\'s what we collect:'),
            BulletPoint(
                'Non-personal Information: We may automatically collect anonymous usage data to improve app functionality and user experience.'),
            BulletPoint(
                'Third-Party Data: The app retrieves movie and TV show information from The Movie Database (TMDb). No personal data is shared with TMDb.'),
            Paragraph(
                'We do NOT collect:\n- Personal identifiers (such as your name, email address, or phone number)\n- Payment or sensitive financial information'),
            SizedBox(height: 24),
            SectionHeader('2. How We Use Your Information'),
            Paragraph(
                'We use the collected information to deliver content, enhance performance, diagnose technical problems, and improve future versions. We do not sell, rent, or share your data with third parties for marketing purposes.'),
            SizedBox(height: 24),
            SectionHeader('3. Third-Party Services'),
            Paragraph(
                'Our app integrates services provided by TMDb. While we do not send your personal data to TMDb, their platform may collect limited information according to their own privacy practices.'),
            SizedBox(height: 24),
            SectionHeader('4. Data Security'),
            Paragraph(
                'We take reasonable administrative and technical measures to protect the information we collect. However, no security system is completely impenetrable.'),
            SizedBox(height: 24),
            SectionHeader('5. Your Choices'),
            Paragraph(
                'You can control app behaviors through your device settings. You can limit anonymous data collection by adjusting device privacy settings.'),
            SizedBox(height: 24),
            SectionHeader('6. Changes to This Policy'),
            Paragraph(
                'We may update this Privacy Policy. Continued use of the app after updates signifies acceptance of the new terms.'),
            SizedBox(height: 24),
            SectionHeader('7. Contact Us'),
            Paragraph(
                'For any questions regarding this Privacy Policy, please contact us at [your email address].'),
            SizedBox(height: 32),
          ])),
    );
  }
}
