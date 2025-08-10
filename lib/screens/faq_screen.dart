import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFaqExpansionTile(textTheme, 'What is [Your App Name]?',
                '[Your App Name] is a mobile application that allows users to browse detailed information about movies and TV shows using data from The Movie Database (TMDb).'),
            _buildFaqExpansionTile(textTheme, 'Is [Your App Name] free to use?',
                'Yes, the app is completely free to use. However, it is intended for personal and non-commercial purposes.'),
            _buildFaqExpansionTile(
                textTheme,
                'Where does the information come from?',
                'All movie and TV show details, including posters, ratings, descriptions, and release dates, are sourced from TMDb’s public database.'),
            _buildFaqExpansionTile(textTheme, 'Do I need to create an account?',
                'No account creation is required to browse movie and TV show information. Some optional features (like saving favorites) may require device-based or external account linking in future updates.'),
            _buildFaqExpansionTile(
                textTheme,
                'Can I request specific movies or shows?',
                'Since we rely on TMDb’s public database, all available movies and TV shows listed there are accessible through the app. If a title is missing, it may not be available in TMDb yet.'),
            _buildFaqExpansionTile(
                textTheme,
                'Is my personal information collected?',
                '[Your App Name] respects your privacy. We do not collect personal identifiers. For more details, please refer to our Privacy Policy.'),
            _buildFaqExpansionTile(
                textTheme,
                'How often is the content updated?',
                'The app fetches the latest movie and TV show information from TMDb’s servers. Updates depend on TMDb’s database updates.'),
          ],
        ),
      ),
    );
  }

  ExpansionTile _buildFaqExpansionTile(
      TextTheme textTheme, String question, String answer) {
    return ExpansionTile(
      minTileHeight: 65,
      title: Text(
        question,
        style: textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Text(
          answer,
          style: textTheme.bodyLarge,
        )
      ],
    );
  }
}
