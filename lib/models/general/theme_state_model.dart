// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

class ThemeStateModel {
  final String fontFamily;
  final ThemeMode themeMode;
  final bool useSystem;
  ThemeStateModel({
    required this.fontFamily,
    required this.themeMode,
    required this.useSystem,
  });

  @override
  String toString() =>
      'ThemeStateModel(fontFamily: $fontFamily, themeMode: $themeMode, useSystem: $useSystem)';

  ThemeStateModel copyWith({
    String? fontFamily,
    ThemeMode? themeMode,
    bool? useSystem,
  }) {
    return ThemeStateModel(
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
      useSystem: useSystem ?? this.useSystem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fontFamily': fontFamily,
      'themeMode': themeMode.index,
      'useSystem': useSystem,
    };
  }

  factory ThemeStateModel.fromMap(Map<String, dynamic> map) {
    return ThemeStateModel(
      fontFamily: map['fontFamily'],
      themeMode: ThemeMode.values[map['themeMode']],
      useSystem: map['useSystem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeStateModel.fromJson(String source) =>
      ThemeStateModel.fromMap(json.decode(source));
}
