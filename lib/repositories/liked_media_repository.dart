import 'package:app/repositories/hive_media_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikedMediaRepository extends HiveMediaRepository {
  final Box likedMovieBox;
  final Box likedTvShowBox;
  const LikedMediaRepository(
      {required this.likedMovieBox, required this.likedTvShowBox})
      : super(movieBox: likedMovieBox, tvShowBox: likedTvShowBox);
}
