import 'package:app/widgets/feedback/service_rating_slider.dart';
import 'package:app/widgets/general/full_width_elevated_button.dart';
import 'package:flutter/material.dart';

import '../widgets/feedback/review_text_field.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 320,
                    height: 250,
                    child: Image.asset(
                      'assets/images/review_illustration_light.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    'Rate our service',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Overall, how was the help you received from our team?',
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  ServiceRatingSlider(),
                  ReviewTextField(),
                ],
              ),
            ),
          ),
          FullWidthElevatedButton(
            margin: const EdgeInsets.all(18),
            text: 'Review',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
