import 'package:app/models/shows/tv_show_episode__model.dart';
import 'package:app/screens/detailed_tv_show_episode_screen.dart';
import 'package:app/utils/format_to_readable_date_str.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/utils/runtime_formatter.dart';
import 'package:app/widgets/tv_show_season_episode_list_view/skeletons/tv_show_episode_tile_skeleton.dart';
import 'package:flutter/material.dart';

class TvShowEpisodeTile extends StatelessWidget {
  final bool isLoading;
  final TvShowEpisodeModel? episodeInfo;
  const TvShowEpisodeTile({
    super.key,
    this.isLoading = false,
    required this.episodeInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return TvShowEpisodeTileSkeleton();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final dividerStyles = BorderSide(width: 0.5, color: Colors.grey);
    final formattedAirDate = episodeInfo!.airDate != null
        ? formatToReadableDate(episodeInfo!.airDate!)
        : null;
    final formattedRuntime = formatRuntime(episodeInfo!.runtime ?? 0);
    final seasonNumber = episodeInfo!.seasonNumber.toString().padLeft(2, '0');
    final episodeNumber = episodeInfo!.episodeNumber.toString().padLeft(2, '0');
    // final episodeImg = getTmdbImageUrl(
    //     type: ImageType.still,
    //     size: ImageSize.w185,
    //     filePath: episodeInfo.stillPath ?? '');
    return InkWell(
      onTap: () => NavHelper.push(
        context,
        DetailedTvShowEpisodeScreen(episodeInfo: episodeInfo!),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(border: Border(bottom: dividerStyles)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'S${seasonNumber}E$episodeNumber ',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: episodeInfo!.name),
                ],
                style: textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 6.5),
              child: Text(
                formattedAirDate != null
                    ? '$formattedAirDate • $formattedRuntime'
                    : formattedRuntime,
                style: textTheme.bodySmall,
              ),
            ),
            Text(
              episodeInfo!.overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
