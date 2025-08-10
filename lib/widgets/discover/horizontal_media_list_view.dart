import 'package:flutter/material.dart';

import '../../constants/enums.dart';
import '../../utils/all_media_type_card_list.dart';

class HorizontalMediaListView extends StatelessWidget {
  final AllMediaType mediaType;
  final String title;
  final List<Object>? mediaList;
  final VoidCallback? onMore;
  final bool noPadding;
  const HorizontalMediaListView({
    super.key,
    required this.mediaType,
    required this.title,
    required this.mediaList,
    this.onMore,
    this.noPadding = false,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final cards = allMediaTypeCardList(
      context,
      type: mediaType,
      cardSize: const Size(90, 140),
      cardMargin: const EdgeInsets.only(right: 12),
      mediaList: mediaList!,
    );
    return Container(
      margin: const EdgeInsets.only(top: 26),
      height: 235,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: noPadding
                ? EdgeInsets.zero
                : const EdgeInsets.only(left: 8, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (onMore != null)
                  GestureDetector(
                    onTap: onMore,
                    child: Icon(Icons.chevron_right, size: 30),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final mediaCard = cards[index];
                return mediaCard;
              },
            ),
          ),
        ],
      ),
    );
  }
}
