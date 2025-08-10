// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:app/widgets/discover/media_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/constants/enums.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';

import '../../exceptions/tmdb_exception.dart';
import '../general/centered_message.dart';
import '../general/slider_navigating_dots.dart';

class MediaCarouselSlider extends ConsumerStatefulWidget {
  const MediaCarouselSlider({super.key});

  @override
  ConsumerState<MediaCarouselSlider> createState() =>
      _MediaCarouselSliderState();
}

class _MediaCarouselSliderState extends ConsumerState<MediaCarouselSlider> {
  final PageController _controller = PageController(viewportFraction: 0.98);
  int _currentPage = 0;
  bool _isLoading = false;
  TmdbException? _tmdbException;
  bool _hasError = false;
  // this list will contain both movie & tv show overview data
  List<Object>? _trendingMedia;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadTrendingMedia();
  }

  void _keepSliding() {
    if (_timer != null || _trendingMedia == null) {
      return;
    }
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _handlePageUpdate((_currentPage + 1) % _trendingMedia!.length),
    );
  }

  Future<void> _loadTrendingMedia() async {
    final tmdbRepo = ref.read(tmdbRepoProvider);
    try {
      // set widget fields
      _isLoading = true;
      _hasError = false;
      _tmdbException = null;
      _trendingMedia = null;
      setState(() {});
      // get trending media
      final trendingMovieFuture = tmdbRepo.getTrendingMovies();
      final trendingTvShowFuture = tmdbRepo.getTrendingTvShows();
      final trendingMediaResponse = await Future.wait([
        trendingMovieFuture,
        trendingTvShowFuture,
      ]);
      List<MovieOverviewModel> trendingMovies =
          (trendingMediaResponse[0] as TmdbResult<MovieOverviewModel>).results;
      List<TvShowOverviewModel> trendingTvShows =
          (trendingMediaResponse[1] as TmdbResult<TvShowOverviewModel>).results;
      // only take three items from trending lists
      trendingMovies = trendingMovies.take(3).toList();
      trendingTvShows = trendingTvShows.take(3).toList();
      // add both media types to the list & shuffle it
      _trendingMedia = [...trendingMovies, ...trendingTvShows]..shuffle();
      _isLoading = false;
      _keepSliding();
      setState(() {});
    } on TmdbException catch (e) {
      _isLoading = false;
      _hasError = true;
      _tmdbException = e;
      setState(() {});
    } catch (e) {
      _hasError = true;
      _tmdbException = null;
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _handlePageUpdate(int newPageIndex) {
    _currentPage = newPageIndex;
    _controller.animateToPage(
      newPageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final mqs = MediaQuery.of(context).size;
    return Container(
      height: 330,
      margin: const EdgeInsets.only(top: 6),
      width: double.infinity,
      child: _tmdbException != null || _hasError
          ? CenteredMessage(
              hideIcon: true,
              title: _tmdbException?.statusCode?.toString() ?? '404',
              subtitle:
                  _tmdbException?.statusMessage ??
                  'Something went wrong, please check your internet connection status',
            )
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _isLoading ? 3 : _trendingMedia!.length,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      final media = !_isLoading ? _trendingMedia![index] : null;
                      final mediaType = !_isLoading
                          ? media is MovieOverviewModel
                                ? ExploreMediaType.movies
                                : ExploreMediaType.tvShows
                          : null;

                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_controller.position.haveDimensions) {
                            value = (_controller.page! - index).abs();
                            value = (1 - (value * 0.3)).clamp(0.0, 1.0);
                          }

                          double fadeValue = 1.0;
                          if (_controller.position.haveDimensions) {
                            fadeValue = (1 - (_controller.page! - index).abs())
                                .clamp(0.5, 1.0);
                          }
                          return Opacity(
                            opacity: fadeValue,
                            child: Transform.translate(
                              offset: Offset(
                                30 * ((_controller.page ?? 0) - index),
                                0,
                              ),
                              child: Transform.scale(
                                scale: value,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: MediaSlide(
                          isLoading: _isLoading,
                          type: mediaType,
                          mediaOverview: media,
                        ),
                      );
                    },
                  ),
                ),
                SliderNavigatingDots(
                  isLoading: _isLoading,
                  currPageIndex: _currentPage,
                  onDotTap: _handlePageUpdate,
                  totalPages: _trendingMedia?.length,
                ),
              ],
            ),
    );
  }
}
