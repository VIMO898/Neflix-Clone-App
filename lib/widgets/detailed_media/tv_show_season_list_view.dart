import 'package:app/screens/tv_show_season_episode_list_view_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:flutter/widgets.dart';

import '../../constants/enums.dart';
import '../../models/shows/tv_show_season_model.dart';
import '../../utils/format_to_readable_date_str.dart';
import '../../utils/tmdb_image_url.dart';
import '../general/media_tile.dart';
import 'media_heading_text.dart';

class TvShowSeasonListView extends StatelessWidget {
  final int tvShowId;
  final List<TvShowSeasonModel> tvShowSeasons;
  const TvShowSeasonListView({
    super.key,
    required this.tvShowId,
    required this.tvShowSeasons,
  });

  void _handleNavToTvShowEpisodeScreen(
      BuildContext context, TvShowSeasonModel seasonInfo) {
    NavHelper.push(
        context,
        TvShowSeasonEpisodeListViewScreen(
            tvShowId: tvShowId, seasonNumber: seasonInfo.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MediaHeadingText('Seasons'),
        SizedBox(
          height: tvShowSeasons.length * 120,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tvShowSeasons.length,
              itemBuilder: (context, index) {
                final season = tvShowSeasons[index];
                return MediaTile(
                    imgSrc: getTmdbImageUrl(
                        type: ImageType.poster,
                        size: ImageSize.w185,
                        filePath: season.posterPath ?? ''),
                    title: season.name,
                    subtitle:
                        '🌟 ${season.voteAverage.toStringAsFixed(1)} • ${formatToReadableDate(season.airDate)}',
                    genres: '${season.episodeCount} Episodes',
                    onTap: () =>
                        _handleNavToTvShowEpisodeScreen(context, season));
              }),
        ),
      ],
    );
  }
}
