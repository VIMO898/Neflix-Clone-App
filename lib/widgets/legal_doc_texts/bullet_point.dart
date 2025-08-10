import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich(
          TextSpan(children: [
            TextSpan(text: '• ', style: const TextStyle(fontSize: 24)),
            TextSpan(text: text)
          ]),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              )),
    );
  }
}
