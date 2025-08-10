import '../constants/enums.dart';

String? getTmdbImageUrl({
  required ImageType type,
  required ImageSize size,
  required String filePath,
}) {
  if (filePath.isEmpty) return null;
  final sizeStr =
      validSizes[type]!.contains(size) ? size.name : ImageSize.original.name;
  return 'https://image.tmdb.org/t/p/$sizeStr$filePath';
}

const Map<ImageType, List<ImageSize>> validSizes = {
  ImageType.poster: [
    ImageSize.w92,
    ImageSize.w154,
    ImageSize.w185,
    ImageSize.w342,
    ImageSize.w500,
    ImageSize.w780,
    ImageSize.original
  ],
  ImageType.backdrop: [
    ImageSize.w300,
    ImageSize.w780,
    ImageSize.w1280,
    ImageSize.original
  ],
  ImageType.logo: [
    ImageSize.w45,
    ImageSize.w92,
    ImageSize.w154,
    ImageSize.w185,
    ImageSize.w300,
    ImageSize.w500,
    ImageSize.original
  ],
  ImageType.profile: [
    ImageSize.w45,
    ImageSize.w185,
    ImageSize.h632,
    ImageSize.original
  ],
  ImageType.still: [
    ImageSize.w92,
    ImageSize.w185,
    ImageSize.w300,
    ImageSize.original
  ],
};
