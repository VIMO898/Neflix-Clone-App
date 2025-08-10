import 'package:app/constants/enums.dart';
import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/utils/all_media_type_card_list.dart';
import 'package:app/widgets/general/centered_message.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LazyFutureHorizontalMediaListView extends StatefulWidget {
  final AllMediaType mediaType;
  final String title;
  final Future<TmdbResult> Function() mediaFutureBuilder;
  final VoidCallback? onMore;

  final bool noPadding;
  const LazyFutureHorizontalMediaListView({
    required this.mediaType,
    required this.title,
    required this.mediaFutureBuilder,
    this.onMore,
    this.noPadding = false,
    super.key,
  });

  @override
  State<LazyFutureHorizontalMediaListView> createState() =>
      _LazyFutureHorizontalMediaListViewState();
}

class _LazyFutureHorizontalMediaListViewState
    extends State<LazyFutureHorizontalMediaListView> {
  bool _hasFutureTriggered = false;
  Future<TmdbResult>? _future;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasFutureTriggered && info.visibleFraction > 0.01) {
      setState(() {
        _hasFutureTriggered = true;
        _future = widget.mediaFutureBuilder();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        margin: const EdgeInsets.only(top: 26),
        height: 235,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: widget.noPadding
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(left: 8, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (widget.onMore != null)
                    GestureDetector(
                      onTap: widget.onMore,
                      child: Icon(Icons.chevron_right, size: 30),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    final error = snapshot.error!;
                    if (error is TmdbException) {
                      return CenteredMessage(
                        hideIcon: true,
                        title: error.statusCode?.toString() ?? '404',
                        subtitle:
                            error.statusMessage ??
                            'Something went wrong, please check your internet connection status',
                      );
                    }
                    return CenteredMessage(
                      hideIcon: true,
                      title: '404',
                      subtitle:
                          'Something went wrong, please check your internet connection status',
                    );
                  }
                  final isLoading =
                      snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none;
                  final cards = allMediaTypeCardList(
                    context,
                    isLoading: isLoading,
                    cardMargin: const EdgeInsets.only(right: 12),
                    cardSize: const Size(90, 140),
                    type: widget.mediaType,
                    mediaList: !isLoading
                        ? snapshot.data!.results as List<Object>
                        : null,
                  );
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final mediaCard = cards[index];
                      return mediaCard;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
