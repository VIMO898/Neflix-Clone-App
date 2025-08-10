import 'package:flutter/material.dart';

class LabelIconButton extends StatelessWidget {
  const LabelIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = icon.fontPackage == 'font_awesome_flutter' ? 28.0 : 32.0;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(icon, size: iconSize),
          const SizedBox(width: 16),
          Text(
            label,
            style:
                textTheme.headlineSmall!.copyWith(color: Colors.blue.shade200),
          )
        ]),
      ),
    );
  }
}
