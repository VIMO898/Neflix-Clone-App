import 'package:app/providers/boxes/liked_movie_box_provider.dart';
import 'package:app/providers/boxes/liked_tv_show_box_provider.dart';
import 'package:app/repositories/liked_media_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likedMediaRepoProvider = Provider((ref) {
  final likedMovieBox = ref.watch(likedMovieBoxProvider);
  final likedTvShowBox = ref.watch(likedTvShowBoxProvider);
  return LikedMediaRepository(
      likedMovieBox: likedMovieBox, likedTvShowBox: likedTvShowBox);
});
