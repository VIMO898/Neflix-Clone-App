import 'enums.dart';

const Map<MediaVideoType, String> mediaVideoTypeToString = {
  MediaVideoType.trailer: 'Trailer',
  MediaVideoType.teaser: 'Teaser',
  MediaVideoType.bloopers: 'Bloopers',
  MediaVideoType.clip: 'Clip',
  MediaVideoType.behindTheScenes: 'Behind the Scenes',
  MediaVideoType.featurette: 'Featurette',
  MediaVideoType.openingCredits: 'Opening Credits',
};

final stringToMediaVideoType = mediaVideoTypeToString.map(
  (key, value) => MapEntry(value, key),
);
