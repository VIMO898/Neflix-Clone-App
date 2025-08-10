import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../models/general/tmdb_result.dart';
import '../widgets/general/centered_message.dart';

const Map<AllMediaType, IconData> searchTypeIcons = {
  AllMediaType.movies: Icons.movie,
  AllMediaType.tvShows: Icons.live_tv,
  AllMediaType.people: Icons.star,
};

const Map<AllMediaType, CenteredMessage> emptyQueryContent = {
  AllMediaType.movies: CenteredMessage(
    icon: Icons.movie_outlined,
    title: 'Find Movies',
    subtitle:
        "Search for popular films, hidden gems, or your all-time favorites.",
  ),
  AllMediaType.tvShows: CenteredMessage(
    icon: Icons.tv_outlined,
    title: 'Browse TV Shows',
    subtitle: "Find trending series, new episodes, or classic shows to binge.",
  ),
  AllMediaType.people: CenteredMessage(
    icon: Icons.star_outline,
    title: 'Discover People',
    subtitle: 'Look up actors, directors, and famous faces from film and TV.',
  ),
};

TmdbResult<T> mergeTmdbResults<T>(
    TmdbResult<T> existing, TmdbResult<T> incoming) {
  return TmdbResult<T>(
    page: incoming.page,
    totalPages: incoming.totalPages,
    totalResults: incoming.totalResults,
    results: [...existing.results, ...incoming.results],
  );
}
