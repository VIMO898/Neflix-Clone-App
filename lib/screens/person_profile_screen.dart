import 'dart:developer';

import 'package:app/constants/enums.dart';
import 'package:app/models/general/external_links_model.dart';
import 'package:app/models/movies/movie_overview_model.dart';
import 'package:app/models/people/person_details_model.dart';
import 'package:app/models/shows/tv_show_overview_model.dart';
import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/screens/skeletons/person_profile_screen_skeleton.dart';
import 'package:app/widgets/detailed_media/media_heading_text.dart';
import 'package:app/widgets/general/expandable_text.dart';
import 'package:app/widgets/general/styled_card.dart';
import 'package:app/widgets/person_profile/person_info_card_grid_view.dart';
import 'package:app/widgets/person_profile/person_profile_app_bar.dart';
import 'package:app/widgets/person_profile/person_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/tmdb_exception.dart';
import '../widgets/general/centered_message.dart';
import '../widgets/person_profile/media_tile_expandable_list_view.dart';

class PersonProfileScreen extends ConsumerStatefulWidget {
  final int personId;
  const PersonProfileScreen({super.key, required this.personId});

  @override
  ConsumerState<PersonProfileScreen> createState() =>
      _PersonProfileScreenState();
}

class _PersonProfileScreenState extends ConsumerState<PersonProfileScreen> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _hasError = false;
  TmdbException? _tmdbException;
  PersonDetailsModel? _personDetails;
  List<MovieOverviewModel>? _personMovieCredits;
  List<TvShowOverviewModel>? _personTvShowCredits;
  ExternalLinksModel? _personSocialMediaHandles;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final repo = ref.read(tmdbRepoProvider);
    final personId = widget.personId;
    setState(() => _isLoading = true);
    try {
      final futures = [
        repo.getPersonDetails(personId),
        repo.getPersonMovieCredits(personId),
        repo.getPersonTvShowCredits(personId),
        repo.getPersonExternalLinks(personId),
      ];
      final futureResponses = await Future.wait(futures);
      _personDetails = futureResponses[0] as PersonDetailsModel;
      _personMovieCredits = futureResponses[1] as List<MovieOverviewModel>;
      _personTvShowCredits = futureResponses[2] as List<TvShowOverviewModel>;
      _personSocialMediaHandles = futureResponses[3] as ExternalLinksModel;
      _isLoading = false;
      setState(() {});
    } on TmdbException catch (e) {
      log(e.toString());
      _isLoading = false;
      _hasError = true;
      _tmdbException = e;
      setState(() {});
    } catch (e) {
      log(e.toString());
      _isLoading = false;
      _hasError = true;
      _tmdbException = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? PersonProfileScreenSkeleton()
        : Scaffold(
            appBar: PersonProfileAppBar(
              scrollController: _scrollController,
              personDetails: _personDetails,
            ),
            body: _tmdbException != null || _hasError
                ? _buildErrorMessage()
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PersonProfileHeader(
                          personDetails: _personDetails!,
                          socialMediaHandles: _personSocialMediaHandles!,
                        ),
                        PersonInfoCardGridView(personDetails: _personDetails!),
                        MediaHeadingText(
                          'Biography',
                          padding: const EdgeInsets.only(top: 20, bottom: 14),
                        ),
                        StyledCard(
                          child: ExpandableText(
                            _personDetails!.biography.isEmpty
                                ? "We don't have a biography for ${_personDetails!.name}."
                                : _personDetails!.biography,
                            maxLines: 12,
                          ),
                        ),
                        if (_personMovieCredits!.isNotEmpty)
                          MediaTileExpandableListView(
                            type: AllMediaType.movies,
                            title: 'Movies (${_personMovieCredits!.length})',
                            mediaList: _personMovieCredits!,
                          ),
                        if (_personTvShowCredits!.isNotEmpty)
                          MediaTileExpandableListView(
                            type: AllMediaType.tvShows,
                            title: 'TV Shows (${_personTvShowCredits!.length})',
                            mediaList: _personTvShowCredits!,
                          ),
                      ],
                    ),
                  ),
          );
  }

  CenteredMessage _buildErrorMessage() {
    return CenteredMessage(
      hideIcon: true,
      title: _tmdbException?.statusCode?.toString() ?? '404',
      subtitle:
          _tmdbException?.statusMessage ??
          'Something went wrong, please check your internet connection status',
    );
  }
}
