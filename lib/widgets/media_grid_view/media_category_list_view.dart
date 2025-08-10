import 'package:app/extensions/string_extension.dart';
import 'package:app/widgets/general/outlined_label.dart';
import 'package:flutter/material.dart';

import '../../constants/enums.dart';

class MediaCategoryListView extends StatelessWidget {
  final AllMediaType type;
  final Enum selectedCategory;
  final void Function(Enum category) onUpdateCategory;
  const MediaCategoryListView({
    super.key,
    required this.type,
    required this.selectedCategory,
    required this.onUpdateCategory,
  });

  List<Widget> get categories => switch (type) {
    AllMediaType.movies => List.generate(MovieCategory.values.length, (index) {
      final currCategory = MovieCategory.values[index];
      return OutlinedLabel(
        currCategory.name.readable(),
        selected: currCategory == selectedCategory,
        margin: const EdgeInsets.only(right: 12),
        onTap: () => onUpdateCategory(currCategory),
      );
    }),
    AllMediaType.tvShows => List.generate(TvShowCategory.values.length, (
      index,
    ) {
      final currCategory = TvShowCategory.values[index];
      return OutlinedLabel(
        currCategory.name.readable(),
        selected: currCategory == selectedCategory,
        margin: const EdgeInsets.only(right: 12),
        onTap: () => onUpdateCategory(currCategory),
      );
    }),
    AllMediaType.people => List.generate(PersonCategory.values.length, (index) {
      final currCategory = PersonCategory.values[index];
      return OutlinedLabel(
        currCategory.name.readable(),
        selected: currCategory == selectedCategory,
        margin: const EdgeInsets.only(right: 12),
        onTap: () => onUpdateCategory(currCategory),
      );
    }),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return categories[index];
        },
      ),
    );
  }
}
