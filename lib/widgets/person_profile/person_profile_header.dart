import 'package:app/models/general/external_links_model.dart';
import 'package:app/models/people/person_details_model.dart';
import 'package:app/widgets/general/placeholder_image.dart';
import 'package:flutter/material.dart';

import '../general/styled_chip.dart';
import 'person_social_media_handles.dart';

class PersonProfileHeader extends StatelessWidget {
  final PersonDetailsModel personDetails;
  final ExternalLinksModel socialMediaHandles;
  const PersonProfileHeader({
    super.key,
    required this.personDetails,
    required this.socialMediaHandles,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPersonImg(
          personDetails.profilePath == null
              ? null
              : 'https://image.tmdb.org/t/p/w780/${personDetails.profilePath}',
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            personDetails.name,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StyledChip(
          text: personDetails.knownForDepartment,
          color: Colors.blue.shade800,
          textColor: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
        ),
        PersonSocialMediaHandles(socialMediaHandles: socialMediaHandles),
      ],
    );
  }

  Widget _buildPersonImg(String? personImgSrc) {
    return Container(
      width: 150,
      height: 220,
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: personImgSrc == null
            ? PlaceholderImage()
            : Image.network(
                personImgSrc,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    PlaceholderImage(),
              ),
      ),
    );
  }
}
