import 'dart:developer';

import 'package:app/providers/repositories/tmdb_repo_provider.dart';
import 'package:app/widgets/tv_show_season_episode_list_view/tv_show_episode_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/tmdb_exception.dart';
import '../widgets/general/centered_message.dart';

class TvShowSeasonEpisodeListViewScreen extends ConsumerWidget {
  final int tvShowId;
  final int seasonNumber;
  const TvShowSeasonEpisodeListViewScreen({
    super.key,
    required this.tvShowId,
    required this.seasonNumber,
  });

  @override
  Widget build(BuildContext context, ref) {
    final tmdbRepo = ref.watch(tmdbRepoProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Season $seasonNumber')),
      body: FutureBuilder(
        future: tmdbRepo.getTvShowSeasonEpisodes(
          tvShowId: tvShowId,
          seasonNumber: seasonNumber,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            log(error.toString());
            if (error is TmdbException) {
              return CenteredMessage(
                iconColor: Colors.redAccent,
                title: error.statusCode != null
                    ? error.statusCode!.toString()
                    : '404',
                subtitle:
                    error.statusMessage ??
                    'Something went wrong, please check your internet connection status',
              );
            }
            return CenteredMessage(
              iconColor: Colors.redAccent,
              title: '404',
              subtitle:
                  'Something went wrong, please check your internet connection status',
            );
          }
          final isLoading = snapshot.connectionState == ConnectionState.waiting;
          final data = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: isLoading ? 10 : data!.length,
            itemBuilder: (context, index) {
              final episode = !isLoading ? data![index] : null;
              return TvShowEpisodeTile(
                isLoading: isLoading,
                episodeInfo: episode,
              );
            },
          );
        },
      ),
    );
  }
}
