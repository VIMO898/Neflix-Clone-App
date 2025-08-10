import 'package:flutter/material.dart';

class ServiceRatingSlider extends StatefulWidget {
  const ServiceRatingSlider({super.key});

  @override
  State<ServiceRatingSlider> createState() => _ServiceRatingSliderState();
}

class _ServiceRatingSliderState extends State<ServiceRatingSlider> {
  double _currentValue = 2; // Default to "Average"
  final List<String> labels = ["Worst", "Poor", "Average", "Good", "Best"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            min: 0,
            max: 4,
            divisions: 4, // 5 points = 4 divisions
            value: _currentValue,
            label: labels[_currentValue.round()],
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels
                .map((label) => Text(label, style: textTheme.bodySmall))
                .toList(),
          ),
        ],
      ),
    );
  }
}
