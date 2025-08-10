import 'package:app/models/general/genre_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenresProvider = Provider<List<GenreModel>>((ref) {
  final imgBaseUrl = 'assets/images/genres/movies';
  final genres = [
    GenreModel(id: 28, name: "Action", localImgSrc: '$imgBaseUrl/action.jpg'),
    GenreModel(
        id: 12, name: "Adventure", localImgSrc: '$imgBaseUrl/adventure.jpg'),
    GenreModel(
        id: 16, name: "Animation", localImgSrc: '$imgBaseUrl/animation.jpg'),
    GenreModel(id: 35, name: "Comedy", localImgSrc: '$imgBaseUrl/comedy.jpg'),
    GenreModel(id: 80, name: "Crime", localImgSrc: '$imgBaseUrl/crime.jpg'),
    GenreModel(
        id: 99,
        name: "Documentary",
        localImgSrc: '$imgBaseUrl/documentary.jpg'),
    GenreModel(id: 18, name: "Drama", localImgSrc: '$imgBaseUrl/drama.jpg'),
    GenreModel(
        id: 10751, name: "Family", localImgSrc: '$imgBaseUrl/family.jpg'),
    GenreModel(id: 14, name: "Fantasy", localImgSrc: '$imgBaseUrl/fantasy.jpg'),
    GenreModel(id: 36, name: "History", localImgSrc: '$imgBaseUrl/history.jpg'),
    GenreModel(id: 27, name: "Horror", localImgSrc: '$imgBaseUrl/horror.jpg'),
    GenreModel(id: 10402, name: "Music", localImgSrc: '$imgBaseUrl/music.jpg'),
    GenreModel(
        id: 9648, name: "Mystery", localImgSrc: '$imgBaseUrl/mystery.jpg'),
    GenreModel(
        id: 10749, name: "Romance", localImgSrc: '$imgBaseUrl/romance.jpg'),
    GenreModel(
        id: 878,
        name: "Science Fiction",
        localImgSrc: '$imgBaseUrl/sci-fi.jpg'),
    GenreModel(
        id: 10770, name: "TV Movie", localImgSrc: '$imgBaseUrl/tv-movie.jpg'),
    GenreModel(
        id: 53, name: "Thriller", localImgSrc: '$imgBaseUrl/thriller.jpg'),
    GenreModel(id: 10752, name: "War", localImgSrc: '$imgBaseUrl/war.jpg'),
    GenreModel(id: 37, name: "Western", localImgSrc: '$imgBaseUrl/western.jpg'),
  ];
  return genres;
});
