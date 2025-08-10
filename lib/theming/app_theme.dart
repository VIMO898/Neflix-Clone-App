import 'package:app/models/general/shimmer_colors_model.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Shared constants
  static const double _iconSize = 26;
  static const double _textFontSize = 18;
  static const String _fontFamily = 'Zain';

  // Shared components

  static TextTheme modifyTextTheme(
    TextTheme base,
    Map<String, double> fontSizeAdjustments,
  ) {
    TextStyle? adjust(TextStyle? style, double delta) {
      if (style == null || style.fontSize == null) return style;
      return style.copyWith(fontSize: style.fontSize! + delta);
    }

    return base.copyWith(
      displayLarge: adjust(
        base.displayLarge,
        fontSizeAdjustments['displayLarge'] ?? 0,
      ),
      displayMedium: adjust(
        base.displayMedium,
        fontSizeAdjustments['displayMedium'] ?? 0,
      ),
      displaySmall: adjust(
        base.displaySmall,
        fontSizeAdjustments['displaySmall'] ?? 0,
      ),
      headlineLarge: adjust(
        base.headlineLarge,
        fontSizeAdjustments['headlineLarge'] ?? 0,
      ),
      headlineMedium: adjust(
        base.headlineMedium,
        fontSizeAdjustments['headlineMedium'] ?? 0,
      ),
      headlineSmall: adjust(
        base.headlineSmall,
        fontSizeAdjustments['headlineSmall'] ?? 0,
      ),
      titleLarge: adjust(
        base.titleLarge,
        fontSizeAdjustments['titleLarge'] ?? 0,
      ),
      titleMedium: adjust(
        base.titleMedium,
        fontSizeAdjustments['titleMedium'] ?? 0,
      ),
      titleSmall: adjust(
        base.titleSmall,
        fontSizeAdjustments['titleSmall'] ?? 0,
      ),
      bodyLarge: adjust(base.bodyLarge, fontSizeAdjustments['bodyLarge'] ?? 0),
      bodyMedium: adjust(
        base.bodyMedium,
        fontSizeAdjustments['bodyMedium'] ?? 0,
      ),
      bodySmall: adjust(base.bodySmall, fontSizeAdjustments['bodySmall'] ?? 0),
      labelLarge: adjust(
        base.labelLarge,
        fontSizeAdjustments['labelLarge'] ?? 0,
      ),
      labelMedium: adjust(
        base.labelMedium,
        fontSizeAdjustments['labelMedium'] ?? 0,
      ),
      labelSmall: adjust(
        base.labelSmall,
        fontSizeAdjustments['labelSmall'] ?? 0,
      ),
    );
  }

  static final shrinkDelta = {
    'displayLarge': -3.0,
    'displayMedium': -3.0,
    'displaySmall': -2.0,
    'headlineLarge': -2.0,
    'headlineMedium': -2.0,
    'headlineSmall': -2.0,
    'titleLarge': -1.0,
    'titleMedium': -1.0,
    'titleSmall': -1.0,
    'bodyLarge': -1.0,
    'bodyMedium': -1.0,
    'bodySmall': -1.0,
    'labelLarge': -1.0,
    'labelMedium': -1.0,
    'labelSmall': -1.0,
  };

  static final iconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(iconSize: _iconSize),
  );

  static final textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: _textFontSize),
    ),
  );

  static final sliderBaseTheme = SliderThemeData(
    trackHeight: 4.0,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4.0),
    valueIndicatorTextStyle: const TextStyle(color: Colors.white),
  );

  static const appBarBaseTheme = AppBarTheme(
    toolbarHeight: kToolbarHeight,
    elevation: 0,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    iconTheme: IconThemeData(size: 26),
  );

  static final dividerTheme = DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 0.2,
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.grey.shade900,
    ),
    useMaterial3: true,
    fontFamily: _fontFamily,
    iconButtonTheme: iconButtonTheme,
    textButtonTheme: textButtonTheme,
    appBarTheme: appBarBaseTheme.copyWith(
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: appBarBaseTheme.titleTextStyle!.copyWith(
        color: Colors.black,
      ),
      backgroundColor: Colors.grey.shade300,
    ),
    dividerTheme: dividerTheme,
    iconTheme: const IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.grey.shade50,
    cardColor: Colors.grey.shade200,
    sliderTheme: sliderBaseTheme.copyWith(
      activeTrackColor: Colors.black,
      inactiveTrackColor: Colors.grey.shade400,
      thumbColor: Colors.black,
      overlayColor: Colors.black.withValues(alpha: 0.1),
      activeTickMarkColor: Colors.black,
      inactiveTickMarkColor: Colors.grey,
      valueIndicatorColor: Colors.grey.shade800,
    ),
    // textTheme: ThemeData.light().textTheme,
    textTheme: modifyTextTheme(ThemeData.light().textTheme, shrinkDelta),
    extensions: <ThemeExtension<dynamic>>[
      ShimmerColorsModel(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
    ],
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.grey.shade100,
    ),
    useMaterial3: true,
    fontFamily: _fontFamily,
    iconButtonTheme: iconButtonTheme,
    textButtonTheme: textButtonTheme,
    appBarTheme: appBarBaseTheme.copyWith(
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    dividerTheme: dividerTheme.copyWith(color: Colors.grey.shade50),
    iconTheme: const IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey.shade900,
    sliderTheme: sliderBaseTheme.copyWith(
      activeTrackColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.white,
      overlayColor: Colors.white.withValues(alpha: 0.1),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.grey,
      valueIndicatorColor: Colors.grey.shade800,
    ),
    // textTheme: ThemeData.dark().textTheme,
    textTheme: modifyTextTheme(ThemeData.dark().textTheme, shrinkDelta),
    extensions: <ThemeExtension<dynamic>>[
      ShimmerColorsModel(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade600,
      ),
    ],
  );
}
