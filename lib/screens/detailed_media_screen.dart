import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/exceptions/tmdb_exception.dart';
import 'package:app/models/general/genre_model.dart';
import 'package:app/models/general/tmdb_result.dart';
import 'package:app/models/movies/movie_details_model.dart';
import 'package:app/models/people/credits_model.dart';
import 'package:app/models/shows/tv_show_details_model.dart';
import 'package:app/models/shows/tv_show_episode__model.dart';
import 'package:app/models/shows/tv_show_season_model.dart';
import 'package:app/models/watch_providers/flatrate_model.dart';
import 'package:app/providers/general/supported_languages_provider_sorted.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/screens/skeletons/detailed_media_screen_skeleton.dart';
import 'package:app/utils/media_details_to_media_overview.dart';
import 'package:app/utils/tmdb_image_url.dart';
import 'package:app/widgets/detailed_media/additional_info.dart';
import 'package:app/widgets/detailed_media/detailed_media_app_bar.dart';
import 'package:app/widgets/detailed_media/media_main_info_card.dart';
import 'package:app/widgets/detailed_media/media_videos_and_photos.dart';
import 'package:app/widgets/detailed_media/sypnosis.dart';
import 'package:app/widgets/detailed_media/watch_provider_grid_style_list_view.dart';
import 'package:app/widgets/discover/horizontal_media_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/media/categorized_media_image_model.dart';
import '../models/media/media_video_model.dart';
import '../widgets/detailed_media/media_action_buttons.dart';
import '../widgets/detailed_media/media_heading_content.dart';
import '../widgets/detailed_media/tv_show_season_list_view.dart';
import '../widgets/detailed_media/wrapped_outlined_genres.dart';
import '../widgets/general/centered_message.dart';
import '../widgets/detailed_media/horizontal_credit_list_view.dart';

class DetailedMediaScreen extends ConsumerStatefulWidget {
  final int mediaId;
  final ExploreMediaType mediaType;
  const DetailedMediaScreen({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });

  @override
  ConsumerState<DetailedMediaScreen> createState() =>
      _DetailedMediaScreenState();
}

class _DetailedMediaScreenState extends ConsumerState<DetailedMediaScreen> {
  late ScrollController _scrollController;
  Object? _mediaDetails;
  CreditsModel? _mediaCredits;
  List<MediaVideoModel>? _mediaVideos;
  CategorizedMediaImageModel? _mediaCategorizedImages;
  List<Object>? _similarMedia;
  List<Object>? _recommendedMedia;
  List<FlatrateModel>? _watchProviders;
  bool _isLoading = false;
  bool _hasError = false;
  TmdbException? _tmdbException;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadMediaData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMediaData() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(tmdbRepoProvider);
      final mediaId = widget.mediaId;
      final mediaType = widget.mediaType;
      late List<Future> futures;
      switch (widget.mediaType) {
        case ExploreMediaType.movies:
          futures = [
            repo.getMovieDetails(mediaId),
            repo.getMediaCredits(type: mediaType, id: mediaId),
            repo.getMediaImages(type: mediaType, id: mediaId),
            repo.getMediaVideos(type: mediaType, id: mediaId),
            repo.getSimilarMovies(mediaId),
            repo.getMovieRecommendations(mediaId),
            repo.getWatchProvider(type: mediaType, mediaId: mediaId),
          ];
        case ExploreMediaType.tvShows:
          futures = [
            repo.getTvShowDetails(mediaId),
            repo.getMediaCredits(type: mediaType, id: mediaId),
            repo.getMediaImages(type: mediaType, id: mediaId),
            repo.getMediaVideos(type: mediaType, id: mediaId),
            repo.getSimilarTvShows(mediaId),
            repo.getTvShowRecommendations(mediaId),
            repo.getWatchProvider(type: mediaType, mediaId: mediaId),
          ];
      }

