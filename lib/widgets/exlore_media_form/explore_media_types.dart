import 'package:app/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import '../../constants/enums.dart';
import '../general/outlined_label.dart';

class ExploreMediaTypes extends StatelessWidget {
  final ExploreMediaType mediaType;
  final void Function(ExploreMediaType selectedMediaType) onSelect;
  const ExploreMediaTypes({
    super.key,
    required this.mediaType,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final mediaTypes = ExploreMediaType.values;
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
            children: List.generate(
          mediaTypes.length,
          (index) {
            final currMediaType = mediaTypes[index];
            final isLastItem = (mediaTypes.length - 1) == index;
            return Expanded(
              child: OutlinedLabel(currMediaType.name.readable(),
                  margin:
                      isLastItem ? EdgeInsets.zero : EdgeInsets.only(right: 10),
                  selected: currMediaType.name == mediaType.name,
                  onTap: () => onSelect(currMediaType)),
            );
          },
        )),
      ),
    );
  }
}
