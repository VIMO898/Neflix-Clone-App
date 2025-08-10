import 'package:app/models/general/genre_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvShowGenresProvider = Provider<List<GenreModel>>((ref) {
  final baseImgUrl = 'assets/images/genres/tv-shows';
  final genres = [
    GenreModel(
        id: 10759,
        name: "Action & Adventure",
        localImgSrc: '$baseImgUrl/action-adventure.jpg'),
    GenreModel(
        id: 16, name: "Animation", localImgSrc: '$baseImgUrl/animation.jpg'),
    GenreModel(id: 35, name: "Comedy", localImgSrc: '$baseImgUrl/comedy.jpg'),
    GenreModel(id: 80, name: "Crime", localImgSrc: '$baseImgUrl/crime.jpg'),
    GenreModel(
        id: 99,
        name: "Documentary",
        localImgSrc: '$baseImgUrl/documentary.jpg'),
    GenreModel(id: 18, name: "Drama", localImgSrc: '$baseImgUrl/drama.jpg'),
    GenreModel(
        id: 10751, name: "Family", localImgSrc: '$baseImgUrl/family.jpg'),
    GenreModel(id: 10762, name: "Kids", localImgSrc: '$baseImgUrl/kids.jpg'),
    GenreModel(
        id: 9648, name: "Mystery", localImgSrc: '$baseImgUrl/mystery.jpg'),
    GenreModel(id: 10763, name: "News", localImgSrc: '$baseImgUrl/news.jpg'),
    GenreModel(
        id: 10764, name: "Reality", localImgSrc: '$baseImgUrl/reality.jpg'),
    GenreModel(
        id: 10765,
        name: "Sci-Fi & Fantasy",
        localImgSrc: '$baseImgUrl/sci-fi-fantasy.jpg'),
    GenreModel(id: 10766, name: "Soap", localImgSrc: '$baseImgUrl/soap.jpg'),
    GenreModel(id: 10767, name: "Talk", localImgSrc: '$baseImgUrl/talk.jpg'),
    GenreModel(
        id: 10768,
        name: "War & Politics",
        localImgSrc: '$baseImgUrl/politics.jpg'),
    GenreModel(id: 37, name: "Western", localImgSrc: '$baseImgUrl/western.jpg'),
  ];
  return genres;
});
