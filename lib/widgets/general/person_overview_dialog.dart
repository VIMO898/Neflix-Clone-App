import 'package:app/constants/enums.dart';
import 'package:app/models/general/known_for_model.dart';
import 'package:app/models/people/person_model.dart';
import 'package:app/screens/detailed_media_screen.dart';
import 'package:app/screens/person_profile_screen.dart';
import 'package:app/utils/gender_label.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/general/full_width_elevated_button.dart';
import 'package:app/widgets/general/media_card.dart';
import 'package:app/widgets/general/placeholder_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonOverviewDialog extends ConsumerWidget {
  final PersonModel personInfo;
  const PersonOverviewDialog({super.key, required this.personInfo});

  void _handleMediaCardTap(BuildContext context, KnownForModel knownFor) {
    switch (knownFor.mediaType) {
      case 'movie':
        NavHelper.pushReplacement(
          context,
          DetailedMediaScreen(
            mediaId: knownFor.id,
            mediaType: ExploreMediaType.movies,
          ),
        );
      case 'tv':
        NavHelper.pushReplacement(
          context,
          DetailedMediaScreen(
            mediaId: knownFor.id,
            mediaType: ExploreMediaType.tvShows,
          ),
        );
    }
  }

  void _showProfileImage(BuildContext context) {
    if (personInfo.profilePath == null) return;
    final imageProvider = Image.network(
      'https://image.tmdb.org/t/p/h632/${personInfo.profilePath}',
    ).image;

    showImageViewer(
      context,
      imageProvider,
      swipeDismissible: true,
      doubleTapZoomable: true,
    );
  }

  void _handleNavToPersonProfileScreen(BuildContext context) {
    NavHelper.pushReplacement(
      context,
      PersonProfileScreen(personId: personInfo.id),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final String? profilePath = personInfo.profilePath != null
        ? "https://image.tmdb.org/t/p/w500${personInfo.profilePath}"
        : null;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: theme.cardColor,
      elevation: 4,
      child: Stack(
        children: [
          Positioned(
            right: 8,
            top: 8,
            child: IconButton(
              onPressed: () => NavHelper.pop(context),
              icon: Icon(Icons.close),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => _showProfileImage(context),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: profilePath != null
                          ? CachedNetworkImageProvider(profilePath)
                          : null,
                      onBackgroundImageError: (exception, stackTrace) =>
                          PlaceholderImage(),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(personInfo.name, style: textTheme.headlineMedium),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconLabel(
                      theme,
                      icon: Icons.diversity_2_outlined,
                      label: 'Gender',
                      value: getGenderLabelAsString(personInfo.gender),
                    ),
                    _buildIconLabel(
                      theme,
                      icon: Icons.whatshot_outlined,
                      label: 'Popularity',
                      value: personInfo.popularity.toStringAsFixed(1),
                      isLast: personInfo.knownForDepartment == null,
                    ),
                    if (personInfo.knownForDepartment != null)
                      _buildIconLabel(
                        theme,
                        icon: Icons.domain_outlined,
                        label: 'Career',
                        value: personInfo.knownForDepartment!,
                        isLast: true,
                      ),
                  ],
                ),
                FullWidthElevatedButton(
                  text: 'View Profile',
                  onTap: () => _handleNavToPersonProfileScreen(context),
                ),
                if (personInfo.knownFor != null)
                  _buildKnownForMediaListView(textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnownForMediaListView(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
          child: Text('Known For', style: textTheme.titleLarge),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: personInfo.knownFor!.length,
            itemBuilder: (context, index) {
              final knownForMedia = personInfo.knownFor![index];
              final profilePath = knownForMedia.posterPath != null
                  ? 'https://image.tmdb.org/t/p/w185${knownForMedia.posterPath}'
                  : null;
              late String title;
              late String year;
              switch (knownForMedia.mediaType) {
                case 'movie':
                  title = knownForMedia.title!;
                  year = knownForMedia.releaseDate!.split('-').first;
                case 'tv':
                  title = knownForMedia.name!;
                  year = knownForMedia.firstAirDate!.split('-').first;
              }
              return MediaCard(
                size: Size(100, 155),
                margin: const EdgeInsets.only(right: 12),
                imgSrc: profilePath,
                title: title,
                subtitle: year,
                onTap: () => _handleMediaCardTap(context, knownForMedia),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIconLabel(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(right: BorderSide(width: 1.2, color: colorScheme.primary))
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 26),
          // const SizedBox(height: 4),
          Text(
            label,
            style: textTheme.titleLarge?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: textTheme.titleLarge?.copyWith(fontSize: 18)),
        ],
      ),
    );
  }
}
