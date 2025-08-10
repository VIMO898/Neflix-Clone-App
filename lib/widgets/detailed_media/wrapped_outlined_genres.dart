import 'package:flutter/material.dart';

import '../general/outlined_label.dart';

class WrappedOutlinedGenres extends StatelessWidget {
  final List<String> genres;
  const WrappedOutlinedGenres({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Wrap(
          direction: Axis.horizontal,
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            genres.length,
            (index) {
              final genre = genres[index];
              return OutlinedLabel(genre);
            },
          )),
    );
  }
}
