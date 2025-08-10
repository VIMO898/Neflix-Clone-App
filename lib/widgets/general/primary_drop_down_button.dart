import 'package:flutter/material.dart';

class OutlinedDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String? hint;
  final String? prefixText;
  final void Function(T?) onChanged;

  const OutlinedDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final defaultOutlinedInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: colorScheme.secondary.withValues(alpha: 0.45),
        width: 1.5,
      ),
    );
    final defaultInputContentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 16,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: DropdownButtonFormField<T>(
        value: value,
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, size: 36), // Larger icon
        elevation: 4,

        decoration: InputDecoration(
          contentPadding: defaultInputContentPadding,
          // label: Text('min '),
          filled: false,
          hintText: hint,
          prefixText: prefixText != null ? '$prefixText: ' : null,
          prefixStyle: textTheme.titleSmall,
          border: defaultOutlinedInputBorder,
          focusedBorder: defaultOutlinedInputBorder,
          enabledBorder: defaultOutlinedInputBorder,
        ),
        style: textTheme.titleSmall,
        dropdownColor: theme.cardColor,
        isExpanded: true,
        items: items.map((T item) {
          return DropdownMenuItem<T>(value: item, child: Text(item.toString()));
        }).toList(),
      ),
    );
  }
}
