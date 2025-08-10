import 'package:flutter/material.dart';

class ReviewTextField extends StatelessWidget {
  final void Function(String newValue)? onChanged;
  final void Function(String value)? onSubmitted;
  final String? initialValue;
  const ReviewTextField(
      {super.key, this.initialValue, this.onChanged, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 100,
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        minLines: 3,
        maxLines: 6,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            hintStyle: textTheme.bodyLarge,
            labelStyle: textTheme.bodyLarge,
            hintText: 'Comment (optional)',
            labelText: initialValue),
      ),
    );
  }
}
