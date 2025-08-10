import 'package:flutter/material.dart';

import '../widgets/legal_doc_texts/bullet_point.dart';
import '../widgets/legal_doc_texts/paragraph.dart';
import '../widgets/legal_doc_texts/section_header.dart';
import '../widgets/legal_doc_texts/section_title.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle('Effective Date: 20, 10, 2024'),
            SizedBox(height: 16),
            Paragraph(
                'Welcome to our app! By accessing or using this app, you agree to comply with and be bound by these Terms of Service ("Terms"). Please read them carefully.'),
            SizedBox(height: 24),
            SectionHeader('1. Acceptance of Terms'),
            Paragraph(
                'By using the app, you confirm that you have read, understood, and agreed to these Terms and our Privacy Policy. If you do not agree, you must discontinue use of the app.'),
            SizedBox(height: 24),
            SectionHeader('2. Use of the App'),
            Paragraph(
                '[Your App Name] is intended for personal, non-commercial use. You agree:'),
            BulletPoint(
                'Not to misuse the app, including attempting unauthorized access.'),
            BulletPoint(
                'Not to reverse engineer, decompile, or extract source code.'),
            BulletPoint(
                'To comply with all applicable laws while using the app.'),
            SizedBox(height: 24),
            SectionHeader('3. Content and Intellectual Property'),
            Paragraph(
                'Movie and TV show information is provided by TMDb. All rights belong to the original creators and studios. [Your App Name] does not claim ownership over this content. TMDb\'s API Terms of Use apply.'),
            SizedBox(height: 24),
            SectionHeader('4. Account Linking (If Applicable)'),
            Paragraph(
                'If the app allows linking to a TMDb account, you are responsible for your login credentials and must comply with TMDb\'s terms.'),
            SizedBox(height: 24),
            SectionHeader('5. Limitation of Liability'),
            Paragraph(
                'The app is provided "as is" without warranties of any kind. We do not guarantee the accuracy, completeness, or reliability of data. We are not responsible for damages arising from the use or misuse of the app.'),
            SizedBox(height: 24),
            SectionHeader('6. Third-Party Services'),
            Paragraph(
                'Our app may contain links to external services like TMDb. We are not responsible for the availability or content of external services.'),
            SizedBox(height: 24),
            SectionHeader('7. Termination'),
            Paragraph(
                'We reserve the right to suspend or terminate access to the app for users who violate these Terms.'),
            SizedBox(height: 24),
            SectionHeader('8. Changes to Terms'),
            Paragraph(
                'We may modify these Terms at any time. Continued use of the app after updates signifies your agreement to the updated Terms.'),
            SizedBox(height: 24),
            SectionHeader('9. Contact Us'),
            Paragraph(
                'If you have questions or concerns about these Terms, please contact us at [your email address].'),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
