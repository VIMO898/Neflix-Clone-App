String formatRuntime(int runtimeInMinutes) {
  final hours = runtimeInMinutes ~/ 60;
  final minutes = runtimeInMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return '$hours h $minutes min';
  } else if (hours > 0) {
    return '$hours h';
  } else {
    return '$minutes min';
  }
}
