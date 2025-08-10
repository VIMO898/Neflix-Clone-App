import 'package:app/constants/enums.dart';
import 'package:app/models/people/cast_model.dart';
import 'package:app/models/shows/tv_show_episode__model.dart';
import 'package:app/screens/person_profile_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/utils/runtime_formatter.dart';
import 'package:app/utils/tmdb_image_url.dart';
import 'package:app/widgets/detailed_media/media_heading_content.dart';
import 'package:app/widgets/general/media_card.dart';
import 'package:flutter/material.dart';

import '../widgets/detailed_media/media_heading_text.dart';
import '../widgets/general/expandable_text.dart';
import '../widgets/general/styled_card.dart';

class DetailedTvShowEpisodeScreen extends StatelessWidget {
  final TvShowEpisodeModel episodeInfo;
  const DetailedTvShowEpisodeScreen({super.key, required this.episodeInfo});

  @override
  Widget build(BuildContext context) {
    final seasonNumber = episodeInfo.seasonNumber;
    final episodeNumber = episodeInfo.episodeNumber;
    final displayCrewMembers =
        episodeInfo.crew != null && episodeInfo.crew!.isNotEmpty;
    final displayGuestStars =
        episodeInfo.guestStars != null && episodeInfo.guestStars!.isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: Text('Episode')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                MediaHeadingContent(
                  title: episodeInfo.name,
                  smallerTitle: true,
                  imgUrl: getTmdbImageUrl(
                    type: ImageType.still,
                    size: ImageSize.original,
                    filePath: episodeInfo.stillPath ?? '',
                  ),
                  highlights: [
                    'S${seasonNumber}E$episodeNumber',
                    formatRuntime(episodeInfo.runtime ?? 0),
                  ],
                  voteCount: episodeInfo.voteCount,
                  voteAverage: episodeInfo.voteAverage,
                ),
                MediaHeadingText(
                  'Overview',
                  padding: const EdgeInsets.only(top: 6, bottom: 14),
                ),
                StyledCard(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: ExpandableText(episodeInfo.overview, maxLines: 12),
                ),
              ]),
            ),
            if (displayCrewMembers)
              SliverToBoxAdapter(child: MediaHeadingText('Crew')),
            if (displayCrewMembers) _buildMembers(episodeInfo.crew!),
            if (displayGuestStars)
              SliverToBoxAdapter(child: MediaHeadingText('Guest Stars')),
            if (displayGuestStars) _buildMembers(episodeInfo.guestStars!),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildMembers(List<CastModel> members) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 22),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 195,
        ),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final currMember = members[index];
          return MediaCard(
            // margin: cardMargin,
            imgSrc: getTmdbImageUrl(
              type: ImageType.profile,
              size: ImageSize.w185,
              filePath: currMember.profilePath ?? '',
            ),
            title: currMember.name,
            subtitle: currMember.department ?? currMember.character,
            size: const Size(120, 150),
            onTap: () => NavHelper.push(
              context,
              PersonProfileScreen(personId: currMember.id),
            ),
            // onLongPress: () => handleMediaCardLongPress(p),
          );
        },
      ),
    );
  }
}
