import 'package:app/models/people/person_details_model.dart';
import 'package:flutter/material.dart';

import 'person_info_card.dart';

class PersonInfoCardGridView extends StatelessWidget {
  final PersonDetailsModel personDetails;
  const PersonInfoCardGridView({super.key, required this.personDetails});

  @override
  Widget build(BuildContext context) {
    final cards = [
      PersonInfoCard(
          icon: Icons.work,
          label: 'Known For:',
          value: personDetails.knownForDepartment),
      if (personDetails.birthday != null)
        PersonInfoCard(
          icon: Icons.cake,
          label: 'Birthday',
          value: personDetails.birthday!,
        ),
      if (personDetails.placeOfBirth != null)
        PersonInfoCard(
            icon: Icons.person_pin_circle,
            label: 'Place of Birth:',
            value: personDetails.placeOfBirth!),
      PersonInfoCard(
          icon: Icons.star,
          label: 'Popularity',
          value: personDetails.popularity.toStringAsFixed(1)),
      PersonInfoCard(
          icon: Icons.badge,
          label: 'Also Known As:',
          value: personDetails.alsoKnownAs.join(', ')),
      if (personDetails.deathday != null)
        PersonInfoCard(
            icon: Icons.spa,
            label: 'Death Date:',
            value: personDetails.deathday!),
    ];
    return SizedBox(
      height: cards.length > 4 ? 564 : 382,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 175,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 12),
        // childAspectRatio: ,
        // gridDelegate:
        //     SliverGridDelegateWithFixedCrossAxisCount(
        //         mainAxisExtent: 160,
        //         crossAxisCount: 2,
        //         crossAxisSpacing: 8),
        children: cards,
      ),
    );
  }
}
