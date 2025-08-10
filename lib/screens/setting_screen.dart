import 'package:app/widgets/settings/categories/app_settings.dart';
import 'package:app/widgets/settings/categories/contact_with_us.dart';
import 'package:app/widgets/settings/categories/help_and_support.dart';
import 'package:app/widgets/settings/categories/storage_and_cache.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSettings(),
            StorageAndCache(),
            HelpAndSupport(),
            ContactWithUs(),
          ],
        ),
      ),
    );
  }
}
