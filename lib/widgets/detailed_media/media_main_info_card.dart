import 'package:app/constants/enums.dart';
import 'package:app/widgets/general/styled_card.dart';
import 'package:flutter/material.dart';

import '../../models/movies/movie_details_model.dart';
import '../../models/shows/tv_show_details_model.dart';
import '../../utils/runtime_formatter.dart';
import '../../utils/us_currency_formatter.dart';

class MediaMainInfoCard extends StatelessWidget {
  final ExploreMediaType mediaType;
  final dynamic mediaDetails;
  const MediaMainInfoCard({
    super.key,
    required this.mediaType,
    required this.mediaDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String popularity = mediaDetails.popularity.toInt().toString();
    final String productionCompanies = mediaDetails.productionCompanies
        .map((c) => c.name)
        .join(', ');
    final String status = mediaDetails.status;
    // movie-specific properties
    String? runtime;
    String? budget;
    String? revenue;
    String? releasedDate;
    // tv show-specific properties
    String? firstAirDate;
    String? lastAirDate;
    String? tvShowtype;
    String? averageEpisodeRuntime;
    int? totalSeasons;

    switch (mediaType) {
      case ExploreMediaType.movies:
        final movieDetails = mediaDetails as MovieDetailsModel;
        runtime = formatRuntime(movieDetails.runtime);
        releasedDate = movieDetails.releaseDate;
        runtime = movieDetails.runtime > 0
            ? formatRuntime(movieDetails.runtime)
            : null;
        budget = movieDetails.budget > 0
            ? formatUSCurrency(movieDetails.budget)
            : null;
        revenue = movieDetails.revenue > 0
            ? formatUSCurrency(movieDetails.revenue)
            : null;

      case ExploreMediaType.tvShows:
        final tvShowDetails = mediaDetails as TvShowDetailsModel;
        firstAirDate = tvShowDetails.firstAirDate;
        lastAirDate = tvShowDetails.lastAirDate;
        tvShowtype = tvShowDetails.type;
        averageEpisodeRuntime = tvShowDetails.episodeRunTime.isNotEmpty
            ? formatRuntime(tvShowDetails.episodeRunTime.first)
            : null;
        totalSeasons = tvShowDetails.numberOfSeasons;
    }
    return StyledCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainCardInfo(
            theme,
            icon: Icons.offline_bolt_outlined,
            label: 'Status',
            value: status,
          ),
          if (tvShowtype != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.category_outlined,
              label: 'TV Show Type',
              value: tvShowtype,
            ),
          if (runtime != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.schedule,
              label: 'Runtime',
              value: runtime,
            ),
          if (firstAirDate != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.today_outlined,
              label: 'First Air Date',
              value: firstAirDate,
            ),
          if (lastAirDate != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.event_available_outlined,
              label: 'Last Air Date',
              value: lastAirDate,
            ),
          if (totalSeasons != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.local_activity_outlined,
              label: 'Seasons',
              value: totalSeasons > 1
                  ? '$totalSeasons seasons'
                  : '$totalSeasons season',
            ),
          if (averageEpisodeRuntime != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.hourglass_top_outlined,
              label: 'Average Episode Runtime',
              value: averageEpisodeRuntime,
            ),
          if (releasedDate != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.calendar_month,
              label: 'Release Date',
              value: releasedDate,
            ),
          _buildMainCardInfo(
            theme,
            icon: Icons.trending_up,
            label: 'Popularity',
            value: popularity,
          ),
          if (budget != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.receipt_long_outlined,
              label: 'Budget',
              value: budget,
            ),
          if (revenue != null)
            _buildMainCardInfo(
              theme,
              icon: Icons.payment_outlined,
              label: 'Revenue',
              value: revenue,
            ),
          _buildMainCardInfo(
            theme,
            icon: Icons.apartment,
            label: 'Production',
            value: productionCompanies,
          ),
        ],
      ),
    );
  }

  Padding _buildMainCardInfo(
    ThemeData theme, {
    bool putBottomPadding = true,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: putBottomPadding
          ? const EdgeInsets.only(bottom: 20)
          : EdgeInsets.zero,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Row(
              children: [
                Icon(icon, color: theme.primaryColor, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    // softWrap: true,
                    // overflow: TextOverflow.visible,
                    style: textTheme.bodySmall?.copyWith(
                      height: 1.3,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            flex: 4,
            child: Text(
              value,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
