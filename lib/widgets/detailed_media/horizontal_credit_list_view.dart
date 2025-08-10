import 'package:app/models/people/cast_model.dart';
import 'package:app/models/people/credits_model.dart';
import 'package:app/screens/person_profile_screen.dart';
import 'package:app/utils/navigator_shortcuts.dart';
import 'package:app/widgets/detailed_media/media_heading_text.dart';
import 'package:flutter/material.dart';

import '../general/media_card.dart';

class HorizontalCreditListView extends StatelessWidget {
  final CreditsModel credits;
  const HorizontalCreditListView({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    final cast = credits.cast;
    final crew = credits.crew;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (cast.isNotEmpty) MediaHeadingText('Cast'),
        if (cast.isNotEmpty) _buildCreditListView(credits.cast),
        if (crew.isNotEmpty) MediaHeadingText('Crew'),
        if (crew.isNotEmpty) _buildCreditListView(credits.crew),
      ],
    );
  }

  Widget _buildCreditListView(List<CastModel> credits) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 204,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: credits.length,
        itemBuilder: (context, index) {
          final credit = credits[index];

          return MediaCard(
            onTap: () => NavHelper.push(
              context,
              PersonProfileScreen(personId: credit.id),
            ),
            margin: const EdgeInsets.only(right: 16),
            size: const Size(70, 120),
            imgBorderCircularRadius: 12,
            subtitleAlignment: Alignment.bottomCenter,
            title: credit.name,
            subtitle: credit.character ?? credit.department,
            imgSrc: credit.profilePath != null
                ? 'https://media.themoviedb.org/t/p/w154/${credit.profilePath}'
                : null,
          );
        },
      ),
    );
  }
}
