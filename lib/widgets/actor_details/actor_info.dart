import 'package:flutter/material.dart';

import '../general/text_title_large.dart';

class ActorInfo extends StatelessWidget {
  const ActorInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textPrimaryColor = theme.colorScheme.primary;
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Row(children: [
        SizedBox(
          width: 140,
          height: 200,
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Liam_Hemsworth_June_2016.jpg/220px-Liam_Hemsworth_June_2016.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Liam Hemsworth',
                style:
                    textTheme.headlineMedium!.copyWith(color: textPrimaryColor),
              ),
              const SizedBox(height: 8),
              const TextTitleLarge('Character: Owen Brophy'),
              const SizedBox(height: 4),
              const TextTitleLarge('Known For: Acting'),
              const SizedBox(height: 4),
              const TextTitleLarge('Birthday: 1990-01-13'),
              const SizedBox(height: 4),
              const TextTitleLarge(
                  'Place of Birth: Melbourne, Victoria, Australia'),
            ],
          ),
        )
      ]),
    );
  }
}
