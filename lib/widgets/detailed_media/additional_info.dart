import 'package:flutter/material.dart';

import '../general/styled_card.dart';
import 'media_heading_text.dart';

class AdditionalInfo extends StatelessWidget {
  final String? spokenLanguages;
  final String? productCountries;
  const AdditionalInfo({
    super.key,
    required this.spokenLanguages,
    required this.productCountries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MediaHeadingText(
          'Additional Information',
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        if (spokenLanguages != null)
          _buildAdditionalInfoCard(
            textTheme,
            label: 'Spoken Languages',
            value: spokenLanguages!,
          ),
        if (productCountries != null)
          _buildAdditionalInfoCard(
            textTheme,
            label: 'Production Countries',
            value: productCountries!,
          ),
      ],
    );
  }

  StyledCard _buildAdditionalInfoCard(
    TextTheme textTheme, {
    required String label,
    required String value,
  }) {
    return StyledCard(
      // color: Colors.grey.shade900.withValues(alpha: 0.7),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(value, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