      final futureResponses = await Future.wait(futures);
      _mediaDetails = futureResponses[0];
      _mediaCredits = futureResponses[1] as CreditsModel;
      _mediaCategorizedImages =
          futureResponses[2] as CategorizedMediaImageModel;
      _mediaVideos = futureResponses[3] as List<MediaVideoModel>;
      _similarMedia = (futureResponses[4] as TmdbResult<Object>).results;
      _recommendedMedia = (futureResponses[5] as TmdbResult<Object>).results;
      _watchProviders = (futureResponses[6] as List<FlatrateModel>);
      _isLoading = false;
      _hasError = false;
      _tmdbException = null;
      setState(() {});
    } on TmdbException catch (e) {
      _isLoading = false;
      _tmdbException = e;
      _hasError = true;
      log(e.toString());
      setState(() {});
    } catch (e) {
      _isLoading = false;
      _tmdbException = null;
      _hasError = true;
      log(e.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _isLoading
        ? DetailedMediaScreenSkeleton()
        : Scaffold(
            appBar: DetailedMediaAppBar(
              title: appBarTitle,
              scrollController: _scrollController,
            ),
            body: _tmdbException != null || _hasError
                ? _buildErrorMessage()
                : _buildPageContent(theme),
          );
  }

  String get appBarTitle => _mediaDetails != null
      ? widget.mediaType == ExploreMediaType.movies
            ? (_mediaDetails as dynamic).title
            : (_mediaDetails as dynamic).name
      : '';

  Widget _buildPageContent(ThemeData theme) {
    final supportedLanguages = ref.watch(supportedLanguagesProvider);

    final mediaDetails = _mediaDetails as dynamic;

    // propertie common in both movie & tv show details
    final String? posterPath = mediaDetails.posterPath != null
        ? "https://image.tmdb.org/t/p/w780${mediaDetails.posterPath}"
        : null;
    final String sypnosis = mediaDetails.overview;
    final genres = (mediaDetails.genres as List<GenreModel>)
        .map((g) => g.name)
        .toList();
    final String? spokenLanguages = mediaDetails.spokenLanguages.isNotEmpty
        ? mediaDetails.spokenLanguages.map((l) => l.englishName).join(', ')
        : null;
    final String? productionCountries =
        mediaDetails.productionCountries.isNotEmpty
        ? mediaDetails.productionCountries.map((c) => c.name).join(', ')
        : null;
    final originalLanguages = supportedLanguages.where(
      (l) => l.iso6391 == mediaDetails.originalLanguage,
    );
    final String originalLanguage = originalLanguages.isNotEmpty
        ? originalLanguages.first.englishName
        : mediaDetails.originalLanguage;
    final double rating = mediaDetails.voteAverage;
    final int votes = mediaDetails.voteCount;

    late String title;
    late String mediaReleasedYear;
    List<TvShowSeasonModel>? tvShowSeasons;
    TvShowEpisodeModel? tvShowNextEpisodeToAir;
    TvShowEpisodeModel? tvShowLastEpisodeToAir;
    switch (widget.mediaType) {
      case ExploreMediaType.movies:
        final movieDetails = _mediaDetails as MovieDetailsModel;
        title = movieDetails.title;
        mediaReleasedYear = movieDetails.releaseDate.split('-').first;
      case ExploreMediaType.tvShows:
        final tvShowDetails = _mediaDetails as TvShowDetailsModel;
        title = tvShowDetails.name;
        mediaReleasedYear = tvShowDetails.firstAirDate.split('-').first;
        tvShowSeasons = tvShowDetails.seasons;
        tvShowLastEpisodeToAir = tvShowDetails.lastEpisodeToAir;
        tvShowNextEpisodeToAir = tvShowDetails.nextEpisodeToAir;
    }
    final mediaTypeAsStr = widget.mediaType == ExploreMediaType.movies
        ? 'Movie'
        : 'TV';
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: posterPath != null
          ? BoxDecoration(
              // color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(posterPath),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            )
          : null,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MediaHeadingContent(
              title: title,
              highlights: [mediaReleasedYear, mediaTypeAsStr, originalLanguage],
              imgUrl: getTmdbImageUrl(
                type: ImageType.backdrop,
                size: ImageSize.w780,
                filePath: mediaDetails?.backdropPath ?? '',
              ),
              voteAverage: rating,
              voteCount: votes,
            ),
            WrappedOutlinedGenres(genres: genres),
            MediaActionButtons(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              mediaType: widget.mediaType,
              mediaId: widget.mediaId,
              mediaOverview: converMediaDetailsToMediaOverview(
                widget.mediaType,
                _mediaDetails,
              ),
              // onCollection: () {},
            ),
            if (sypnosis.isNotEmpty) Sypnosis(sypnosis),
            MediaMainInfoCard(
              mediaType: widget.mediaType,
              mediaDetails: _mediaDetails,
            ),
            // tv show list of seasons
            if (tvShowSeasons != null)
              TvShowSeasonListView(
                tvShowId: mediaDetails.id,
                tvShowSeasons: tvShowSeasons,
              ),
            if (_mediaVideos!.isNotEmpty &&
                _mediaCategorizedImages!.backdrops.isNotEmpty)
              MediaVideosAndPhotos(
                videos: _mediaVideos!,
                categorizedImages: _mediaCategorizedImages!,
              ),
            HorizontalCreditListView(credits: _mediaCredits!),
            if (spokenLanguages != null || productionCountries != null)
              AdditionalInfo(
                spokenLanguages: spokenLanguages,
                productCountries: productionCountries,
              ),
            if (_watchProviders!.isNotEmpty)
              WatchProviderGridStyleListView(
                mediaId: widget.mediaId,
                type: widget.mediaType,
                providers: _watchProviders!,
              ),

            // HorizontalCastList(castList: []),
            // const HorizontalMediaListView(title: 'Seasons', itemCount: 10,  itemBuilder: ),
            if (_recommendedMedia!.isNotEmpty)
              HorizontalMediaListView(
                noPadding: true,
                mediaType: widget.mediaType == ExploreMediaType.movies
                    ? AllMediaType.movies
                    : AllMediaType.tvShows,
                title: 'Recommendations',
                mediaList: _recommendedMedia,
              ),

            if (_similarMedia!.isNotEmpty)
              HorizontalMediaListView(
                noPadding: true,
                mediaType: widget.mediaType == ExploreMediaType.movies
                    ? AllMediaType.movies
                    : AllMediaType.tvShows,
                title: 'Similar',
                mediaList: _similarMedia,
              ),
          ],
        ),
      ),
    );
  }

  CenteredMessage _buildErrorMessage() {
    return CenteredMessage(
      iconColor: Colors.redAccent,
      title: _tmdbException?.statusCode?.toString() ?? '404',
      subtitle:
          _tmdbException?.statusMessage ??
          'Something went wrong, please check your internet connection status',
    );
  }
}
