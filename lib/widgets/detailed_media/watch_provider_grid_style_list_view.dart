import 'package:app/constants/enums.dart';
import 'package:app/models/watch_providers/flatrate_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/snackbar_helper.dart';
import '../general/full_width_elevated_button.dart';
import 'media_heading_text.dart';

class WatchProviderGridStyleListView extends StatelessWidget {
  final ExploreMediaType type;
  final int mediaId;
  final List<FlatrateModel> providers;

  const WatchProviderGridStyleListView({
    super.key,
    required this.mediaId,
    required this.type,
    required this.providers,
  });

  Future<void> _handleViewWatchOption(BuildContext context) async {
    final mediaName = switch (type) {
      ExploreMediaType.movies => 'movie',
      ExploreMediaType.tvShows => 'tv',
    };
    final url = 'https://www.themoviedb.org/$mediaName/$mediaId';
    final uri = Uri.parse(url);
    final unableToLauch = !await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (unableToLauch) {
      SnackBarHelper.show(context, 'Unable to view watch options');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textBodyLarge = textTheme.labelLarge?.copyWith(
      color: colorScheme.primary,
    );
    // Determine how many vertical columns (each with 3 items) needed
    final int columnCount = (providers.length / 3).ceil();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediaHeadingText(
          'Where to Watch',
          padding: const EdgeInsets.only(top: 8, bottom: 8),
        ),
        Text('Available on multiple platforms', style: textBodyLarge),
        const SizedBox(height: 12),
        SizedBox(
          height: 185, // Adjust based on item height * 3
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: columnCount,
            itemBuilder: (context, colIndex) {
              final int startIndex = colIndex * 3;
              final children = <Widget>[];

              for (int i = 0; i < 3; i++) {
                final itemIndex = startIndex + i;
                if (itemIndex < providers.length) {
                  final provider = providers[itemIndex];
                  children.add(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w92${provider.logoPath}',
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Text(provider.providerName, style: textBodyLarge),
                        ],
                      ),
                    ),
                  );
                }
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            },
          ),
        ),
        FullWidthElevatedButton(
          text: 'View All Watch Options',
          onTap: () => _handleViewWatchOption(context),
        ),
      ],
    );
  }
}
