String formatUSCurrency(num number) {
  if (number >= 1_000_000_000_000) {
    return "\$${(number / 1_000_000_000_000).toStringAsFixed(1)}T";
  } else if (number >= 1_000_000_000) {
    return "\$${(number / 1_000_000_000).toStringAsFixed(1)}B";
  } else if (number >= 1_000_000) {
    return "\$${(number / 1_000_000).toStringAsFixed(1)}M";
  } else if (number >= 1_000) {
    return "\$${(number / 1_000).toStringAsFixed(1)}K";
  } else {
    return "\$${number.toStringAsFixed(1)}";
  }
}