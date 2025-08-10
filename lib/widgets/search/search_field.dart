import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const SearchField({
    super.key,
    this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final titleLarge = textTheme.titleLarge;
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            size: 28,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 6)),
          hintText: hintText,
          hintStyle: titleLarge?.copyWith(fontSize: 20, color: secondaryColor),
          labelStyle: titleLarge?.copyWith(fontSize: 20, color: primaryColor),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 22)),
    );
  }
}
