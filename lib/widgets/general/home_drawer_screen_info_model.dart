// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

class HomeDrawerScreenInfoModel {
  final String title;
  final IconData icon;
  final Widget screen;
  final bool isDedicatedScreen;
  HomeDrawerScreenInfoModel({
    required this.title,
    required this.icon,
    required this.screen,
    this.isDedicatedScreen = false,
  });
}
